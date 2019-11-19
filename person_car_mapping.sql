CREATE TABLE person_car_mapping (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    person_id BIGINT REFERENCES person(id),
	car_id BIGINT REFERENCES car(id)
);

insert into person_car_mapping(person_id, car_id) values(1, 100);
insert into person_car_mapping(person_id, car_id) values(1, 101);
insert into person_car_mapping(person_id, car_id) values(2, 100);
insert into person_car_mapping(person_id, car_id) values(3, 200);