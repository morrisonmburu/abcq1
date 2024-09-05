-- Vehicle Maintenance for ABC Service Station SQL Script
--
-- Host: 127.0.0.1 port: 5432    Database: PostgreSQL
-- ------------------------------------------------------
--  A list of owners and the number of times they have had their vehicles serviced, 
--- and the amount they have spent at this service station.
--- Order by the highest to the lowest paying owners.
-- ------------------------------------------------------
SELECT 
    o.name AS owner_name,
    COUNT(DISTINCT s.id) AS number_of_services,
    SUM(si.sub_total) AS total_spent
FROM
    owners o
    JOIN vehicles v ON o.id = v.owner_id
    JOIN services s ON v.id = s.vehicle_id
    JOIN service_items si ON s.id = si.service_id
GROUP BY
    o.name
ORDER BY
    total_spent DESC;
-- ------------------------------------------------------