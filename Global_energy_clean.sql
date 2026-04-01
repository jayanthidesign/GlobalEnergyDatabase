DROP DATABASE energy_database;
create database energy_database;
use energy_database;
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

SELECT * FROM energy_data;

#    Identity Missing Value
SELECT * FROM energy_data where Year is null or Total_Energy_Consumption_TWh is null or Per_Capita_Energy_Use_KWh is null ;

SELECT * FROM energy_data where Renewable_Energy_Share is null or
Fossil_Fuel_Dependency is null or
Industrial_Energy_Use is null or
Household_Energy_Use is null or
Carbon_Emissions_Mt is null or
Energy_Price_Index is null;

SELECT *,
ROW_NUMBER() OVER (partition by Country,
Year,
Total_Energy_Consumption_TWh,
Per_Capita_Energy_Use_KWh,
Renewable_Energy_Share, 
Fossil_Fuel_Dependency,
Industrial_Energy_Use, 
Household_Energy_Use,
Carbon_Emissions_Mt,
Energy_Price_Index) AS row_num 
FROM energy_data;

# Count of unique countries in the dataset
SELECT COUNT(DISTINCT Country) AS unique_countries
FROM energy_data;


# Total energy consumption per country
SELECT Country, SUM(Total_Energy_Consumption_TWh) AS total_energy
FROM energy_data
GROUP BY Country
ORDER BY total_energy DESC;

#  Top 5 countries by total carbon emissions
SELECT Country, SUM(Carbon_Emissions_Mt) AS total_carbon_emissions
FROM energy_data
GROUP BY Country
ORDER BY total_carbon_emissions DESC
LIMIT 5;

# Year-wise total energy consumption trend
SELECT Year, SUM(Total_Energy_Consumption_TWh) AS total_energy_year
FROM energy_data
GROUP BY Year
ORDER BY Year;

# Highest energy consumption in a single year by country
SELECT Country,Year, Total_Energy_Consumption_TWh 
FROM energy_data
WHERE Total_Energy_Consumption_TWh =(SELECT max(Total_Energy_Consumption_TWh ) from energy_data);

# Countries most dependent on fossil fuels
SELECT Country,AVG(Fossil_Fuel_Dependency) AS Avg_fossil_fuel
FROM energy_data 
GROUP BY Country
ORDER BY Avg_fossil_fuel DESC
LIMIT 5;

#  Industrial energy use trend by year

SELECT Year, SUM(Industrial_Energy_Use) AS total_industrial_use
FROM energy_data
GROUP BY year
ORDER BY total_industrial_use DESC;

#  Household energy use trend by year

SELECT Year, SUM(Household_Energy_Use) AS total_household_use
FROM energy_data
GROUP BY year
ORDER BY total_household_use DESC;


# Total carbon emissions by country

SELECT Country, SUM(Carbon_Emissions_Mt) AS total_emissions
FROM energy_data
GROUP BY Country
ORDER BY total_emissions DESC;

# Correlation between per capita energy use and carbon emissions

SELECT Country,
       AVG(Per_Capita_Energy_Use_KWh) AS avg_per_capita,
       SUM(Carbon_Emissions_Mt) AS total_emissions
FROM energy_data
GROUP BY Country
ORDER BY avg_per_capita DESC;


#  Countries with highest energy price index

SELECT Country,SUM(Energy_Price_Index) AS Total_energy_price 
FROM energy_data
GROUP BY Country
ORDER BY Total_energy_price  DESC;

#  Compare industrial vs household energy use by country

SELECT Country, 
SUM(Industrial_Energy_Use) AS total_industrial,
SUM(Household_Energy_Use) AS total_household
FROM energy_data
GROUP BY Country
ORDER BY total_industrial DESC;




