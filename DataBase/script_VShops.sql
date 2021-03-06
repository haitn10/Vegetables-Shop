USE [master]
GO
DROP DATABASE [VegetableManagement]
CREATE DATABASE [VegetableManagement]
GO

USE [VegetableManagement]
GO

CREATE TABLE [dbo].[tblRoles](
	[roleID] NVARCHAR(50) ,
	[roleName] NVARCHAR(50),
	PRIMARY KEY(roleID)
)
GO

CREATE TABLE [dbo].[tblUsers](
	[userID] NVARCHAR(50),
	[fullName] NVARCHAR(50),
	[password] NVARCHAR(50),
	[roleID] NVARCHAR(50) FOREIGN KEY REFERENCES tblRoles,
	[address] NVARCHAR(50),
	[birthday] DATE,
	[phone] NVARCHAR(50),
	[email] NVARCHAR(50),
	PRIMARY KEY(userID)
)
GO

CREATE TABLE [dbo].[tblCategory](
	[categoryID] NVARCHAR(50),
	[categoryName] NVARCHAR(50),
	PRIMARY KEY(categoryID)
 )
GO

CREATE TABLE [dbo].[tblProduct](
	[productID] NVARCHAR(50),
	[productName] NVARCHAR(50),
	[image] NVARCHAR(50),
	[price] DECIMAL(8,3),
	[quantity] INT,
	[categoryID] NVARCHAR(50) FOREIGN KEY REFERENCES tblCategory,
	[importDate] DATE,
	[usingDate] DATE,
	[status] BIT,
	PRIMARY KEY(productID)
)
GO

CREATE TABLE [dbo].[tblOrder](
	[orderID] NVARCHAR(50),
	[orderDate] DATE,
	[total] DECIMAL(10,2),
	[userID] NVARCHAR(50) FOREIGN KEY REFERENCES tblUsers,
	PRIMARY KEY(orderID)
 )
GO

CREATE TABLE [dbo].[tblOrderDetail](
	[detailID] NVARCHAR(50),
	[price] DECIMAL(8,2),
	[quantity] INT,
	[orderID] NVARCHAR(50) FOREIGN KEY REFERENCES tblOrder,
	[productID] NVARCHAR(50) FOREIGN KEY REFERENCES tblProduct,
	PRIMARY KEY(detailID)
)
GO

INSERT INTO [dbo].[tblRoles] ([roleID], [roleName]) VALUES (N'AD',N'Admin')
INSERT INTO [dbo].[tblRoles] ([roleID], [roleName]) VALUES (N'US',N'User')
GO

INSERT INTO [dbo].[tblUsers] ([userID], [fullName], [password], [roleID], [address], [birthday], [phone], [email]) 
VALUES (N'admin', N'Toi la admin', N'1', N'AD', N'HCM', N'1991/02/10', N'0912382912', N'admin@gmail.com')
INSERT INTO [dbo].[tblUsers] ([userID], [fullName], [password], [roleID], [address], [birthday], [phone], [email])
 VALUES (N'haint', N'Tran ngoc hai', N'1', N'AD', N'HA TINH', N'2001/10/10', N'0317238121', N'haint10@gmail.com')
INSERT INTO [dbo].[tblUsers] ([userID], [fullName], [password], [roleID], [address], [birthday], [phone], [email]) 
VALUES (N'chuongcute', N'chuong', N'1', N'US', N'HCM', N'2000/01/10', N'031123213', N'chuong@gmail.com')
INSERT INTO [dbo].[tblUsers] ([userID], [fullName], [password], [roleID], [address], [birthday], [phone], [email])
 VALUES (N'quanap', N'pham anh quan', N'1', N'US', N'CAN THO', N'1999/7/15', N'0128312128', N'quanap1999@gmail.com')
GO

INSERT INTO [dbo].[tblCategory] ([categoryID], [categoryName]) VALUES (N'R',N'Rau')
INSERT INTO [dbo].[tblCategory] ([categoryID], [categoryName]) VALUES (N'C',N'Củ')
INSERT INTO [dbo].[tblCategory] ([categoryID], [categoryName]) VALUES (N'Q',N'Quả')
GO

INSERT INTO [dbo].[tblProduct] ([productID], [productName], [image], [price], [quantity], [categoryID], [importDate], [usingDate], [status]) 
	VALUES (N'R01', N'Water Spinach', N'image\\waterspinach.jpg', 9.500, 10, N'R', N'2022/03/10', N'2022/03/25', 1)
INSERT INTO [dbo].[tblProduct] ([productID], [productName], [image], [price], [quantity], [categoryID], [importDate], [usingDate], [status]) 
	VALUES (N'R02', N'Salad', N'image\\salad.jpg', 5.000, 5, N'R', N'2022/03/10', N'2022/03/25', 1)
INSERT INTO [dbo].[tblProduct] ([productID], [productName], [image], [price], [quantity], [categoryID], [importDate], [usingDate], [status]) 
	VALUES (N'C01', N'Potato', N'image\\potato.jpg', 3.500, 20, N'C', N'2022/03/10', N'2022/03/25', 1)
INSERT INTO [dbo].[tblProduct] ([productID], [productName], [image], [price], [quantity], [categoryID], [importDate], [usingDate], [status])
	VALUES (N'C02', N'Carrot', N'image\\carrot.jpg', 7.500, 15, N'C', N'2022/03/10', N'2022/03/25', 1)
INSERT INTO [dbo].[tblProduct] ([productID], [productName], [image], [price], [quantity], [categoryID], [importDate], [usingDate], [status])
	VALUES (N'Q01', N'Banana', N'image\\banana.jpg', 14.500, 20, N'Q', N'2022/03/10', N'2022/03/25', 1)
INSERT INTO [dbo].[tblProduct] ([productID], [productName], [image], [price], [quantity], [categoryID], [importDate], [usingDate], [status])
	VALUES (N'Q02', N'Orange', N'image\\orange.jpg', 25.500, 10, N'Q', N'2022/03/10', N'2022/03/25', 1)
INSERT INTO [dbo].[tblProduct] ([productID], [productName], [image], [price], [quantity], [categoryID], [importDate], [usingDate], [status]) 
	VALUES (N'Q03', N'Apple', N'image\\apple.jpg', 10.000, 20, N'Q', N'2022/03/10', N'2022/03/25', 1)
INSERT INTO [dbo].[tblProduct] ([productID], [productName], [image], [price], [quantity], [categoryID], [importDate], [usingDate], [status])
	VALUES (N'R03', N'Celery', N'image\\celery.jpg', 7.500, 15, N'R', N'2022/03/10', N'2022/03/25', 1)
INSERT INTO [dbo].[tblProduct] ([productID], [productName], [image], [price], [quantity], [categoryID], [importDate], [usingDate], [status])
	VALUES (N'Q04', N'Lemon', N'image\\lemon.jpg', 3.000, 20, N'Q', N'2022/03/10', N'2022/03/25', 1)
INSERT INTO [dbo].[tblProduct] ([productID], [productName], [image], [price], [quantity], [categoryID], [importDate], [usingDate], [status])
	VALUES (N'C03', N'Taro', N'image\\taro.jpg', 17.000, 10, N'C', N'2022/03/10', N'2022/03/25', 1)
GO
