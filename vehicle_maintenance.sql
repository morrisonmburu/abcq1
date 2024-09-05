-- Vehicle Maintenance for ABC Service Station SQL Script
--
-- Host: 127.0.0.1 port: 5432    Database: PostgreSQL
-- ------------------------------------------------------
-- CREATE DATABASE
-- ------------------------------------------------------
CREATE DATABASE vehicle_maintenance;
-- ------------------------------------------------------
-- Table structure for table 'owners'
-- ------------------------------------------------------
CREATE TABLE public.owners (
	id bigserial NOT NULL,
	"name" varchar(255) NOT NULL,
	email varchar(50) NOT NULL,
	phone varchar(20) NOT NULL,
	created_at timestamp(0) NULL,
	updated_at timestamp(0) NULL,
	deleted_at timestamp(0) NULL,
	CONSTRAINT owners_email_unique UNIQUE (email),
	CONSTRAINT owners_phone_unique UNIQUE (phone),
	CONSTRAINT owners_pkey PRIMARY KEY (id)
);
-- ------------------------------------------------------
-- Insert a few records into the 'owners' table
-- ------------------------------------------------------
INSERT INTO public.owners (id, "name", email, phone, created_at, updated_at, deleted_at) 
VALUES (1, 'John Doe', 'johndoe@mail.com', '07000001', '2024-09-04 00:00:00', '2024-09-04 00:00:00', NULL)
, (2, 'Jane Doe', 'janedoe@mail.com', '07000002', '2024-09-04 00:00:00', '2024-09-04 00:00:00', NULL)
-- ------------------------------------------------------
-- Table structure for table 'vehicle_models'
-- ------------------------------------------------------
CREATE TABLE public.vehicle_models (
	id bigserial NOT NULL,
	make varchar(255) NOT NULL,
	model varchar(255) NOT NULL,
	"year" int4 NOT NULL,
	engine_type varchar(255) NOT NULL,
	fuel_type varchar(255) NOT NULL,
	transmission varchar(255) NOT NULL,
	body_style varchar(255) NOT NULL,
	drivetrain varchar(255) NOT NULL,
	horsepower varchar(255) NOT NULL,
	color varchar(255) NOT NULL,
	created_at timestamp(0) NULL,
	updated_at timestamp(0) NULL,
	deleted_at timestamp(0) NULL,
	CONSTRAINT vehicle_models_pkey PRIMARY KEY (id)
);
-- ------------------------------------------------------
-- Insert a few records into the 'vehicle_models' table
-- ------------------------------------------------------
INSERT INTO public.vehicle_models (id, make, model, "year", engine_type, fuel_type, transmission, body_style, drivetrain, horsepower, color, created_at, updated_at, deleted_at)
VALUES (1, 'Toyota', 'Corolla', 2019, 'V4', 'Petrol', 'Automatic', 'Sedan', 'FWD', '140', 'White', '2024-09-04 00:00:00', '2024-09-04 00:00:00', NULL)
, (2, 'Toyota', 'Camry', 2019, 'V6', 'Petrol', 'Automatic', 'Sedan', 'FWD', '200', 'Black', '2024-09-04 00:00:00', '2024-09-04 00:00:00', NULL)
-- ------------------------------------------------------
-- Table structure for table 'vehicles'
-- ------------------------------------------------------
CREATE TABLE public.vehicles (
	id bigserial NOT NULL,
	owner_id int8 NOT NULL,
	vehicle_model_id int8 NOT NULL,
	description text NOT NULL,
	registration_number varchar(255) NOT NULL,
	vin varchar(255) NULL,
	mileage varchar(255) NOT NULL,
	created_at timestamp(0) NULL,
	updated_at timestamp(0) NULL,
	deleted_at timestamp(0) NULL,
	CONSTRAINT vehicles_pkey PRIMARY KEY (id),
	CONSTRAINT vehicles_registration_number_unique UNIQUE (registration_number),
	CONSTRAINT vehicles_vin_unique UNIQUE (vin)
);
-- ------------------------------------------------------
-- public.vehicles foreign keys
ALTER TABLE public.vehicles ADD CONSTRAINT vehicles_owner_id_foreign FOREIGN KEY (owner_id) REFERENCES public.owners(id) ON DELETE CASCADE;
ALTER TABLE public.vehicles ADD CONSTRAINT vehicles_vehicle_model_id_foreign FOREIGN KEY (vehicle_model_id) REFERENCES public.vehicle_models(id) ON DELETE SET NULL;
-- ------------------------------------------------------
-- Insert a few records into the 'vehicles' table
-- ------------------------------------------------------
INSERT INTO public.vehicles (id, owner_id, vehicle_model_id, description, registration_number, vin, mileage, created_at, updated_at, deleted_at)
VALUES (1, 1, 1, 'John Doe''s Toyota Corolla', 'KCA 123X', 'JTNKU4JE3K3040001', '10000', '2024-09-04 00:00:00', '2024-09-04 00:00:00', NULL)
, (2, 2, 2, 'Jane Doe''s Toyota Camry', 'KCA 124X', 'JTNU4JE3K3040002', '20000', '2024-09-04 00:00:00', '2024-09-04 00:00:00', NULL)
-- ------------------------------------------------------
-- Table structure for table 'service_types'
-- ------------------------------------------------------
CREATE TABLE public.service_types (
	id bigserial NOT NULL,
	"name" varchar(255) NOT NULL,
	description text NOT NULL,
	unit_price numeric(8, 2) NOT NULL,
	created_at timestamp(0) NULL,
	updated_at timestamp(0) NULL,
	deleted_at timestamp(0) NULL,
	CONSTRAINT service_types_pkey PRIMARY KEY (id)
);
-- ------------------------------------------------------
-- Insert a few records into the 'service_types' table
-- ------------------------------------------------------
INSERT INTO public.service_types (id, "name", description, unit_price, created_at, updated_at, deleted_at)
VALUES (1, 'Oil Change', 'Change engine oil and oil filter', '5000.00', '2024-09-04 00:00:00', '2024-09-04 00:00:00', NULL)
, (2, 'Brake Service', 'Replace brake pads and brake fluid', '10000.00', '2024-09-04 00:00:00', '2024-09-04 00:00:00', NULL)
, (3, 'Spark Plug Replacement', 'Replace spark plugs', '3000.00', '2024-09-04 00:00:00', '2024-09-04 00:00:00', NULL)
-- ------------------------------------------------------
-- Table structure for table 'services'
-- ------------------------------------------------------
CREATE TABLE public.services (
	id bigserial NOT NULL,
	service_number varchar(255) NOT NULL,
	vehicle_id int8 NOT NULL,
	description text NOT NULL,
	service_started_at timestamp(0) NULL,
	service_ended_at timestamp(0) NULL,
	status varchar(255) NOT NULL DEFAULT 'pending'::character varying,
	created_at timestamp(0) NULL,
	updated_at timestamp(0) NULL,
	deleted_at timestamp(0) NULL,
	CONSTRAINT services_pkey PRIMARY KEY (id),
	CONSTRAINT services_service_number_unique UNIQUE (service_number),
	CONSTRAINT services_status_check CHECK (((status)::text = ANY ((ARRAY['pending'::character varying, 'in_progress'::character varying, 'completed'::character varying, 'canceled'::character varying])::text[])))
);
-- public.services foreign keys
ALTER TABLE public.services ADD CONSTRAINT services_vehicle_id_foreign FOREIGN KEY (vehicle_id) REFERENCES public.vehicles(id);
-- ------------------------------------------------------
-- Insert a few records into the 'services' table
-- ------------------------------------------------------
INSERT INTO public.services (id, service_number, vehicle_id, description, service_started_at, service_ended_at, status, created_at, updated_at, deleted_at)
VALUES (1, 'SRV-001', 1, 'Oil Change for John Doe''s Toyota Corolla', '2024-09-04 00:00:00', '2024-09-04 00:00:00', 'completed', '2024-09-04 00:00:00', '2024-09-04 00:00:00', NULL)
, (2, 'SRV-002', 2, 'Brake Service for Jane Doe''s Toyota Camry', '2024-09-04 00:00:00', '2024-09-04 00:00:00', 'pending', '2024-09-04 00:00:00', '2024-09-04 00:00:00', NULL)
, (3, 'SRV-003', 1, 'Spark Plug Replacement for John Doe''s Toyota Corolla', '2024-09-04 00:00:00', '2024-09-04 00:00:00', 'in_progress', '2024-09-04 00:00:00', '2024-09-04 00:00:00', NULL)
-- ------------------------------------------------------
-- Table structure for table 'service_items'
-- ------------------------------------------------------
CREATE TABLE public.service_items (
	id bigserial NOT NULL,
	service_id int8 NOT NULL,
	service_type_id int8 NOT NULL,
	unit_price numeric(8, 2) NOT NULL,
	quantity int4 NOT NULL,
	sub_total numeric(8, 2) NOT NULL,
	discount numeric(8, 2) NOT NULL DEFAULT '0'::numeric,
	notes varchar(255) NULL,
	created_at timestamp(0) NULL,
	updated_at timestamp(0) NULL,
	deleted_at timestamp(0) NULL,
	CONSTRAINT service_items_pkey PRIMARY KEY (id)
);
-- public.service_items foreign keys
ALTER TABLE public.service_items ADD CONSTRAINT service_items_service_id_foreign FOREIGN KEY (service_id) REFERENCES public.services(id) ON DELETE CASCADE;
ALTER TABLE public.service_items ADD CONSTRAINT service_items_service_type_id_foreign FOREIGN KEY (service_type_id) REFERENCES public.service_types(id) ON DELETE CASCADE;
-- ------------------------------------------------------
-- Insert a few records into the 'service_items' table
-- ------------------------------------------------------
INSERT INTO public.service_items (id, service_id, service_type_id, unit_price, quantity, sub_total, discount, notes, created_at, updated_at, deleted_at)
VALUES (1, 1, 1, '5000.00', 1, '5000.00', '0.00', NULL, '2024-09-04 00:00:00', '2024-09-04 00:00:00', NULL)
, (2, 2, 2, '10000.00', 1, '10000.00', '0.00', NULL, '2024-09-04 00:00:00', '2024-09-04 00:00:00', NULL)
, (3, 3, 3, '3000.00', 3, '9000.00', '0.00', NULL, '2024-09-04 00:00:00', '2024-09-04 00:00:00', NULL)
-- ------------------------------------------------------