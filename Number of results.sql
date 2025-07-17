-- Finding the number of results per land use 
SELECT LandUse, COUNT(*) AS resultsperland
FROM dbo.cleaning
GROUP BY LandUse
ORDER BY 1

-- Finding the number of results per year built and land use 
SELECT LandUse,YearBuilt, COUNT(*) AS results
FROM dbo.cleaning
WHERE YearBuilt IS NOT NULL AND SalePrice IS NOT NULL AND (LandUse = 'SINGLE FAMILY' OR LandUse = 'DUPLEX' OR LandUse = 'VACANT RESIDENTIAL LAND' OR LandUse = 'ZERO LOT LINE')
GROUP BY LandUse,YearBuilt
ORDER BY YearBuilt DESC ,LandUse,results 

-- Finding the number of results per sale year and land use 
SELECT LandUse,YEAR(SaleDate) AS SaleYear,COUNT(*) AS results
FROM dbo.cleaning
WHERE SaleDate IS NOT NULL AND SalePrice IS NOT NULL AND TotalValue IS NOT NULL 
GROUP BY LandUse,YEAR(SaleDate)  
ORDER BY YEAR(SaleDate) , results DESC

-- Finding the number of results per property city and land use 
SELECT DISTINCT PropertyCity,LandUse, COUNT(*) AS results
FROM dbo.cleaning
WHERE TotalValue IS NOT NULL AND SalePrice IS NOT NULL
GROUP BY PropertyCity,LandUse
ORDER BY results DESC

-- Finding the number of results per property city to compare sale price and total value
SELECT DISTINCT PropertyCity, COUNT(*) AS results
FROM dbo.cleaning
WHERE TotalValue IS NOT NULL AND SalePrice IS NOT NULL
GROUP BY PropertyCity
ORDER BY results DESC

-- Finding the number of results for the 4 main land uses per property city 
SELECT DISTINCT PropertyCity,  COUNT(*) AS results
FROM dbo.cleaning
WHERE LandValue IS NOT NULL AND Acreage IS NOT NULL AND (LandUse='SINGLE FAMILY' OR LandUse='VACANT RESIDENTIAL LAND' OR LandUse ='DUPLEX' OR LandUse='ZERO LOT LINE')
GROUP BY PropertyCity
ORDER BY results DESC

-- Finding the number of results for the period when the average total property value exceeded the average sale price
SELECT COUNT(*) AS RESULTS
FROM dbo.cleaning
WHERE SaleDate<'2014-03-01' AND TotalValue IS NOT NULL AND SalePrice IS NOT NULL 
AND(LandUse = 'SINGLE FAMILY' OR LandUse = 'DUPLEX' OR LandUse = 'ZERO LOT LINE' OR LandUse = 'VACANT RESIDENTIAL LAND')
