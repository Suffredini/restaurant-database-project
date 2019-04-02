
------------------------------  1 ---------------------------------

SELECT CodRicetta,NomeRicetta
FROM Ricetta
WHERE NumeroRecensioni > 0 
AND SommaRecensioni/NumeroRecensioni = 
	( SELECT MAX(R.SommaRecensioni/R.NumeroRecensioni)
	  FROM Ricetta R
	  WHERE R.NumeroRecensioni > 0);
	  

------------------------------  2 ---------------------------------

INSERT INTO RecensionePiatto(Testo,Punteggio,CodRicetta,CodRecensione)
       VALUES("TestoRecensione",5,1,1);
	   

------------------------------  3 ---------------------------------

SELECT SUM(F.Importo) 
FROM Fattura F NATURAL JOIN Comanda C
	       NATURAL JOIN Prenotazione P
	       NATURAL JOIN Account A;
		   

------------------------------  4 ---------------------------------

INSERT INTO Ordine(CodRicetta,CodComanda) VALUES(1,1);


------------------------------  5 ---------------------------------

CREATE OR REPLACE VIEW OrdinazioniVariazioni AS
SELECT R.CodRicetta,V.CodVariazione,COUNT(*) AS Numero
FROM Ricetta R NATURAL JOIN Ordine O
	       NATURAL JOIN Variazione V
GROUP BY R.CodRicetta,V.CodVariazione;

CREATE OR REPLACE VIEW MassimiOrdinazioni AS
SELECT CodRicetta,MAX(Numero) AS Numero
FROM OrdinazioniVariazioni 
GROUP BY CodRicetta;

SELECT CodRicetta,CodVariazione
FROM OrdinazioniVariazioni NATURAL JOIN MassimiOrdinazioni;


------------------------------  6 ---------------------------------

SELECT M.CodMagazzino,C.CodConfezione
FROM Magazzino M NATURAL JOIN Confezione C
WHERE DATEDIFF(C.Scadenza,CURRENT_DATE()) <= 3;


------------------------------  7 ---------------------------------

CREATE OR REPLACE VIEW GuadagnoRicetta AS
SELECT R.CodRicetta,SUM(R.Costo) AS Guadagno
FROM Ricetta R NATURAL JOIN Ordine O
GROUP BY R.CodRicetta;

CREATE OR REPLACE VIEW IngredientiRicetta AS
SELECT DISTINCT R.CodRicetta,I.CodIngrediente,P.Dose,C.PrezzoAcquisto
FROM Ricetta R INNER JOIN Passaggio P USING(CodRicetta)
INNER JOIN Ingrediente I USING(CodIngrediente)
INNER JOIN Confezione C USING(CodIngrediente);

CREATE OR REPLACE VIEW SpesaRicetta AS
SELECT R.CodRicetta,SUM(R.Dose*R.PrezzoAcquisto) AS Spesa
FROM IngredientiRicetta R INNER JOIN Ordine O USING(CodRicetta)
GROUP BY R.CodRicetta;

SELECT G.CodRicetta,G.Guadagno/S.Spesa
FROM GuadagnoRicetta G NATURAL JOIN SpesaRicetta S;


------------------------------  8 ---------------------------------

SET SQL_SAFE_UPDATES = 0;
CREATE OR REPLACE VIEW OrdinazioniPiattoMenu AS
SELECT R.CodRicetta,P.CodMenu,COUNT(*) AS NumeroOrdinazioni
FROM Ricetta R NATURAL JOIN Ordine O
			   NATURAL JOIN Piatto P
GROUP BY R.CodRicetta,P.CodMenu;

CREATE OR REPLACE VIEW TotaleOrdinazioniMenu AS
SELECT CodMenu,SUM(NumeroOrdinazioni)  as TotaleMenu
FROM OrdinazioniPiattoMenu
GROUP BY CodMenu;

CREATE OR REPLACE VIEW Target AS
SELECT CodRicetta,CodMenu,IF(NumeroOrdinazioni IS NULL,0,NumeroOrdinazioni) AS NumeroOrdinazioni,IF(TotaleMenu IS NULL,0,TotaleMenu) AS TotaleMenu
FROM Piatto LEFT OUTER JOIN (OrdinazioniPiattoMenu INNER JOIN TotaleOrdinazioniMenu USING(CodMenu))
	  USING(CodRicetta,CodMenu)
ORDER BY CodRicetta,CodMenu;

DELETE P.* FROM Piatto P
WHERE (P.CodRicetta,P.CodMenu) IN (
	SELECT * FROM (
		SELECT CodRicetta,CodMenu FROM Target
        WHERE NumeroOrdinazioni < 0.05*TotaleMenu)
        AS D);