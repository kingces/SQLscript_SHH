DECLARE @YEAR VARCHAR(50) = 2017
sELECT COUNT(Quantity) as countqty, format(sum(Quantity),'0,00') as qty, format(sum(amount),'0,00.00') as Revenue fROM RawDataRepository Where Department = 'pharmacy' and Year(Convert(date,Rendate)) = @YEAR
and MONTH(Convert(date, Rendate)) = 8