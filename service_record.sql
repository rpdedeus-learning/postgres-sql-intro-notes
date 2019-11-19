CREATE TABLE service_record (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    vehicle_id BIGINT,
    service_type VARCHAR(50),
    service_date DATE,
    comments VARCHAR(200),

    CONSTRAINT vehicle_id_fk FOREIGN KEY (vehicle_id) REFERENCES car (id),

    CONSTRAINT service_type CHECK (
        service_type = 'SCHEDULED MAINTENANCE' OR 
        service_type = 'REPAIR' OR 
        service_type = 'OTHER'
    )
);

insert into service_record (vehicle_id, service_type, service_date) values (1, 'SCHEDULED MAINTENANCE', '2019-01-05');
insert into service_record (vehicle_id, service_type, service_date) values (1, 'SCHEDULED MAINTENANCE', '2019-06-05');
insert into service_record (vehicle_id, service_type, service_date) values (2, 'REPAIR', '2019-01-15');