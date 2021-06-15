

DECLARE @YEAR VARCHAR(50) = 2016
DELETE FROM RawDataRepository  Where Department = 'emergency' and Year(Convert(date,Rendate)) = @YEAR 