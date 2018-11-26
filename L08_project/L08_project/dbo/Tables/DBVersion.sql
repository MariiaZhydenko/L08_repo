CREATE TABLE [dbo].[DBVersion]
(
	Version CHAR(10) NOT NULL PRIMARY KEY
	, DateStart DATE NOT NULL
	, DateEnd DATE NULL
)
