-- ENCRYPTION / DECRYPTION
-- Create a Master Key
CREATE MASTER KEY ENCRYPTION BY PASSWORD =
'MookitPass@123';
GO


-- Create a Certificate
CREATE CERTIFICATE MookitCert
WITH SUBJECT = 'Mookit Encryption';
GO


-- Create a Symmetric Key
CREATE SYMMETRIC KEY Mookit
WITH ALGORITHM = AES_256
ENCRYPTION BY CERTIFICATE MookitCert;
GO


-- Encrypt Columns in the Customer Table --
-- Add temporary VARBINARY columns
ALTER TABLE Customer
ADD temp_Email VARBINARY(MAX),
temp_Address VARBINARY(MAX),
temp_Phone VARBINARY(MAX);


-- Populate temporary columns with current data
UPDATE Customer
SET temp_Email = CONVERT(VARBINARY(MAX), Email),
temp_Address = CONVERT(VARBINARY(MAX),[Address]),
temp_Phone = CONVERT(VARBINARY(MAX), Phone);


-- Open the Symmetric Key
OPEN SYMMETRIC KEY Mookit
DECRYPTION BY CERTIFICATE MookitCert;


-- Encrypt the data in the columns
UPDATE Customer
SET temp_Email = ENCRYPTBYKEY(KEY_GUID('Mookit'),temp_Email),
temp_Address = ENCRYPTBYKEY(KEY_GUID('Mookit'), temp_Address),
temp_Phone = ENCRYPTBYKEY(KEY_GUID('Mookit'),temp_Phone)


-- Close the Symmetric Key
CLOSE SYMMETRIC KEY Mookit;
GO

 
-- Decrypt Data for Verification --
-- Open the Symmetric Key
OPEN SYMMETRIC KEY Mookit
DECRYPTION BY CERTIFICATE MookitCert;


-- Decrypt data in Customer table
SELECT
CAST(DECRYPTBYKEY(temp_Email) AS NVARCHAR(100)) AS Decrypted_Email,
CAST(DECRYPTBYKEY(temp_Address) AS NVARCHAR(255)) AS Decrypted_Address
,CAST(DECRYPTBYKEY(temp_Phone) AS NVARCHAR(15)) AS Decrypted_Phone
FROM Customer;


-- Close the Symmetric Key
CLOSE SYMMETRIC KEY Mookit;