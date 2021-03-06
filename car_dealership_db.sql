CREATE TABLE "service" (
  "service_id" SERIAL,
  "part_id" VARCHAR(50),
  "hours" INTEGER,
  "service_date" DATE DEFAULT CURRENT_DATE,
  "sub_total" NUMERIC(7,2),
  PRIMARY KEY ("service_id")
);

CREATE TABLE "salesperson" (
  "salesperson_id" SERIAL,
  "first_name" VARCHAR(45),
  "last_name" VARCHAR(45),
  "phone_number" INTEGER,
  "email" VARCHAR(45),
  PRIMARY KEY ("salesperson_id")
);

CREATE TABLE "part" (
  "part_id" SERIAL,
  "name" VARCHAR(45),
  "quantity" INTEGER,
  "amount" NUMERIC(7,2),
  "weight" INTEGER,
  PRIMARY KEY ("part_id")
);

CREATE TABLE "mechanic" (
  "mechanic_id" SERIAL,
  "first_name" VARCHAR(45),
  "last_name" VARCHAR(45),
  "hourly_rate" NUMERIC(5,2),
  "phone_number" INTEGER,
  "email" VARCHAR(45),
  PRIMARY KEY ("mechanic_id")
);

CREATE TABLE "customer" (
  "customer_id" SERIAL,
  "first_name" VARCHAR(45),
  "last_name" VARCHAR(45),
  "address" VARCHAR(100),
  "city" VARCHAR(45),
  "customer_state" VARCHAR(45),
  "zipcode" INTEGER,
  "phone_number" INTEGER,
  "email" VARCHAR(45),
  "billing_info" VARCHAR(45),
  PRIMARY KEY ("customer_id")
);

CREATE TABLE "sale" (
  "sale_id" SERIAL,
  "customer_id" INTEGER,
  "sale_date" DATE DEFAULT CURRENT_DATE,
  "total" NUMERIC(9,2),
  PRIMARY KEY ("sale_id"),
  CONSTRAINT "FK_sale.customer_id"
    FOREIGN KEY ("customer_id")
      REFERENCES "customer"("customer_id")
);

CREATE TABLE "car" (
  "car_id" SERIAL,
  "sale_id" INTEGER,
  "customer_id" INTEGER,
  "salesperson_id" INTEGER,
  "make" VARCHAR(45),
  "model" VARCHAR(45),
  "year" INTEGER,
  "mileage" INTEGER,
  "new_car" BOOLEAN,
  "msrp" NUMERIC(9,2),
  PRIMARY KEY ("car_id"),
  CONSTRAINT "FK_car.customer_id"
    FOREIGN KEY ("customer_id")
      REFERENCES "customer"("customer_id"),
  CONSTRAINT "FK_car.salesperson_id"
    FOREIGN KEY ("salesperson_id")
      REFERENCES "salesperson"("salesperson_id"),
  CONSTRAINT "FK_car.sale_id"
    FOREIGN KEY ("sale_id")
      REFERENCES "sale"("sale_id")
);

CREATE TABLE "service_order" (
  "service_order_id" SERIAL,
  "car_id" INTEGER,
  "service_date" DATE DEFAULT CURRENT_DATE,
  "total" NUMERIC(9,2),
  PRIMARY KEY ("service_order_id"),
  CONSTRAINT "FK_service_order.car_id"
    FOREIGN KEY ("car_id")
      REFERENCES "car"("car_id")
);

CREATE TABLE "mechanic_schedule" (
  "m_sch_id" SERIAL,
  "mechanic_id" INTEGER,
  "service_order_id" INTEGER,
  PRIMARY KEY ("m_sch_id"),
  CONSTRAINT "FK_mechanic_schedule.service_order_id"
    FOREIGN KEY ("service_order_id")
      REFERENCES "service_order"("service_order_id"),
  CONSTRAINT "FK_mechanic_schedule.mechanic_id"
    FOREIGN KEY ("mechanic_id")
      REFERENCES "mechanic"("mechanic_id")
);

CREATE TABLE "service_schedule" (
  "s_sch_id" SERIAL,
  "service_id" INTEGER,
  "service_order_id" INTEGER,
  PRIMARY KEY ("s_sch_id"),
  CONSTRAINT "FK_service_schedule.service_order_id"
    FOREIGN KEY ("service_order_id")
      REFERENCES "service_order"("service_order_id"),
  CONSTRAINT "FK_service_schedule.service_id"
    FOREIGN KEY ("service_id")
      REFERENCES "service"("service_id")
);

CREATE TABLE "part_list" (
  "part_list_id" SERIAL,
  "service_id" INTEGER,
  "part_id" INTEGER,
  PRIMARY KEY ("part_list_id"),
  CONSTRAINT "FK_part_list.service_id"
    FOREIGN KEY ("service_id")
      REFERENCES "service"("service_id"),
  CONSTRAINT "FK_part_list.part_id"
    FOREIGN KEY ("part_id")
      REFERENCES "part"("part_id")
);

--Function--
SELECT *
FROM customer

CREATE OR REPLACE FUNCTION add_customer(_customer_id INTEGER, _first_name CHARACTER VARYING, _last_name CHARACTER VARYING, _address CHARACTER VARYING, _city CHARACTER VARYING, _customer_state CHARACTER VARYING, _zipcode INTEGER, _phone_number INTEGER,
                                email CHARACTER VARYING, billing_info CHARACTER VARYING)
RETURNS void
AS $MAIN$
BEGIN
    INSERT INTO customer VALUES (_customer_id, _first_name, _last_name, address, city, customer_state, zipcode, phone_number,
                                email, billing_info);
END;
$MAIN$
LANGUAGE plpgsql

--SELECT FUNCTION---
SELECT add_customer(1,'marcus','saintil','123 glimmering rd','Austin','tx',78653,8435396625,'marcus.saintil@gmail.com','cash');

--FUNCTION 2---
CREATE OR REPLACE FUNCTION add_salesperson(_salesperson_id INTEGER, _first_name CHARACTER VARYING, _last_name CHARACTER VARYING, _phone_number INTEGER,
                                          _email CHARACTER VARYING)
RETURNS void
AS $MAIN$
BEGIN
    INSERT INTO salesperson VALUES (_salesperson_id, _first_name, _last_name, _phone_number, _email);
END;
$MAIN$
LANGUAGE plpgsql

--SELECT FUNCTION----

SELECT add_salesperson(1,'John','Doe',8001235555,'john.doe@gmail.com')
