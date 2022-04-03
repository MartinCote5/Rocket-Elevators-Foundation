CREATE TABLE factquotes (
    quote_id serial PRIMARY KEY,
    creation date NOT NULL,
    company_name text NOT NULL,
    email text NOT NULL,
    elevator_amount integer NOT NULL
);

CREATE TABLE factcontact (
    contact_id serial PRIMARY KEY,
    creation_date date NOT NULL,
    company_name text NOT NULL,
    email text NOT NULL,
    project_name text NOT NULL
);

CREATE TABLE factelevator (
    serial_number serial PRIMARY KEY,
    date_Of_commissioning date NOT NULL,
    building_id serial NOT NULL,
    customer_id serial NOT NULL,
    building_city text NOT NULL
);

CREATE TABLE dimcustomers (
    creation_date date PRIMARY KEY,
    company_name text NOT NULL,
    full_name_of_the_company_main_contact text NOT NULL,
    email_of_the_company_main_contact text NOT NULL,
    elevator_amount integer NOT NULL,
    customer_city text NOT NULL
);

CREATE TABLE factintervention (
    intervention_id serial PRIMARY KEY,
    employee_id bigint NOT NULL,
    building_id bigint NOT NULL,
    battery_id bigint,
    column_id bigint,
    elevator_id bigint,
    start_date_and_time_of_the_intervention timestamp NOT NULL,
    end_date_and_time_of_the_intervention timestamp,
    result text NOT NULL,
    report text,
    status_of_the_intervention text NOT NULL
);