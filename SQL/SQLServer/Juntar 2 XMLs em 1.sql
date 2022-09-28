DECLARE @xml1 XML
DECLARE @xml2 XML
SELECT	 @xml1 =(SELECT TOP 5 <Campo_1>, <Campo_2> FROM <TABELA_1> FOR XML RAW('Tabela1'))
		,@xml2 =(SELECT TOP 5 <Campo_X>, <Campo_Y> FROM <TABELA_2> FOR XML RAW('Tabela2'))

SELECT @xml1, @xml2
FOR XML PATH('Root')
