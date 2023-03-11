USE MASTER
GO
DROP DATABASE IF EXISTS exercicios_algoritmos
GO
CREATE DATABASE exercicios_algoritmos
GO
USE exercicios_algoritmos
GO

--Fazer em SQL Server os seguintes algoritmos:
/*
a) Fazer um algoritmo que leia 1 número e mostre se são múltiplos de 2,3,5 ou nenhum deles
*/

	DECLARE @num INT = FLOOR(RAND() * 100) + 1
SELECT CASE 
    WHEN (@num % 2 = 0) THEN 'O numero ' + CAST(@num AS VARCHAR) + ' é divisivel por 2'
    WHEN (@num % 3 = 0) THEN 'O numero ' + CAST(@num AS VARCHAR) + ' é divisivel por 3'
    WHEN (@num % 5 = 0) THEN 'O numero ' + CAST(@num AS VARCHAR) + ' é divisivel por 5'
    ELSE 'O numero ' + CAST(@num AS VARCHAR) + ' não é divisivel por 2, 3 ou 5'
END AS Resultado

/*  
b) Fazer um algoritmo que leia 3 números e mostre o maior e o menor
*/

DECLARE @num1 INT = FLOOR(RAND() * 10) + 1,
		@num2 INT = FLOOR(RAND() * 10) + 1,
		@num3 INT = FLOOR(RAND() * 10) + 1

IF (@num1 != @num2 AND @num1 != @num3 AND @num2 != @num3)
BEGIN
SELECT 'Números: ' + CAST(@num1 AS VARCHAR) + ', ' + CAST(@num2 AS VARCHAR) + ', ' + CAST(@num3 AS VARCHAR) AS Valores, 
	CASE
		WHEN (@num1 > @num2 AND @num1 > @num3 AND @num2 > @num3) 
		THEN 'O maior é: ' + CAST(@num1 AS VARCHAR) + ', e o menor é: ' + CAST(@num3 AS VARCHAR)

		WHEN (@num1 > @num2 AND @num1 > @num3 AND @num2 < @num3) 
		THEN 'O maior é: ' + CAST(@num1 AS VARCHAR) + ', e o menor é: ' + CAST(@num2 AS VARCHAR)

		WHEN (@num1 < @num2 AND @num1 > @num3 AND @num2 > @num3) 
		THEN 'O maior é: ' + CAST(@num2 AS VARCHAR) + ', e o menor é: ' + CAST(@num3 AS VARCHAR)

		WHEN (@num1 < @num2 AND @num1 < @num3 AND @num2 > @num3) 
		THEN 'O maior é: ' + CAST(@num2 AS VARCHAR) + ', e o menor é: ' + CAST(@num1 AS VARCHAR)

		WHEN (@num1 < @num2 AND @num1 < @num3 AND @num2 < @num3) 
		THEN 'O maior é: ' + CAST(@num3 AS VARCHAR) + ', e o menor é: ' + CAST(@num1 AS VARCHAR)

		WHEN (@num1 > @num2 AND @num1 < @num3 AND @num2 < @num3) 
		THEN 'O maior é: ' + CAST(@num3 AS VARCHAR) + ', e o menor é: ' + CAST(@num2 AS VARCHAR)

		ELSE 'Não há um número maior ou menor'

	END AS Resultado
END

/*
c) Fazer um algoritmo que calcule os 15 primeiros 
termos da série 1,1,2,3,5,8,13,21,... E calcule a soma dos 15 termos
*/

WITH fibonacci AS (
  SELECT 1 AS n, 1 AS fib1, 1 AS fib2
  UNION ALL
  SELECT n + 1, fib2, fib1 + fib2
  FROM fibonacci
  WHERE n < 15
), soma AS (
  SELECT SUM(fib1) AS soma
  FROM fibonacci
)
SELECT fib1, soma
FROM fibonacci, soma;

/*  
d) Fazer um algoritmo que separa uma frase, colocando todas as 
letras em maiúsculo e em minúsculo (Usar funções UPPER e LOWER)
*/

CREATE TABLE letras (
    letraMaiuscula CHAR(1),
    letraMinuscula CHAR(1)
);

DECLARE @frase VARCHAR(100) = 'Frase de exemplo';
DECLARE @cont INT = 1;
DECLARE @letraMaiuscula CHAR(1);
DECLARE @letraMinuscula CHAR(1);

WHILE @cont <= LEN(@frase)
BEGIN
    SET @letraMaiuscula = UPPER(SUBSTRING(@frase, @cont, 1 ));
    SET @letraMinuscula = LOWER(SUBSTRING(@frase, @cont, 1 ));
    INSERT INTO letras (letraMaiuscula, letraMinuscula)
    VALUES (@letraMaiuscula, @letraMinuscula);
    SET @cont = @cont + 1;
END;

SELECT * FROM letras;

/*
e) Fazer um algoritmo que inverta uma palavra (Usar a função SUBSTRING)
*/

DECLARE @palavra VARCHAR(100) = 'exemplo';
DECLARE @comprimento INT = LEN(@palavra);
DECLARE @palavraInvertida VARCHAR(100) = '';
DECLARE @indice INT = @comprimento;

WHILE @indice > 0
BEGIN
    SET @palavraInvertida = @palavraInvertida + SUBSTRING(@palavra, @indice, 1);
    SET @indice = @indice - 1;
END;

PRINT @palavraInvertida;
