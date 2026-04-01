create database global_energydb;
use global_energydb;
create table energy_data (Country	varchar(50),
Year	int,
Total_Energy_Consumption_TWh	float,
Per_Capita_Energy_Use_KWh	float,
Renewable_Energy_Share 	float,
Fossil_Fuel_Dependency 	float,
Industrial_Energy_Use 	float,
Household_Energy_Use 	float,
Carbon_Emissions_Mt 	float,
Energy_Price_Index  float);

DESCRIBE energy_data;

select * from energy_data;
 
 #    Total Records
 
SELECT COUNT(*) FROM energy_data;

#     Identify Missing Value

SELECT * FROM energy_data WHERE	Country is null OR
Year is null OR
Total_Energy_Consumption_TWh is null OR
Per_Capita_Energy_Use_KWh is null OR
Renewable_Energy_Share is null OR
Fossil_Fuel_Dependency is null OR
Industrial_Energy_Use is null OR
Household_Energy_Use is null OR
Carbon_Emissions_Mt is null OR
Energy_Price_Index  is null;

#       Identify Duplicates

SELECT *
FROM (
    SELECT *,
    ROW_NUMBER() OVER (
        PARTITION BY Country,
                     Year,
                     Total_Energy_Consumption_TWh,
                     Per_Capita_Energy_Use_KWh,
                     Renewable_Energy_Share, 
                     Fossil_Fuel_Dependency,
                     Industrial_Energy_Use, 
                     Household_Energy_Use,
                     Carbon_Emissions_Mt,
                     Energy_Price_Index
    ) AS row_num 
    FROM energy_data
) t
WHERE row_num > 1;

SELECT DISTINCT Country
FROM energy_data
ORDER BY Country;

SELECT COUNT(DISTINCT Country) AS total_countries
FROM energy_data;


#    Total Energy Consumption per Year
SELECT Year,
       SUM(Total_Energy_Consumption_TWh) AS total_energy_TWh
FROM energy_data
GROUP BY Year
ORDER BY Year;

#    Total energy Consumption Country-wise


SELECT Country, SUM(Total_Energy_Consumption_TWh) As total_energy_TWh FROM energy_data GROUP BY Country ORDER BY Country ;

