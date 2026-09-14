USE [RatesProject]
GO

/****** Object:  Table [dbo].[Employee]    Script Date: 9/5/2026 11:20:36 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

--*******************
--*** Drop Tables ***
--*******************
DROP TABLE IF EXISTS dbo.Address
DROP TABLE IF EXISTS dbo.Phone
DROP TABLE IF EXISTS dbo.CustomerRates
DROP TABLE IF EXISTS dbo.Customer
DROP TABLE IF EXISTS dbo.AddressType
DROP TABLE IF EXISTS dbo.PhoneType
DROP TABLE IF EXISTS dbo.RateType

--*********************
--*** Create Tables ***
--*********************
CREATE TABLE [dbo].[Customer](
	[ID] [uniqueidentifier] NOT NULL,
	[FirstName] [varchar](50) NOT NULL,
	[LastName] [varchar](50) NOT NULL,
	[CreatedDate] [datetime] NOT NULL
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].Customer ADD  DEFAULT (newid()) FOR [ID]
GO

CREATE TABLE [dbo].[AddressType](
	[ID] [uniqueidentifier] NOT NULL,
	[AddressTypeDescription] [varchar](50) NOT NULL,
	[CreatedDate] [datetime] NOT NULL
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].AddressType ADD  DEFAULT (newid()) FOR [ID]
GO

CREATE TABLE [dbo].[PhoneType](
	[ID] [uniqueidentifier] NOT NULL,
	[PhoneTypeDescription] [varchar](50) NOT NULL,
	[CreatedDate] [datetime] NOT NULL
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].PhoneType ADD  DEFAULT (newid()) FOR [ID]
GO

CREATE TABLE [dbo].[Phone](
	[ID] [uniqueidentifier] NOT NULL,
	[CustomerID][uniqueidentifier] NOT NULL,
	[PhoneTypeID][uniqueidentifier] NOT NULL,
	[PhoneNumber] [varchar](10) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].Phone ADD  DEFAULT (newid()) FOR [ID]
ALTER TABLE [dbo].[Phone]  WITH CHECK ADD FOREIGN KEY([PhoneTypeID])
REFERENCES [dbo].[PhoneType] ([ID])
ALTER TABLE [dbo].[Phone]  WITH CHECK ADD FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customer] ([ID])
GO

CREATE TABLE [dbo].[Address](
	[ID] [uniqueidentifier] NOT NULL,
	[CustomerID][uniqueidentifier] NOT NULL,
	[AddressTypeID][uniqueidentifier] NOT NULL,
	[StreetAddress] [varchar](50) NOT NULL,
	[City] [varchar](50) NOT NULL,
	[State] [varchar](2) NOT NULL,
	[ZipCode] [varchar](50) NOT NULL,
	[CreatedDate] [datetime] NOT NULL
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
Go
ALTER TABLE [dbo].Address ADD  DEFAULT (newid()) FOR [ID]
ALTER TABLE [dbo].[Address]  WITH CHECK ADD FOREIGN KEY([AddressTypeID])
REFERENCES [dbo].[AddressType] ([ID])
ALTER TABLE [dbo].[Address]  WITH CHECK ADD FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customer] ([ID])
GO

CREATE TABLE [dbo].[RateType](
	[ID] [uniqueidentifier] NOT NULL,
	[RateTypeDescription] [varchar](50) NOT NULL,
	[CreatedDate] [datetime] NOT NULL
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RateType] ADD  DEFAULT (newid()) FOR [ID]
GO

CREATE TABLE [dbo].[CustomerRates](
	[ID] [uniqueidentifier] NOT NULL,
	[CustomerID][uniqueidentifier] NOT NULL,
	[RateTypeID][uniqueidentifier] NOT NULL,
	[RateName][varchar](50) NOT NULL,
	[RateAmount][Numeric](5,2) NOT NULL,
	[CreatedDate][datetime] NOT NULL
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CustomerRates] ADD  DEFAULT (newid()) FOR [ID]
ALTER TABLE [dbo].[CustomerRates]  WITH CHECK ADD FOREIGN KEY([RateTypeID])
REFERENCES [dbo].[RateType] ([ID])
ALTER TABLE [dbo].[CustomerRates]  WITH CHECK ADD FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customer] ([ID])
GO


--*******************
--*** Create Data ***
--*******************
INSERT INTO Customer (FirstName, LastName, CreatedDate)
VALUES('John', 'Smith', GETDATE()),
      ('Sean', 'Goddard', GETDATE()),
	  ('Carol', 'Terance', GETDATE()),
	  ('Jean', 'Klien', GETDATE()),
	  ('Joseph', 'Planshard', GETDATE())

INSERT INTO AddressType ([AddressTypeDescription], CreatedDate)
VALUES('Home', GETDATE()),
      ('Business', GETDATE()),
	  ('Rental', GETDATE()),
	  ('Rental2', GETDATE())
  
INSERT INTO PhoneType ([PhoneTypeDescription], CreatedDate)
VALUES('Home', GETDATE()),
      ('Business', GETDATE()),
	  ('Cell', GETDATE()),
	  ('Cell2', GETDATE())

INSERT INTO RateType(RateTypeDescription, CreatedDate)
VALUES('Fixed', GETDATE()),
      ('Adjustable', GETDATE())

INSERT INTO Phone (CustomerID, PhoneTypeID, PhoneNumber, CreatedDate)
SELECT c.Id, (SELECT ID FROM PhoneType WHERE [PhoneTypeDescription] = 'Cell'),'4079248784', GETDATE()
FROM CUSTOMER c
WHERE LastName = 'Terance'

INSERT INTO Phone (CustomerID, PhoneTypeID, PhoneNumber, CreatedDate)
SELECT c.Id, (SELECT ID FROM PhoneType WHERE [PhoneTypeDescription] = 'Home'),'3219248727', GETDATE()
FROM CUSTOMER c
WHERE LastName = 'Terance'

INSERT INTO Phone (CustomerID, PhoneTypeID, PhoneNumber, CreatedDate)
SELECT c.Id, (SELECT ID FROM PhoneType WHERE [PhoneTypeDescription] = 'Home'),'3219248728', GETDATE()
FROM CUSTOMER c
WHERE LastName = 'Klien'

INSERT INTO Phone (CustomerID, PhoneTypeID, PhoneNumber, CreatedDate)
SELECT c.Id, (SELECT ID FROM PhoneType WHERE [PhoneTypeDescription] = 'Cell'),'6536251248', GETDATE()
FROM CUSTOMER c
WHERE LastName = 'Smith'

INSERT INTO Phone (CustomerID, PhoneTypeID, PhoneNumber, CreatedDate)
SELECT c.Id, (SELECT ID FROM PhoneType WHERE [PhoneTypeDescription] = 'Cell'),'3219248778', GETDATE()
FROM CUSTOMER c
WHERE LastName = 'Klien'

INSERT INTO Phone (CustomerID, PhoneTypeID, PhoneNumber, CreatedDate)
SELECT c.Id, (SELECT ID FROM PhoneType WHERE [PhoneTypeDescription] = 'Cell'),'8769387630', GETDATE()
FROM CUSTOMER c
WHERE LastName = 'Goddard'

INSERT INTO Phone (CustomerID, PhoneTypeID, PhoneNumber, CreatedDate)
SELECT c.Id, (SELECT ID FROM PhoneType WHERE [PhoneTypeDescription] = 'Business'),'5865474450', GETDATE()
FROM CUSTOMER c
WHERE LastName = 'Planshard'

INSERT INTO Phone (CustomerID, PhoneTypeID, PhoneNumber, CreatedDate)
SELECT c.Id, (SELECT ID FROM PhoneType WHERE [PhoneTypeDescription] = 'Cell'),'5865474459', GETDATE()
FROM CUSTOMER c
WHERE LastName = 'Planshard'

INSERT INTO Phone (CustomerID, PhoneTypeID, PhoneNumber, CreatedDate)
SELECT c.Id, (SELECT ID FROM PhoneType WHERE [PhoneTypeDescription] = 'Business'),'5865474459', GETDATE()
FROM CUSTOMER c
WHERE LastName = 'Smith'

INSERT INTO Phone (CustomerID, PhoneTypeID, PhoneNumber, CreatedDate)
SELECT c.Id, (SELECT ID FROM PhoneType WHERE [PhoneTypeDescription] = 'Cell'),'5865474459', GETDATE()
FROM CUSTOMER c
WHERE LastName = 'Smith'

INSERT INTO Address (CustomerID, AddressTypeID, StreetAddress, City, State, ZipCode, CreatedDate)
SELECT c.Id, (SELECT ID FROM AddressType WHERE [AddressTypeDescription] = 'Home'),
	   Address = '231 First Ave',
	   City = 'Tampa',
	   State ='FL',
	   Zip = '43276',
	   CreatedDate = GETDATE()
FROM CUSTOMER c
WHERE LastName = 'Smith'

INSERT INTO Address (CustomerID, AddressTypeID, StreetAddress, City, State, ZipCode, CreatedDate)
SELECT c.Id, (SELECT ID FROM AddressType WHERE [AddressTypeDescription] = 'Home'),
	   Address = '1443 Merrick ST',
	   City = 'Atlanta',
	   State ='GA',
	   Zip = '45254',
	   CreatedDate = GETDATE()
FROM CUSTOMER c
WHERE LastName = 'Terance'


INSERT INTO Address (CustomerID, AddressTypeID, StreetAddress, City, State, ZipCode, CreatedDate)
SELECT c.Id, (SELECT ID FROM AddressType WHERE [AddressTypeDescription] = 'Home'),
	   Address = '6373 Lappard St',
	   City = 'Orlando',
	   State ='FL',
	   Zip = '32765',
	   CreatedDate = GETDATE()
FROM CUSTOMER c
WHERE LastName = 'Goddard'

INSERT INTO Address (CustomerID, AddressTypeID, StreetAddress, City, State, ZipCode, CreatedDate)
SELECT c.Id, (SELECT ID FROM AddressType WHERE [AddressTypeDescription] = 'Home'),
	   Address = '2311 Suellen Dr',
	   City = 'Exton',
	   State ='PA',
	   Zip = '28276',
	   CreatedDate = GETDATE()
FROM CUSTOMER c
WHERE LastName = 'Klien'

INSERT INTO Address (CustomerID, AddressTypeID, StreetAddress, City, State, ZipCode, CreatedDate)
SELECT c.Id, (SELECT ID FROM AddressType WHERE [AddressTypeDescription] = 'Home'),
	   Address = '5511 3rd str',
	   City = 'Jacksonville',
	   State ='FL',
	   Zip = '82763',
	   CreatedDate = GETDATE()
FROM CUSTOMER c
WHERE LastName = 'Smith'

INSERT INTO Address (CustomerID, AddressTypeID, StreetAddress, City, State, ZipCode, CreatedDate)
SELECT c.Id, (SELECT ID FROM AddressType WHERE [AddressTypeDescription] = 'Business'),
	   Address = '23122 Marston ST',
	   City = 'Lynchfield',
	   State ='VA',
	   Zip = '90876',
	   CreatedDate = GETDATE()
FROM CUSTOMER c
WHERE LastName = 'Smith'

INSERT INTO CustomerRates(CustomerID, RateTypeID, RateName, RateAmount, CreatedDate)
SELECT c.Id, (SELECT ID FROM RateType WHERE [RateTypeDescription] = 'Fixed'), RateName = 'Rate 1', RateAmount = 23.33, CreatedDate = GETDATE()
FROM CUSTOMER c
WHERE LastName = 'Smith'

INSERT INTO CustomerRates(CustomerID, RateTypeID, RateName, RateAmount, CreatedDate)
SELECT c.Id, (SELECT ID FROM RateType WHERE [RateTypeDescription] = 'Fixed'), RateName = 'Rate 2', RateAmount = 14.00, CreatedDate = GETDATE()
FROM CUSTOMER c
WHERE LastName = 'Smith'

INSERT INTO CustomerRates(CustomerID, RateTypeID, RateName, RateAmount, CreatedDate)
SELECT c.Id, (SELECT ID FROM RateType WHERE [RateTypeDescription] = 'Fixed'), RateName = 'Rate 3', RateAmount = 12.34, CreatedDate = GETDATE()
FROM CUSTOMER c
WHERE LastName = 'Smith'

INSERT INTO CustomerRates(CustomerID, RateTypeID, RateName, RateAmount, CreatedDate)
SELECT c.Id, (SELECT ID FROM RateType WHERE [RateTypeDescription] = 'Fixed'), RateName = 'Rate 4', RateAmount = 10.90, CreatedDate = GETDATE()
FROM CUSTOMER c
WHERE LastName = 'Smith'

INSERT INTO CustomerRates(CustomerID, RateTypeID, RateName, RateAmount, CreatedDate)
SELECT c.Id, (SELECT ID FROM RateType WHERE [RateTypeDescription] = 'Adjustable'), RateName = 'Rate 1', RateAmount = 23.99, CreatedDate = GETDATE()
FROM CUSTOMER c
WHERE LastName = 'Terance'

INSERT INTO CustomerRates(CustomerID, RateTypeID, RateName, RateAmount, CreatedDate)
SELECT c.Id, (SELECT ID FROM RateType WHERE [RateTypeDescription] = 'Adjustable'), RateName = 'Rate 2', RateAmount = 76.88, CreatedDate = GETDATE()
FROM CUSTOMER c
WHERE LastName = 'Terance'

INSERT INTO CustomerRates(CustomerID, RateTypeID, RateName, RateAmount, CreatedDate)
SELECT c.Id, (SELECT ID FROM RateType WHERE [RateTypeDescription] = 'Adjustable'), RateName = 'Rate 3', RateAmount = 4.44, CreatedDate = GETDATE()
FROM CUSTOMER c
WHERE LastName = 'Terance'

INSERT INTO CustomerRates(CustomerID, RateTypeID, RateName, RateAmount, CreatedDate)
SELECT c.Id, (SELECT ID FROM RateType WHERE [RateTypeDescription] = 'Adjustable'), RateName = 'Rate 4', RateAmount = 26.87, CreatedDate = GETDATE()
FROM CUSTOMER c
WHERE LastName = 'Terance'

INSERT INTO CustomerRates(CustomerID, RateTypeID, RateName, RateAmount, CreatedDate)
SELECT c.Id, (SELECT ID FROM RateType WHERE [RateTypeDescription] = 'Adjustable'), RateName = 'Rate 1', RateAmount = 11.22, CreatedDate = GETDATE()
FROM CUSTOMER c
WHERE LastName = 'Planshard'

INSERT INTO CustomerRates(CustomerID, RateTypeID, RateName, RateAmount, CreatedDate)
SELECT c.Id, (SELECT ID FROM RateType WHERE [RateTypeDescription] = 'Adjustable'), RateName = 'Rate 2', RateAmount = 14.75, CreatedDate = GETDATE()
FROM CUSTOMER c
WHERE LastName = 'Planshard'

INSERT INTO CustomerRates(CustomerID, RateTypeID, RateName, RateAmount, CreatedDate)
SELECT c.Id, (SELECT ID FROM RateType WHERE [RateTypeDescription] = 'Adjustable'), RateName = 'Rate 3', RateAmount = 22.33, CreatedDate = GETDATE()
FROM CUSTOMER c
WHERE LastName = 'Planshard'

INSERT INTO CustomerRates(CustomerID, RateTypeID, RateName, RateAmount, CreatedDate)
SELECT c.Id, (SELECT ID FROM RateType WHERE [RateTypeDescription] = 'Adjustable'), RateName = 'Rate 4', RateAmount = 74.87, CreatedDate = GETDATE()
FROM CUSTOMER c
WHERE LastName = 'Planshard'


INSERT INTO CustomerRates(CustomerID, RateTypeID, RateName, RateAmount, CreatedDate)
SELECT c.Id, (SELECT ID FROM RateType WHERE [RateTypeDescription] = 'Adjustable'), RateName = 'Rate 1', RateAmount = 11.22, CreatedDate = GETDATE()
FROM CUSTOMER c
WHERE LastName = 'Planshard'

INSERT INTO CustomerRates(CustomerID, RateTypeID, RateName, RateAmount, CreatedDate)
SELECT c.Id, (SELECT ID FROM RateType WHERE [RateTypeDescription] = 'Adjustable'), RateName = 'Rate 1', RateAmount = 45.25, CreatedDate = GETDATE()
FROM CUSTOMER c
WHERE LastName = 'Goddard'

INSERT INTO CustomerRates(CustomerID, RateTypeID, RateName, RateAmount, CreatedDate)
SELECT c.Id, (SELECT ID FROM RateType WHERE [RateTypeDescription] = 'Adjustable'), RateName = 'Rate 2', RateAmount = 11.44, CreatedDate = GETDATE()
FROM CUSTOMER c
WHERE LastName = 'Goddard'

INSERT INTO CustomerRates(CustomerID, RateTypeID, RateName, RateAmount, CreatedDate)
SELECT c.Id, (SELECT ID FROM RateType WHERE [RateTypeDescription] = 'Adjustable'), RateName = 'Rate 3', RateAmount = 65.41, CreatedDate = GETDATE()
FROM CUSTOMER c
WHERE LastName = 'Goddard'

INSERT INTO CustomerRates(CustomerID, RateTypeID, RateName, RateAmount, CreatedDate)
SELECT c.Id, (SELECT ID FROM RateType WHERE [RateTypeDescription] = 'Adjustable'), RateName = 'Rate 1', RateAmount = 4.5, CreatedDate = GETDATE()
FROM CUSTOMER c
WHERE LastName = 'Klien'

INSERT INTO CustomerRates(CustomerID, RateTypeID, RateName, RateAmount, CreatedDate)
SELECT c.Id, (SELECT ID FROM RateType WHERE [RateTypeDescription] = 'Adjustable'), RateName = 'Rate 2', RateAmount = 7.25, CreatedDate = GETDATE()
FROM CUSTOMER c
WHERE LastName = 'Klien'

INSERT INTO CustomerRates(CustomerID, RateTypeID, RateName, RateAmount, CreatedDate)
SELECT c.Id, (SELECT ID FROM RateType WHERE [RateTypeDescription] = 'Adjustable'), RateName = 'Rate 3', RateAmount = 4.25, CreatedDate = GETDATE()
FROM CUSTOMER c
WHERE LastName = 'Klien'