DROP TABLE pets;
DROP TABLE species;
DROP TABLE customers;

CREATE TABLE customers (
    id SERIAL8 primary key,
    name VARCHAR(255)
);

CREATE TABLE species (
	id SERIAL8 primary key,
	name VARCHAR(255)
);

CREATE TABLE pets (
    id SERIAL8 primary key,
    name VARCHAR(255),
    species_id INT8 references species(id) ON DELETE CASCADE,
    entry DATE,
    exit DATE,
    owner_id INT8 references customers(id) ON DELETE SET NULL
);

