DROP TABLE pets;
DROP TABLE kinds;
DROP TABLE customers;

CREATE TABLE customers (
    id SERIAL8 primary key,
    name VARCHAR(255)
);

CREATE TABLE kinds (
	id SERIAL8 primary key,
	name VARCHAR(255),
    group_name VARCHAR(255)
);

CREATE TABLE pets (
    id SERIAL8 primary key,
    name VARCHAR(255),
    kind_id INT8 references kinds(id) ON DELETE CASCADE,
    entry DATE,
    exit DATE,
    owner_id INT8 references customers(id) ON DELETE SET NULL
);

