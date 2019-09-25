import random
from  datetime import timedelta, datetime

# Use list comprehension to open `words.txt`, read all its lines into a list
# capitalize the first letter of each line (in this case each word)
# and then strip any leading or trailing whitespace from the line
words = [x.strip().capitalize() for x in open('words.txt').readlines()]
breeds = ['Dog', 'Cat', 'Fish', 'Unicorn']

# The first half of the words in the file are pet names
pet_names = words[:len(words) / 2]

# The remaining words in the list are owner names
owner_names = words[len(words) / 2: ]

# Defining SQL query strings for inserting person, pet, and person_pet relations
# Any values that are expected to be TEXT are enclosed in single quotation marks ''
owner_insert = """INSERT INTO person
	VALUES(NULL, '{first}', '{last}', '{age}', '{dob}');"""
pet_insert = """INSERT INTO pet
	VALUES(NULL, '{name}', '{breed}', '{age}', '{dead}');"""
relate_insert = """INSERT INTO person_pet
	VALUES({person_id}, {pet_id}, '{purchased_on}');"""

# A list to store all SQL queries made using the dataset
sql = []

# Returns a random date
def random_date():
	# Automatically converting days to years for calculation downstream
	years = 365 * random.randint(0, 50) 
	days = random.randint(0, 365)
	hours = randomn.randint(0, 24)

	# Returns a `timedelta` object that defines a change in time in terms of days and hours
	past = timedelta(days=years + days, hours=hours)

	# The random date returned will be at a random point in the past from today's date
	return datetime.now() - past


# Make a bunch of random pets
for i in range(0, 100):
	# Initialise random features for each pet
	age = random.randint(0, 20)
	breed = random.choice(breeds)
	name = random.choice(pet_names)
	dead = random.randint(0, 1)

	# Append text for an INSERT query that will add a new pet record using these values
	sql.append(pet_insert.format(
		age=age, breed=breed, name=name, dead=dead))

# Make a bunch of random people
for i in range(0, 100):
	age = random.randint(0, 100)
	first = random.choice(owner_names)
	last = random.choice(owner_names)
	dob = random_date()

	sql.append(owner_insert.format(
		age=age, first=first, last=last, dob=dob))

"""Only sample from the middle of IDs to connect pets and people.
This avoids the first few IDs that have been taken in the db and
ensures some unowned pets and owners without pets."""
for i in range(0, 75):
	person_id = random.randint(5, 95)
	pet_id = random.randint(5, 95)
	purchased_on = random_date()

	sql.append(relate_insert.format(
		person_id=person_id, pet_id=pet_id, purchased_on=purchased_on))

# Open a file "ex-15.sql" to write Python-generated queries to it
# This is destructive. Normally your would check and ask to overwrite.
with open("ex-15.sql", "w") as output:
	output.write("\n".join(sql))