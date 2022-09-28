USE [master]
GO
CREATE LOGIN [prensa] WITH PASSWORD=N'senha', DEFAULT_DATABASE=[PrensaInteligente], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO
use [PrensaInteligente];
GO
CREATE USER [prensa] FOR LOGIN [prensa]
GO
ALTER ROLE [db_owner] ADD MEMBER [prensa]
GO
