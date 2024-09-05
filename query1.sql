-- Vehicle Maintenance for ABC Service Station SQL Script
--
-- Host: 127.0.0.1 port: 5432    Database: PostgreSQL
-- ------------------------------------------------------
-- Description: Fetch a list of all service activities, 
--- include the model and registration of the vehicle, 
--- the name of the owner and the cost of the service, 
--- order by the date of the service.
-- ------------------------------------------------------
SELECT 
    v.registration_number,
    vm.make || ' ' || vm.model AS vehicle_model,
    o.name AS owner_name,
    s.description AS service_description,
    SUM(si.sub_total) AS service_cost,
    s.service_started_at
FROM
    services s
    JOIN vehicles v ON s.vehicle_id = v.id
    JOIN vehicle_models vm ON v.vehicle_model_id = vm.id
    JOIN owners o ON v.owner_id = o.id
    JOIN service_items si ON si.service_id = s.id 
GROUP BY
    v.registration_number,
    vm.make,
    vm.model,
    o.name,
    s.service_started_at,
    s.description
ORDER BY
    s.service_started_at;
-- ------------------------------------------------------
