DROP TABLE pets;
DROP TABLE customers;

CREATE TABLE customers (
    id SERIAL8 primary key,
    name VARCHAR(255)
);

CREATE TABLE pets (
    id SERIAL8 primary key,
    name VARCHAR(255),
    species VARCHAR(255),
    entry DATE,
    exit DATE,
    owner_id INT8 references customers(id) ON DELETE SET NULL
);