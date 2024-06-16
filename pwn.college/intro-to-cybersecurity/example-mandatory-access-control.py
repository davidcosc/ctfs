import os
import re


"""
Theory:
	Within the classic mandatory access controll system by Bell-LaPadula
	it can be mathematically proven, that there will not be any information
	leakage. This holds only if subject can only read objects with a lower
	or equal level within a subset of the subjects categories. Also the subject
	can only write objects where the objects level is higher or equal to the subjects
	level and the subjects categories are a subset of the objects categories.
class Level:
    def __init__(self, name: str, level: int):
        self.name = name
        self.level = level

class Category:
    def __init__(self, name: str, bit: int):
        self.name = name
        self.bit = bit

def category_set_to_str(set_: int, categories: List[Category]) -> str:
    category_names = []
    for category in categories:
        if set_ & category.bit:
            category_names.append(category.name)
    return "{" + ", ".join(category_names) + "}"

def is_subset_equal(a: int, b: int) -> bool:
    return (b | a) == b

LEVELS = [Level("TS", 4),
        Level("S", 3),
        Level("C", 2),
        Level("UC", 1)]

CATEGORIES = [
        Category("NUC", 1),
        Category("NATO", 1 << 1),
        Category("ACE", 1 << 2),
        Category("UFO", 1 << 3)
    ]

    num_levels = 40
    num_categories = 5

    levels = []
    names = set()
    for i in range(num_levels):
        name = ''.join(random.choices(string.ascii_lowercase + string.ascii_uppercase, k=8))
        if not name in names:
            levels.append(Level(name, i+1))
            names.add(name)

    categories = []
    cat_names = set()
    for i in range(num_categories):
        name = ''.join(random.choices(string.ascii_uppercase, k=3))
        if not name in cat_names:
            categories.append(Category(name, 1 << i))
            cat_names.add(name)

    mac_challenge(128, 1, custom_levels=levels, custom_categories=categories, use_flag_seed=False)
"""


def categories_to_int(category_list, categories):
	sum = 0
	for category in category_list:
		sum += categories[category]
	return sum


def is_subset_of(a, b):
	return (b | a) == b


#levels = {"TS": 4, "S": 3, "C": 2, "UC": 1}
#categories = {"NUC": 1, "NATO": 1 << 1, "ACE": 1 << 2, "UFO": 1 << 3}
levels = {}
categories = {}
pat0 = re.compile(r"40 Levels \(first is highest aka more sensitive\):\n")
pat1 = re.compile(r"5 Categories:\n")
pat2 = re.compile(r".*Can a Subject with level (.*) and categories (.*) (.*) an Object with level (.*) and categories (.*)\?")
r_pipe0, w_pipe0 = os.pipe()
r_pipe1, w_pipe1 = os.pipe()

pid = os.fork()

if pid == -1:
	print("Error fork.")
	exit(1)

if pid == 0:
	os.close(w_pipe0)
	os.close(r_pipe1)

	os.dup2(r_pipe0, 0)
	os.close(r_pipe0)

	os.dup2(w_pipe1, 1)
	os.close(w_pipe1)

	os.execv("/challenge/run", ["/challenge/run"])
	print("Error execv.")
	exit(1)

os.close(r_pipe0)
os.close(w_pipe1)

output = os.fdopen(r_pipe1, "r")
input = os.fdopen(w_pipe0, "wb")

while True:
	line = output.readline()
	print(line, end="")
	m = pat0.match(line)
	if m:
		for i in range(40):
			line = output.readline()
			print(line, end="")
			levels[line.strip()] = 40 - i
	m = pat1.match(line)
	if m:
		for i in range(5):
			line = output.readline()
			print(line, end="")
			categories[line.strip()] = 1 << i
		break


print(f"Levels={levels}")
print(f"Categories={categories}")

while True:
	line = output.readline()
	print(line, end="")
	m = pat2.match(line)
	if m:
		subject = m.group(1)
		if m.group(2) == "{}":
			subject_categories = ["EMPTY"]
			subject_category_int = 0
		else:
			subject_categories = m.group(2).replace("{", "").replace("}", "").split(", ")
			subject_category_int = categories_to_int(subject_categories, categories)
		action = m.group(3)
		object = m.group(4)
		if m.group(5) == "{}":
			object_categories = ["EMPTY"]
			object_category_int = 0
		else:
			object_categories = m.group(5).replace("{", "").replace("}", "").split(", ")
			object_category_int = categories_to_int(object_categories, categories)
		print(f"sub={subject}, sub_cat={subject_categories}, sub_cat_int={subject_category_int}, action={action}, obj={object}, obj_cat={object_categories}, obj_cat_int={object_category_int}")
		answer = b"no"
		if action == "read" and levels[subject] >= levels[object] and is_subset_of(object_category_int, subject_category_int):
			answer = b"yes"
		elif action == "write" and levels[subject] <= levels[object] and is_subset_of(subject_category_int, object_category_int):
			answer = b"yes"
		print(f"Answer {answer}")
		input.write(answer + b"\n")
		input.flush()

