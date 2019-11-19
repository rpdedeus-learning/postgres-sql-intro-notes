# Postgres SQL Tutorial Notes

### INSTALLATION

[postgresapp](https://postgresapp.com/)


### PSQL META COMMANDS

[Docs](https://www.postgresql.org/docs/12/app-psql.html)

| command         | description                |
| --------------- | -------------------------- |
| \c              | connect                    |
| \l              | list databases             |
| \d              | list visible tables        |
| \d <table_name> | list table details         |
| \i FILE         | execute commands from file |
| \q              | quit                       |
| \x              | toggle expanded display    |


### CREATING A DATABASE

```sql
CREATE DATABASE test;
```


### DROPPING A DATABASE

```sql
DROP DATABASE test;
```


### CREATING A TABLE

```sql
CREATE TABLE person (
  id int,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  gender VARCHAR(7),
  date_of_birth DATE
);
```


### DROPPING A TABLE

```sql
DROP TABLE person;
```


### CREATING A TABLE WITH CONSTRAINTS

```sql
CREATE TABLE person (
  id BIGSERIAL NOT NULL PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  gender VARCHAR(7) NOT NULL,
  date_of_birth DATE NOT NULL,
  email VARCHAR(150)
);
```


### INSERT STATEMENT

```sql
INSERT INTO person (
  first_name,
  last_name,
  gender,
  date_of_birth
)
VALUES (
  'Anne', 'Smith', 'FEMALE', DATE '1988-01-09'
);

INSERT INTO person (
  first_name,
  last_name,
  gender,
  date_of_birth,
  email
)
VALUES (
  'Jake', 'Jones', 'MALE', DATE '1990-01-10', 'jake@gmail.com'
);
```


### GENERATING MOCK DATA

[Mockaroo](https://mockaroo.com/)


Before proceeding, inspect and run the person.sql script.
```
\i person.sql
```


### SELECT STATEMENT

```sql
SELECT * FROM person;
```

```sql
SELECT first_name, last_name FROM person;
```


### ORDER BY CLAUSE

| Type       | Value | Example       |
| ---------- | ----- | ------------- |
| Ascending  | ASC   | 1, 2, 3, 4, 5 |
| Descending | DESC  | 5, 4, 3, 2, 1 |


* ORDER BY defaults to ASC order if no other value is specified.

ORDER BY single column
```sql
SELECT * FROM person ORDER BY id DESC;
```

ORDER BY multiple columns
```sql
SELECT * FROM person ORDER BY first_name, email DESC;
```


### DISTINCT CLAUSE

```sql
SELECT DISTINCT country_of_birth FROM person ORDER BY country_of_birth;
```


### WHERE CLAUSE

Filter data based on conditions

```sql
SELECT * FROM person WHERE gender = 'Male';
```


### AND KEYWORD

```sql
SELECT * FROM person WHERE gender='Female' AND country_of_birth = 'Brazil';
```


### OR KEYWORD

```sql
SELECT * FROM person WHERE first_name = 'Robert' OR first_name = 'Cash';
```


### COMPARISON OPERATORS

| Operator | Description              |
| -------- | ------------------------ |
| =        | equal to                 |
| <>       | not equal to             |
| >        | greater than             |
| >=       | greater than or equal to |
| <        | less than                |
| <        | less than or equal to    |

```sql
SELECT 1 = 1;
```

```sql
SELECT * from person WHERE date_of_birth >= '2018-10-15'::date AND date_of_birth <= '2018-11-01'::date;
```


### LIMIT KEYWORD

Limit number of returned results to 10 records.
```sql
SELECT * FROM person LIMIT 10;
```


### FETCH KEYWORD

Same as LIMIT but SQL standard.
```sql
SELECT * FROM person FETCH FIRST 5 ROW ONLY;
```


### OFFSET KEYWORD

```sql
SELECT * FROM person OFFSET 5 LIMIT 10;
```


### IN KEYWORD

Selecting all people from China, Brazil or France.
```sql
SELECT * FROM person WHERE country_of_birth = 'China' OR country_of_birth = 'Brazil' OR country_of_birth = 'France';
```

Using the IN keyword, the statement can be re-written as
```sql
SELECT * FROM person WHERE country_of_birth IN ('China', 'France', 'Brazil');
```


### BETWEEN KEYWORD

Select data from a range.

```sql
SELECT * FROM person WHERE date_of_birth BETWEEN DATE '2018-10-01' AND '2018-10-15';
```


### LIKE OPERATOR

Used to match text values against a pattern using wild cards.

```sql
SELECT * FROM person WHERE email LIKE '%.com';
```

```sql
SELECT * FROM person WHERE email lIKE '%@mozilla.%';
```

Use _ to match single chars
```sql
SELECT * FROM person WHERE email lIKE '________@%'
```


### ILIKE OPERATOR

Same as like but case insensitive.
```sql
SELECT * FROM person WHERE country_of_birth ILIKE 'p%';
```


### GROUP BY CLAUSE

```sql
SELECT COUNT(id), country_of_birth FROM person GROUP BY country_of_birth ORDER BY count DESC;
```


### HAVING CLAUSE

Add an extra filter after performing aggregation.

```sql
SELECT COUNT(id), country_of_birth FROM person GROUP BY country_of_birth HAVING COUNT(id) > 10 ORDER BY count ASC;
```


### AGGREGATE FUNCTIONS

[Docs](https://www.postgresql.org/docs/12/functions-aggregate.html)


Before proceeding, inspect and run the car.sql script.
```
\i car.sql
```


### MAXIMUM

```sql
SELECT MAX(price) FROM car;
```


### MINIMUM

```sql
SELECT MIN(price) FROM car;
```

Get lowest price for all make and models.
```sql
SELECT make, model, MIN(price) FROM car GROUP BY make, model;
```


### AVERAGE

```sql
SELECT AVG(price) FROM car;
```


### ROUND

```sql
SELECT ROUND(AVG(price)) FROM car;
```


### SUM

```sql
SELECT SUM(price) FROM car;
```


### ARITHMETIC OPERATORS

| Symbol | Description    |
| ------ | -------------- |
| +      | Addition       |
| -      | Subtraction    |
| *      | Multiplication |
| /      | Division       |
| ^      | Exponentiation |
| !      | Factorial      |
| %      | Modulo         |


```sql
SELECT 1 + 1;       # 1
SELECT 4 - 2;       # 2
SELECT 7 * 7;       # 49
SELECT 100 / 10;    # 10
SELECT 3 ^ 3;       # 27
SELECT 5!;          # 5 * 4 * 3 * 2 * 1 = 120
SELECT 10 % 3;      # 1
```

Get the value of an item with a discount.
```sql
SELECT id, make, model, price, price * .90 FROM car LIMIT 10;
```


### ALIAS KEYWORD

```sql
SELECT id, make, model, price, price * .90 AS discounted_price FROM car LIMIT 10;
```


### COALESCE KEYWORD

If value not present, attempt to use the next value in the array.
```sql
SELECT COALESCE(null, 1);  # 1
SELECT COALESCE(email, 'EMAIL-NOT-PROVIDED') FROM person;
```


### NULLIF KEYWORD

Returns the first argument if the second argument is not equal to the first.
```sql
SELECT NULLIF(10, 1);    # 10
SELECT NULLIF(10, 10);   # NULL
```

Useful for preventing division by zero.

```sql
SELECT 10 / 0;                         # ERROR:  division by zero
SELECT 10 / NULL;                      # NULL
SELECT COALESCE(10 / NULLIF(0, 0), 0); # 0
```


### TIMESTAMPS AND DATES

[Docs](https://www.postgresql.org/docs/12/datatype-datetime.html)

```sql
SELECT NOW();        # TIMESTAMP
SELECT NOW()::DATE;  # CAST TO DATE
SELECT NOW()::TIME;  # CAST TO TIME
```

Date subtraction.
```sql
SELECT NOW() - INTERVAL '10 YEAR';    # CAN ALSO USE YEARS
SELECT NOW() - INTERVAL '10 MONTH';   # CAN ALSO USE MONTHS
SELECT NOW() - INTERVAL '10 DAY';     # CAN ALSO USE DAYS
```

Date addition.
```sql
SELECT NOW() + INTERVAL '10 YEAR';    # CAN ALSO USE YEARS
SELECT NOW() + INTERVAL '10 MONTH';   # CAN ALSO USE MONTHS
SELECT NOW() + INTERVAL '10 DAY';     # CAN ALSO USE DAYS
```

Casting entire statement.
```sql
SELECT DATE(NOW() + INTERVAL '10 MONTHS');
```


### EXTRACT

Extract values from a given TIMESTAMP.
```sql
SELECT EXTRACT(YEAR FROM NOW());    # YEAR          2019
SELECT EXTRACT(MONTH FROM NOW());   # MONTH         10
SELECT EXTRACT(DAY FROM NOW());     # DAY           10
SELECT EXTRACT(DOW FROM NOW());     # DAY OF WEEK   4 (THURSDAY)
SELECT EXTRACT(CENTURY FROM NOW()); # CENTURY       21
```


### AGE

```sql
SELECT first_name, last_name, gender, country_of_birth, date_of_birth, AGE(NOW(), date_of_birth) AS age FROM person;
```


### PRIMARY KEYS

Uniquely identifies a record in a table.


### CONSTRAINTS

The person table has a constraint associated with it to prevent duplicate ids. If an INSERT statement attempts to add a user with the same ID on this table, the following error will be issued:
```none
ERROR:  duplicate key value violates unique constraint "person_pkey"
```

Dropping a constraint.
```sql
ALTER TABLE person DROP CONSTRAINT person_pkey;
```

Adding PRIMARY KEY constraint
```sql
ALTER TABLE person ADD PRIMARY KEY (id);
```


### DELETE RECORDS

```sql
DELETE FROM person WHERE id = 1;
```


### CREATING UNIQUE CONSTRAINTS

Create a unique constraint allowing Postgres to name it.
```sql
ALTER TABLE person ADD UNIQUE(email);
```

Create a unique constraint providing Postgres with a custom name for the same.
```sql
ALTER TABLE person ADD CONSTRAINT unique_email_address UNIQUE(email);
```


### CHECK CONSTRAINTS

```sql
ALTER TABLE PERSON ADD CONSTRAINT gender_constraint CHECK (gender = 'Female' OR gender = 'Male' OR gender='Other');
```


### ALTER RECORDS

```sql
UPDATE person SET first_name = 'Marg', mail = 'marg@columbia.edu' WHERE id = 1;
```


### ON CONFLICT, DO NOTHING

```sql
INSERT INTO person (id, first_name, last_name, gender, date_of_birth, email, country_of_birth)
VALUES (1, 'Martguerita', 'Riddoch', 'Female', '2019-09-05', 'mriddoch0@columbia.edu', 'Sweden')
ON CONFLICT (id) DO NOTHING;
```


### DO UPDATE

```sql
INSERT INTO person (id, first_name, last_name, gender, date_of_birth, email, country_of_birth)
VALUES (1, 'Martguerita', 'Riddoch', 'Female', '2019-09-05', 'mriddoch0@dc.gov', 'Sweden')
ON CONFLICT (id) DO UPDATE SET email = EXCLUDED.email;
```


### FOREIGN KEY

A foreign key is a column that references a primary key in another table.


### ONE TO ONE RELATIONSHIPS

A car has a vin number.
A vin number can only be associated with one car.

Before proceeding, inspect and run the vin_number.sql script.
```
\i vin_number.sql
```


### INNER JOINS

An inner join returns the items that are common in both tables.

```sql
SELECT * FROM car JOIN vin_number ON car.vin_id = vin_number.id;
```


### LEFT JOINS

A left join includes all of the rows from the left table with the corresponding rows on the right table.

```sql
SELECT * FROM car LEFT JOIN vin_number ON car.vin_id = vin_number.id WHERE car.id < 5;
```


### ONE TO MANY RELATIONSHIPS

A car can have multiple service records.
A service record can only be associated with one car.


Before proceeding, inspect and run the service_record.sql script.
```
\i service_record.sql
```

```sql
SELECT * FROM car JOIN service_record ON car.id = service_record.id;
```


### MANY TO MANY RELATIONSHIPS

A person can own many vehicles.
A car can have multiple owners.


Before proceeding, inspect and run the person_car_mapping.sql script.
```
\i person_car_mapping.sql
```

```sql
SELECT p.id AS PERSON_ID, p.first_name, p.last_name, c.id AS CAR_ID, c.make, c.model 
FROM person AS p, car AS c, person_car_mapping as pc 
WHERE pc.car_id = c.id AND pc.person_id = p.id; 
```
