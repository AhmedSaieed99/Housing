/*Select *
from NashvilleHousing
*/
------------------------------------------------------------------------------------------------------------------
--First, updating the Date format
/*Alter table NashvilleHousing
add DateUpdated Date;

update NashvilleHousing
set DateUpdated = convert(Date, SaleDate)*/
--------------------------------------------------------------------------------------------------------------------
--Populate Property Address
/*Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, isnull(a.PropertyAddress, b.PropertyAddress) as Populate
from NashvilleHousing as a
join NashvilleHousing as b on
a.ParcelID = b.ParcelID and a.[UniqueID ] != b.[UniqueID ]
where a.PropertyAddress is null
*/
/*update a
set PropertyAddress = isnull(a.PropertyAddress, b.PropertyAddress)
from NashvilleHousing as a
join NashvilleHousing as b on
a.ParcelID = b.ParcelID and a.[UniqueID ] != b.[UniqueID ]
where a.PropertyAddress is null
*/

---------------------------------------------------------------------------------------------------------------------
--Breaking out address into individual columns (Address, City, State)
/*
Select substring(PropertyAddress, 1, CHARINDEX(',', propertyaddress)-1) as Address
, substring(PropertyAddress, CHARINDEX(',', propertyaddress)+1, len(PropertyAddress)) as City
from NashvilleHousing
*/
/*Alter table NashvilleHousing
add PropertySplitAddress nvarchar(255);

update NashvilleHousing
set PropertySplitAddress = substring(PropertyAddress, 1, CHARINDEX(',', propertyaddress)-1)

Alter table NashvilleHousing
add PropertySplitCity nvarchar(255);

update NashvilleHousing
set PropertySplitCity = substring(PropertyAddress, CHARINDEX(',', propertyaddress)+1, len(PropertyAddress))*/
/*
select OwnerAddress
from NashvilleHousing

select parsename(replace(OwnerAddress, ',', '.'), 3), 
parsename(replace(OwnerAddress, ',', '.'), 2), 
parsename(replace(OwnerAddress, ',', '.'), 1)
from NashvilleHousing
*/
/*Alter table NashvilleHousing
add OwnerSpecificAddress nvarchar(255);

update NashvilleHousing
set OwnerSpecificAddress = parsename(replace(OwnerAddress, ',', '.'), 3)

Alter table NashvilleHousing
add OwnerCity nvarchar(255);

update NashvilleHousing
set OwnerCity = parsename(replace(OwnerAddress, ',', '.'), 2)

Alter table NashvilleHousing
add OwnerState nvarchar(255);

update NashvilleHousing
set OwnerState = parsename(replace(OwnerAddress, ',', '.'), 1)*/

-------------------------------------------------------------------------------
--In "SalesAsVacant" Column, we need to change "N" and "Y" to "No" and "Yes"
/*Select distinct(SoldAsVacant)
from NashvilleHousing
*/
/*update NashvilleHousing
set SoldAsVacant = 'No'
where SoldAsVacant = 'N'

update NashvilleHousing
set SoldAsVacant = 'Yes'
where SoldAsVacant = 'Y' */

--------------------------------------------------

--RemoveDuplicates

/*with RowNumCTE as(
Select *, row_number() over(

partition by ParcelID, PropertyAddress, SalePrice, SaleDate, LegalReference
order by UniqueID
) Row_Num
From NashvilleHousing
)
Delete
from RowNumCTE
where Row_Num > 1
*/
------------------------------------------
--Since we have the Split Property Address and Split Owner Address we don't need the unused Property, Owner Address, TaxDistrict and SaleDate
/*Alter Table NashvilleHousing
drop column PropertyAddress, OwnerAddress, TaxDistrict, SaleDate
*/
Select *
from NashvilleHousing