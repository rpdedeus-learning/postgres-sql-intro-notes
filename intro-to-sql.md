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

```sql
SELECT * from person WHERE date_of_birth >= '2018-10-15'::date AND date_of_birth <= '2018-11-01'::date;
```

### OR KEYWORD

```sql
SELECT * FROM person WHERE first_name = 'Robert' OR first_name = 'Cash';
```

### Comparison Operators
