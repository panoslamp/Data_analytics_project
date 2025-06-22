--Creation of a duplicate table to clean the data--
USE [raw]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cleaning](
	[UniqueID] [int] NULL,
	[ParcelID] [nvarchar](50) NULL,
	[LandUse] [nvarchar](50) NULL,
	[PropertyAddress] [nvarchar](50) NULL,
	[SaleDate] [date] NULL,
	[SalePrice] [money] NULL,
	[LegalReference] [nvarchar](50) NULL,
	[SoldAsVacant] [bit] NULL,
	[OwnerName] [nvarchar](100) NULL,
	[OwnerAddress] [nvarchar](50) NULL,
	[Acreage] [float] NULL,
	[TaxDistrict] [nvarchar](50) NULL,
	[LandValue] [int] NULL,
	[BuildingValue] [int] NULL,
	[TotalValue] [int] NULL,
	[YearBuilt] [smallint] NULL,
	[Bedrooms] [tinyint] NULL,
	[FullBath] [tinyint] NULL,
	[HalfBath] [tinyint] NULL
) ON [PRIMARY]
GO

INSERT INTO dbo.cleaning
SELECT * 
FROM dbo.housing


--Identifying and updating duplicate records with missing SaleDate that match every other row--
SELECT *
FROM dbo.cleaning a
JOIN dbo.cleaning b
ON ISNULL(a.ParcelID,'') = ISNULL(b.ParcelID,'')
AND ISNULL(a.UniqueID,-1) = ISNULL(b.UniqueID,-1) AND ISNULL(a.LandUse,'')=ISNULL(b.LandUse,'') AND ISNULL(a.PropertyAddress,'')=ISNULL(b.PropertyAddress,'')
AND ISNULL(a.SalePrice,-1)=ISNULL(b.SalePrice,-1) AND ISNULL(a.LegalReference,'')=ISNULL(b.LegalReference,'') 
AND ISNULL(a.SoldAsVacant,-1)=ISNULL(b.SoldAsVacant,-1) AND ISNULL(a.OwnerName,'') = ISNULL(b.OwnerName,'') AND ISNULL(a.OwnerAddress,'') = ISNULL(b.OwnerAddress,'')
AND ISNULL(a.Acreage,'-1') = ISNULL(b.Acreage,'-1') AND ISNULL(a.TaxDistrict,'')=ISNULL(b.TaxDistrict,'') AND ISNULL(a.LandValue,-1)=ISNULL(b.LandValue,-1)
AND ISNULL(a.BuildingValue,'-1')=ISNULL(b.BuildingValue,'-1') AND ISNULL(a.TotalValue,'-1')=ISNULL(b.TotalValue,'-1') 
AND ISNULL(a.YearBuilt,'-1') = ISNULL(b.YearBuilt,'-1') AND ISNULL(a.Bedrooms,0)=ISNULL(b.Bedrooms,0) AND ISNULL(a.FullBath,0)=ISNULL(b.FullBath,0)
AND ISNULL(a.HalfBath,0)=ISNULL(b.HalfBath,0)
WHERE a.SaleDate IS NULL AND b.SaleDate IS NOT NULL;

UPDATE a
SET a.SaleDate = b.SaleDate
FROM dbo.cleaning a
JOIN dbo.cleaning b ON ISNULL(a.ParcelID,'') = ISNULL(b.ParcelID,'')
AND ISNULL(a.UniqueID,-1) = ISNULL(b.UniqueID,-1) AND ISNULL(a.LandUse,'')=ISNULL(b.LandUse,'') AND ISNULL(a.PropertyAddress,'')=ISNULL(b.PropertyAddress,'')
AND ISNULL(a.SalePrice,-1)=ISNULL(b.SalePrice,-1) AND ISNULL(a.LegalReference,'')=ISNULL(b.LegalReference,'') 
AND ISNULL(a.SoldAsVacant,-1)=ISNULL(b.SoldAsVacant,-1) AND ISNULL(a.OwnerName,'') = ISNULL(b.OwnerName,'') AND ISNULL(a.OwnerAddress,'') = ISNULL(b.OwnerAddress,'')
AND ISNULL(a.Acreage,'-1') = ISNULL(b.Acreage,'-1') AND ISNULL(a.TaxDistrict,'')=ISNULL(b.TaxDistrict,'') AND ISNULL(a.LandValue,-1)=ISNULL(b.LandValue,-1)
AND ISNULL(a.BuildingValue,'-1')=ISNULL(b.BuildingValue,'-1') AND ISNULL(a.TotalValue,'-1')=ISNULL(b.TotalValue,'-1') 
AND ISNULL(a.YearBuilt,'-1') = ISNULL(b.YearBuilt,'-1') AND ISNULL(a.Bedrooms,0)=ISNULL(b.Bedrooms,0) AND ISNULL(a.FullBath,0)=ISNULL(b.FullBath,0)
AND ISNULL(a.HalfBath,0)=ISNULL(b.HalfBath,0)
WHERE a.SaleDate IS NULL AND b.SaleDate IS NOT NULL


