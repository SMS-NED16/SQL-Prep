# Can access SQLite3 from Python using DB-API 2.0 interface

import sqlite3

# Establish a connection with the database
conn = sqlite3.connect('thw.db')

# Then need a cursor from that connection - defines entry point of queries
cursor = conn.cursor()

# Any SQL queries we want to execute are passed as strings to the execute method
cursor.execute("""
SELECT * FROM person, person_pet, pet
	WHERE person.id = person_pet.person_id AND pet.id = person_pet.pet_id;
	""")

# Echoing the SQL query that is waiting to be written to the SQLite database
for row in cursor:
	print row

# When ready to commit the queries results to the DB, use commit. 
# Only necessary if changing the database 
# conn.commit();

# One finished executing all SQL queries, terminate the DB connection
conn.close()