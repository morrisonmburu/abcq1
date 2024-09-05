-- Vehicle Maintenance for ABC Service Station SQL Script
--
-- Host: 127.0.0.1 port: 5432    Database: PostgreSQL
-- ------------------------------------------------------
--  A list of vehicles models serviced at this station,
--- the frequency and the total income of each model. 
--- Order by models frequency or service, from the highest to the lowest.
-- ------------------------------------------------------
SELECT 
    vm.make || ' ' || vm.model AS vehicle_model,
    COUNT(DISTINCT s.id) AS number_of_services,
    SUM(si.sub_total) AS total_income
FROM
    vehicle_models vm
    RIGHT JOIN vehicles v ON vm.id = v.vehicle_model_id
    RIGHT JOIN services s ON v.id = s.vehicle_id
    RIGHT JOIN service_items si ON s.id = si.service_id
GROUP BY
    vm.make,
    vm.model
ORDER BY
    number_of_services DESC;
-- ------------------------------------------------------