--Correcting data
SELECT *
FROM [raw].[dbo].[cleaning]
WHERE LandUse LIKE 'VACANT RESIENTIAL LAND'

UPDATE [raw].[dbo].[cleaning]
SET LandUse = 'VACANT RESIDENTIAL LAND'
WHERE LandUse = 'VACANT RESIENTIAL LAND'

UPDATE [raw].[dbo].[cleaning]
SET LandUse = 'VACANT RESIDENTIAL LAND'
WHERE LandUse = 'VACANT RES LAND';

UPDATE dbo.cleaning
SET PropertyAddress = TRIM(PropertyAddress)
WHERE UniqueID = 1894 OR UniqueID = 2868 OR UniqueID = 2979 OR UniqueID = 4063 OR UniqueID = 5062 OR UniqueID = 8995 OR UniqueID = 9095


--Deleting duplicates--
WITH CTE AS(
SELECT *,
ROW_NUMBER () OVER(PARTITION BY UniqueID, ParcelID, LandUse, PropertyAddress, SaleDate, SalePrice, LegalReference,
SoldAsVacant,OwnerName,OwnerAddress,Acreage,TaxDistrict,LandValue,BuildingValue,TotalValue,YearBuilt,Bedrooms,FullBath,HalfBath
ORDER BY(SELECT NULL)) AS RN
FROM dbo.cleaning)

DELETE 
FROM CTE
WHERE RN>1


--Splitting adderesses --
SELECT * 
FROM dbo.cleaning

SELECT SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1)
FROM dbo.cleaning

SELECT SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress)+1,LEN(PropertyAddress))
FROM dbo.cleaning

SELECT SUBSTRING(OwnerAddress,1,CHARINDEX(',',OwnerAddress)-1)
FROM dbo.cleaning

SELECT SUBSTRING(OwnerAddress,CHARINDEX(',',OwnerAddress)+2,CHARINDEX(',',OwnerAddress,CHARINDEX(',',OwnerAddress)+1)-CHARINDEX(',',OwnerAddress)-2)
FROM dbo.cleaning

SELECT REVERSE(SUBSTRING(REVERSE(OwnerAddress),1,CHARINDEX(',',REVERSE(OwnerAddress))-2))
FROM dbo.cleaning

ALTER TABLE dbo.cleaning
ADD PropertyStreetAddress NVARCHAR(255)
ALTER TABLE dbo.cleaning
ADD PropertyCity NVARCHAR(255)
ALTER TABLE dbo.cleaning
ADD OwnerStreetAddress NVARCHAR(255)
ALTER TABLE dbo.cleaning
ADD OwnerCity NVARCHAR(255)
ALTER TABLE dbo.cleaning
ADD OwnerState NVARCHAR(255)

UPDATE dbo.cleaning
SET PropertyStreetAddress = SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1)

UPDATE dbo.cleaning
SET PropertyCity = SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress)+1,LEN(PropertyAddress))

UPDATE dbo.cleaning
SET OwnerStreetAddress = SUBSTRING(OwnerAddress,1,CHARINDEX(',',OwnerAddress)-1)

UPDATE dbo.cleaning
SET OwnerCity = SUBSTRING(OwnerAddress,CHARINDEX(',',OwnerAddress)+2,CHARINDEX(',',OwnerAddress,CHARINDEX(',',OwnerAddress)+1)-CHARINDEX(',',OwnerAddress)-2)

UPDATE dbo.cleaning
SET OwnerState = REVERSE(SUBSTRING(REVERSE(OwnerAddress),1,CHARINDEX(',',REVERSE(OwnerAddress))-2))

UPDATE dbo.cleaning
SET PropertyCity = TRIM(PropertyCity)

ALTER TABLE dbo.cleaning
DROP COLUMN PropertyAddress,OwnerAddress


--Changing sold as vacant results to text--
ALTER TABLE dbo.cleaning
ALTER COLUMN SoldAsVacant NVARCHAR(10)

UPDATE dbo.cleaning
SET SoldAsVacant = CASE WHEN SoldAsVacant = 0 THEN 'NO' 
WHEN SoldAsVacant = 1 THEN 'YES'
END