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
email VARCHAR(150) );
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

Order By single column
```sql
SELECT * FROM person ORDER BY id DESC;
```

Order By multiple columns
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
