
				/*------------------------------------------------------*												
				 |		INDICE											|
				 |														|
				 |	1	CREAZIONE DATABASE E SCHWMA						|
				 |	2	VINCOLI DI INTEGRITA' DATABASE	PARTE 1			|
				 |	3	POPOLAMENTO										|
				 |	4   FUNZIONE ALìNALYTICS "RIFORIMENTO MAGAZZINO"	|
				 |	5	VINCOLI DI INTEGRITA' DATABASE	PARTE 2			| 
				 |	6	FUNZIONE ANALYTICS "MAGAZZINO INTELLIGENTE"		|
				 |	7	FUNZIONE ANALYTICS "QUALITA' DEL TAKE AWAY"		|
				 *------------------------------------------------------*/


/*-----------------------------------------------------------------------------------------------
	
	1	CREAZIONE DATABASE E SCHWMA
	
-----------------------------------------------------------------------------------------------*/

DROP database if exists CatenaRistorazione;
CREATE DATABASE IF NOT EXISTS CatenaRistorazione;
USE CatenaRistorazione;

CREATE TABLE IF NOT EXISTS Sede(
 	CodSede INT(11) PRIMARY KEY AUTO_INCREMENT,
    Citta CHAR(50) NOT NULL,
    Indirizzo CHAR(50) NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE IF NOT EXISTS Menu (
  CodMenu int(11) NOT NULL AUTO_INCREMENT,
  CodSede int(11) NOT NULL,
  DataInizio date NOT NULL,
  DataFine date NOT NULL,
  PRIMARY KEY (CodMenu),
  FOREIGN KEY (CodSede) REFERENCES Sede(CodSede) 
		ON DELETE CASCADE
        ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;

    
CREATE TABLE IF NOT EXISTS Tavolo(
    CodTavolo INT(11) PRIMARY KEY AUTO_INCREMENT,
    NumTavolo INT(11) NOT NULL,
    CodSede INT(11) NOT NULL,
    Sala CHAR(50),
    NumPosti INT(11) NOT NULL,
    FOREIGN KEY(CodSede) REFERENCES Sede(CodSede)
        ON DELETE CASCADE
		ON UPDATE CASCADE

)ENGINE=InnoDB DEFAULT CHARSET=UTF8;


CREATE TABLE IF NOT EXISTS Magazzino(
    CodMagazzino INT(11) PRIMARY KEY AUTO_INCREMENT,
    Citta CHAR(50) NOT NULL,
    Indirizzo CHAR(50) NOT NULL,
    CodSede INT(11) NOT NULL,
	FOREIGN KEY(CodSede) REFERENCES Sede(CodSede) 
        ON DELETE CASCADE
		ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;
  
CREATE TABLE IF NOT EXISTS Ingrediente (
    CodIngrediente INT(11) PRIMARY KEY AUTO_INCREMENT,
    NomeIngrediente CHAR(50) NOT NULL,
    Provenienza CHAR(50) NOT NULL,
    Genere CHAR(50) NOT NULL,
    TipoProduzione CHAR(50) NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE IF NOT EXISTS Confezione (
    CodConfezione INT(11)  AUTO_INCREMENT,
    CodIngrediente INT(11) NOT NULL,
    CodMagazzino INT(11) NOT NULL,
    Scaffale INT(11) NOT NULL,
    CodLotto INT(11) NOT NULL,
    Peso INT(11) NOT NULL,
    Stato VARCHAR(8) NOT NULL,
    Danneggiato BOOLEAN NOT NULL,
    Scadenza DATE NOT NULL,
    PrezzoAcquisto INT(11) NOT NULL,
    DataArrivo DATE NOT NULL,
    Primary key (CodConfezione),
    FOREIGN KEY(CodMagazzino) REFERENCES Magazzino(CodMagazzino)
		ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY(CodIngrediente) REFERENCES Ingrediente(CodIngrediente)
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;


CREATE TABLE IF NOT EXISTS Ricetta(
    CodRicetta INT(11) PRIMARY KEY AUTO_INCREMENT,
    NomeRicetta CHAR(50) NOT NULL,
    TestoRicetta VARCHAR(255) NOT NULL,
    NumeroRecensioni INT(11) NOT NULL DEFAULT 0,
    SommaRecensioni INT(11) NOT NULL DEFAULT 0,
    Costo INT(11) NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;


CREATE TABLE IF NOT EXISTS Macchinario (
    CodMacchinario INT(11) PRIMARY KEY AUTO_INCREMENT,
    NomeMacchinario CHAR(50) NOT NULL,
    CodSede INT(11) NOT NULL,
    FOREIGN KEY(CodSede) REFERENCES Sede(CodSede)
		ON DELETE CASCADE
		ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE IF NOT EXISTS Funzione(
    CodFunzione INT(11) PRIMARY KEY AUTO_INCREMENT,
    NomeFunzione CHAR(50),
    Tempo INT(11) NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CReATE TABLE IF NOT EXISTS Necessita(
	CodFunzione INT(11),
	CodMacchinario INT(11),
	PRIMARY KEY (CodFunzione,CodMacchinario),
	FOREIGN KEY(CodFunzione) REFERENCES Funzione(CodFunzione)
		ON DELETE CASCADE
        ON UPDATE CASCADE,
	FOREIGN KEY(CodMacchinario) REFERENCES Macchinario(CodMacchinario)
		ON DELETE CASCADE
        ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE IF NOT EXISTS Passaggio (
    CodRicetta INT(11) NOT NULL,
    NumeroPassaggio INT(11) NOT NULL,
    CodIngrediente INT(11) NOT NULL,
	Dose INT(11) NOT NULL,
    CodFunzione INT NOT NULL,
    PRIMARY KEY(CodRicetta,NumeroPassaggio),
    FOREIGN KEY(CodRicetta) REFERENCES Ricetta(CodRicetta)
		ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY(CodIngrediente) REFERENCES Ingrediente(CodIngrediente)
		ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY(CodFunzione) REFERENCES Funzione(CodFunzione)
    	ON DELETE CASCADE
    	ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;


CREATE TABLE IF NOT EXISTS Allergene (
    CodAllergene INT(11) PRIMARY KEY AUTO_INCREMENT,
    TipoAllergene CHAR(50) NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;


CREATE TABLE IF NOT EXISTS Allergia (
    CodIngrediente INT(11) NOT NULL,
    CodAllergene INT(11) NOT NULL,
    PRIMARY KEY(CodIngrediente,CodAllergene),
    FOREIGN KEY(CodIngrediente) REFERENCES Ingrediente(CodIngrediente)
		ON DELETE CASCADE,
    FOREIGN KEY(CodAllergene) REFERENCES Allergene(CodAllergene)
		ON DELETE CASCADE
        ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;


CREATE TABLE IF NOT EXISTS Account (
    Username CHAR(50) PRIMARY KEY,
    Nome CHAR(50) NOT NULL,
    Cognome CHAR(50) NOT NULL,
    eMail CHAR(50) NOT NULL,
    Password CHAR(200) NOT NULL,
    Ban BOOL DEFAULT 0
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE IF NOT EXISTS SerataTema (
	CodSerata INT(11) PRIMARY KEY AUTO_INCREMENT,
    NomeSerata CHAR(50) NOT NULL,
    Descrizione VARCHAR(255) NOT NULL,
    Username CHAR(50),
	FOREIGN KEY(Username) REFERENCES Account(Username)
		ON DELETE SET NULL
        ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE IF NOT EXISTS Prenotazione (
    CodPrenotazione INT(11) PRIMARY KEY AUTO_INCREMENT,
    CodSerata INT(11),
    Recapito INT(11),
    Username CHAR(50),
    DataPrenotazione DATETIME NOT NULL,
    FOREIGN KEY (CodSerata) REFERENCES SerataTema(CodSerata)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY(Username) REFERENCES Account(Username)
		ON DELETE SET NULL
        ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE IF NOT EXISTS Fattura (
    CodFattura INT(11) PRIMARY KEY AUTO_INCREMENT,
    DataEmissione TIMESTAMP NOT NULL,
    Importo INT(11) NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE IF NOT EXISTS Comanda (
    CodComanda INT(11) PRIMARY KEY  AUTO_INCREMENT,
    Stato CHAR(50) DEFAULT 'nuova',
    CodTavolo INT(11) NOT NULL,
	OraAcquisizione TIMESTAMP NOT NULL,
	CodPrenotazione INT(11) NOT NULL,
    CodFattura INT(11) NOT NULL,
    FOREIGN KEY(CodFattura) REFERENCES Fattura(CodFattura)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY(CodPrenotazione) REFERENCES Prenotazione(CodPrenotazione)
        ON DELETE NO ACTION
        ON UPDATE CASCADE,
    FOREIGN KEY(CodTavolo) REFERENCES Tavolo(CodTavolo)
		ON DELETE CASCADE
        ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE IF NOT EXISTS Pony (
    CodVeicolo INT(11) PRIMARY KEY AUTO_INCREMENT,
    Stato CHAR(50),
    CodSede INT(11) NOT NULL,
    FOREIGN KEY(CodSede) REFERENCES Sede(CodSede)
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;


CREATE TABLE IF NOT EXISTS ComandaTakeAway (
    CodAsporto INT(11) PRIMARY KEY AUTO_INCREMENT,
    Username CHAR(50),
    Stato CHAR(50),
    OraPartenza DATETIME NOT NULL,
    OraRitorno DATETIME NOT NULL,
    OraConsegna DATETIME NOT NULL,
    OraAcquisizione TIMESTAMP NOT NULL,
    CodVeicolo INT(11) NOT NULL,
    CodSede INT(11) NOT NULL,
	CodFattura INT(11) NOT NULL,
    FOREIGN KEY(CodSede) REFERENCES Sede(CodSede)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
    FOREIGN KEY(CodVeicolo) REFERENCES Pony(CodVeicolo),
    FOREIGN KEY(Username) REFERENCES Account(Username)
		ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY(CodFattura) REFERENCES Fattura(CodFattura)
        ON DELETE CASCADE
        ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE IF NOT EXISTS Coperto (
    CodPrenotazione INT(11),
    CodTavolo INT(11),
	NumeroCoperti INT(11) NOT NULL,
    PRIMARY KEY(CodPrenotazione,CodTavolo),
    FOREIGN KEY(CodPrenotazione) REFERENCES Prenotazione(CodPrenotazione)
		ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY(CodTavolo) REFERENCES Tavolo(CodTavolo)
		ON DELETE CASCADE
        ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;


CREATE TABLE IF NOT EXISTS Ordine(
    CodOrdine INT(11) PRIMARY KEY AUTO_INCREMENT,
    CodRicetta INT(11) NOT NULL,
    CodComanda INT(11) DEFAULT NULL,
    CodAsporto INT(11) DEFAULT NULL,
    Stato CHAR(50) DEFAULT 'attesa',
    FOREIGN KEY(CodRicetta) REFERENCES Ricetta(CodRicetta)
		ON DELETE NO ACTION
        ON UPDATE CASCADE,
    FOREIGN KEY(CodComanda) REFERENCES Comanda(CodComanda)
		ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY(CodAsporto) REFERENCES ComandaTakeAway(CodAsporto)
		ON DELETE CASCADE
        ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;

 
CREATE TABLE IF NOT EXISTS Piatto (
    CodMenu INT(11) NOT NULL,
    CodRicetta INT(11) NOT NULL,
    PRIMARY KEY(CodMenu,CodRicetta),
    FOREIGN KEY(CodMenu) REFERENCES Menu(CodMenu)
		ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY(CodRicetta) REFERENCES Ricetta(CodRicetta)
		ON DELETE CASCADE
        ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;


CREATE TABLE IF NOT EXISTS VariazionePossibile (
    CodVariazione INT(11) PRIMARY KEY AUTO_INCREMENT,
	NomeVariazione CHAR(50) NOT NULL,
    CodFunzione INT(11),
    CodIngrediente INT(11),
    NumeroPassaggio INT(11) NOT NULL,
    CodRicetta INT(11) NOT NULL,
	Disponibile BOOLEAN NOT NULL,
	Username CHAR(50),
    FOREIGN KEY(CodRicetta) REFERENCES Ricetta(CodRicetta)
		ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY(CodFunzione) REFERENCES Funzione(CodFunzione)
		ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY(CodIngrediente) REFERENCES Ingrediente(CodIngrediente)
		ON DELETE CASCADE
        ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;



CREATE TABLE IF NOT EXISTS Variazione(
    CodVariazione INT(11) NOT NULL,
    CodOrdine INT(11) NOT NULL,
    UNIQUE(CodVariazione,CodOrdine),
    FOREIGN KEY(CodVariazione) REFERENCES VariazionePossibile(CodVariazione)
		ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY(CodOrdine) REFERENCES Ordine(CodOrdine)
		ON DELETE CASCADE
        ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE IF NOT EXISTS Questionario (
    CodQuestionario INT(11) PRIMARY KEY AUTO_INCREMENT,
    CodSede INT(11) NOT NULL,
    FOREIGN KEY(CodSede) REFERENCES Sede(CodSede) 
		ON DELETE CASCADE
        ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE IF NOT EXISTS Domanda(
    CodDomanda INT(11) PRIMARY KEY AUTO_INCREMENT,
    CodQuestionario INT(11) NOT NULL,
    Testo VARCHAR(255) NOT NULL,
    FOREIGN KEY(CodQuestionario) REFERENCES Questionario(CodQuestionario) 
		ON DELETE CASCADE
        ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE IF NOT EXISTS Risposta(
    NumRisposta INT(11) NOT NULL,
    CodDomanda INT(11) NOT NULL,
	Testo VARCHAR(255),
    Punteggio INT(11) NOT NULL,
    PRIMARY KEY(NumRisposta,CodDomanda),
    FOREIGN KEY(CodDomanda) REFERENCES Domanda(CodDomanda) 
		ON DELETE CASCADE
        ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE IF NOT EXISTS Recensione(
    CodRecensione INT(11) PRIMARY KEY AUTO_INCREMENT,
    Username CHAR(50) NOT NULL,
    CodSede INT(11) NOT NULL,
    ValutazioneSede VARCHAR(255),
    PunteggioSede INT(11) NOT NULL,
    FOREIGN KEY(Username) REFERENCES Account(Username)
		ON DELETE NO ACTION
        ON UPDATE CASCADE,
    FOREIGN KEY(CodSede) REFERENCES Sede(CodSede)
		ON DELETE CASCADE
        ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;
    
CREATE TABLE IF NOT EXISTS RecensionePiatto (
    CodRecensionePiatto INT(11) PRIMARY KEY AUTO_INCREMENT,
    Testo VARCHAR(255) NOT NULL,
    Punteggio INT(11) NOT NULL,
    CodRicetta INT(11) NOT NULL,
    CodRecensione INT(11)NOT NULL,
    FOREIGN KEY(CodRicetta) REFERENCES Ricetta(CodRicetta),
    FOREIGN KEY(CodRecensione) REFERENCES Recensione(CodRecensione)
		ON DELETE CASCADE
        ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE IF NOT EXISTS RisposteUtente (
     CodRecensione INT(11) NOT NULL,
     CodDomanda INT(11) NOT NULL,
     NumRisposta INT(11) NOT NULL,
     PRIMARY KEY(CodRecensione,CodDomanda,NumRisposta),
     FOREIGN KEY(CodDomanda) REFERENCES Domanda(CodDomanda)
		ON DELETE CASCADE
        ON UPDATE CASCADE,
     FOREIGN KEY(CodDomanda,NumRisposta) REFERENCES Risposta(CodDomanda,NumRisposta)
		ON DELETE CASCADE
        ON UPDATE CASCADE,
     FOREIGN KEY(CodRecensione) REFERENCES Recensione(CodRecensione)
		ON DELETE CASCADE
        ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;


CREATE TABLE IF NOT EXISTS PropostaPiatto(
	CodProposta INT(11) PRIMARY KEY AUTO_INCREMENT,
    NomePiatto CHAR(50) NOT NULL,
    Procedimento VARCHAR(255) NOT NULL,
    Ingredienti VARCHAR(255) NOT NULL,
    Username CHAR(50),
    FOREIGN KEY(Username) REFERENCES Account(Username)
		ON DELETE SET NULL
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE IF NOT EXISTS ValutazioneRecensione(
	CodValutazione INT(11) PRIMARY KEY AUTO_INCREMENT,
	Punteggio INT(11) NOT NULL,
	CodRecensionePiatto INT(11),
	Username CHAR(50),
	FOREIGN KEY(CodRecensionePiatto) REFERENCES RecensionePiatto(CodRecensionePiatto)
		ON DELETE CASCADE
        ON UPDATE CASCADE,
	FOREIGN KEY(Username) REFERENCES Account(Username)
		ON DELETE SET NULL
        ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE IF NOT EXISTS GradimentoProposta (
	CodProposta INT(11) NOT NULL,
	Username CHAR(50) NOT NULL,
	Punteggio INT(11) DEFAULT 0,
	PRIMARY KEY(CodProposta, Username),
	FOREIGN KEY(CodProposta) REFERENCES PropostaPiatto(CodProposta)
		ON DELETE CASCADE,
	FOREIGN KEY (Username) REFERENCES Account(Username)
		ON DELETE CASCADE
		ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;



/*----------------------------------------------------------------------------------------------
	
	2 VINCOLI DI INTEGRITA' DATABASE PARTE 1
	
-----------------------------------------------------------------------------------------------*/

DROP TRIGGER IF EXISTS VincoloStatoConfezione;
DROP TRIGGER IF EXISTS VincoloUpdateConfezione;
DROP TRIGGER IF EXISTS VincoloFatturazione;
DROP TRIGGER IF EXISTS VincoloValutazioneRecensione;
DROP TRIGGER IF EXISTS VincoloStatoPreparazione;
DROP TRIGGER IF EXISTS VincoloUpdatePreparazione;
DROP TRIGGER IF EXISTS RidondanzaValutazioniPiatto;
DROP TRIGGER IF EXISTS VincoloStatoComanda;
DROP TRIGGER IF EXISTS VincoloUpdateComanda;
DROP TRIGGER IF EXISTS VincoloStatoComandaTA;
DROP TRIGGER IF EXISTS VincoloUpdateComandaTA;
DROP TRIGGER IF EXISTS controllaVariazioni;

/*Funzione che assegna automaticamente un pony ad una consegna:
	-Viene creato l'insieme di pony che hanno già consegnato almeno una volta,
	 calcolando il tempo medio (media armonica) di consegna.
    -Se ve n'è almeno uno libero, si assegna la consegna a quello con il tempo 
	 medio minore.
	-In caso contrario si assegna casualmente la consegna ad uno dei pony liberi rimanenti
*/

DROP FUNCTION IF EXISTS takeaway;
DELIMITER $$
CREATE FUNCTION takeaway (codAsporto INT)
RETURNS INT 
BEGIN
	DECLARE free INT;
    DECLARE sede INT;
    DECLARE minimoMedio DOUBLE;
    SET @pony = 0;    
	CREATE TEMPORARY TABLE IF NOT EXISTS Tempistica (
		Pony INT PRIMARY KEY,
        tempoMedio DOUBLE
	);
    

    
    REPLACE INTO Tempistica
		SELECT P.CodVeicolo,1/(AVG(1/TIMESTAMPDIFF(MINUTE,OraPartenza,OraConsegna))) FROM ComandaTakeAway
		INNER JOIN Pony P USING(CodVeicolo,CodSede)
		WHERE OraConsegna IS NOT NULL
		AND OraPartenza IS NOT NULL
        AND P.Stato = 'libero'
        AND CodSede = ( SELECT C.CodSede FROM ComandaTakeAway C WHERE C.CodAsporto = codAsporto LIMIT 1)
        AND P.CodVeicolo NOT IN ( SELECT Pony FROM mv_QualitaTakeAway)
		GROUP BY P.CodVeicolo;
        
	SELECT COUNT(*) INTO free FROM Tempistica; /*Numero di pony liberi per la consegna*/
    SELECT MIN(tempoMedio) INTO minimoMedio FROM Tempistica;

	IF(free>0) THEN /*Se almeno uno libero*/

		SELECT Pony  INTO @pony
        FROM Tempistica
        WHERE tempoMedio = minimoMedio
        LIMIT 1;
        INSERT INTO Debug(testo) VALUE(@pony);
        RETURN @pony;
	END IF;
    
    IF(free = 0) THEN /*Se nessuno libero scelgo tra quelli che non hanno*/
				  # consegne effettuate in passato
		SELECT CodVeicolo INTO @pony
        FROM Pony 
        WHERE Stato = 'libero'
        ORDER BY RAND() /*Ordinamento casuale del resultset*/
        LIMIT 1;
        RETURN @pony;
	END IF;

END $$
DELIMITER ;
#--Trigger per confezione-stato--#

DELIMITER $$
CREATE TRIGGER VincoloStatoConfezione
BEFORE INSERT ON Confezione
FOR EACH ROW
BEGIN
	IF( NEW.Stato != "completa" AND NEW.Stato != "parziale" AND NEW.Stato != "in uso") THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Lo stato non è accettato";
	END IF;
END $$ 


CREATE TRIGGER VincoloUpdateConfezione
BEFORE UPDATE ON Confezione
FOR EACH ROW
BEGIN
	IF( NEW.Stato != "Completo" OR NEW.Stato != "InUso" OR NEW.Stato != "Parziale") THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Lo stato non è accettato";
	END IF;
END $$
DELIMITER ;
#--------------------------------------#

#---Vincoli prepare---#

DELIMITER $$
CREATE TRIGGER VincoloStatoPreparazione
BEFORE INSERT ON Ordine
FOR EACH ROW
BEGIN
	IF( NEW.Stato != "attesa" AND NEW.Stato != "in preparazione" AND NEW.Stato != "servizio") THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Lo stato non è accettato";
	END IF;
	IF( (NEW.CodComanda IS NULL AND NEW.CodAsporto IS NULL) OR (NEW.CodComanda IS NOT NULL AND NEW.CodAsporto IS NOT NULL) )
		THEN
			SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = "Errrore, l'ordine non può essere di entrambi i tipi";
	END IF;
END $$


CREATE TRIGGER VincoloUpdatePreparazione
BEFORE UPDATE ON Ordine
FOR EACH ROW
BEGIN
	IF( NEW.Stato != "attesa" AND NEW.Stato != "in preparazione" AND NEW.Stato != "servizio") THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Lo stato non è accettato";
	END IF;
END $$
DELIMITER ;

#---Vincoli Comanda---#

DELIMITER $$
CREATE TRIGGER VincoloStatoComanda
BEFORE INSERT ON Comanda
FOR EACH ROW
BEGIN
	IF( NEW.Stato != "nuova" AND NEW.Stato != "in preparazione" AND NEW.Stato != "parziale"
		AND NEW.Stato != "evasa") THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Lo stato non è accettato";
	END IF;
END $$


CREATE TRIGGER VincoloUpdateComanda
BEFORE UPDATE ON Comanda
FOR EACH ROW
BEGIN
	IF( NEW.Stato != "nuova" AND NEW.Stato != "in preparazione" AND NEW.Stato != "parziale"
		AND NEW.Stato != "evasa") THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Lo stato non è accettato";
	END IF;
END $$
DELIMITER ;

#---Vincoli ComandaTA---#

DELIMITER $$
CREATE TRIGGER VincoloStatoComandaTA
BEFORE INSERT ON ComandaTakeAway
FOR EACH ROW
BEGIN
	IF( NEW.Stato != "in preparazione" 
		AND NEW.Stato != "parziale" AND NEW.Stato != "consegna" AND NEW.Stato != "nuova") THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Lo stato non è accettato";
	END IF;
END $$


CREATE TRIGGER VincoloUpdateComandaTA
BEFORE UPDATE ON ComandaTakeAway
FOR EACH ROW
BEGIN
	IF( NEW.Stato != "in preparazione" 
		AND NEW.Stato != "parziale" AND NEW.Stato != "consegna" AND NEW.Stato != "nuova") THEN		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Lo stato non è accettato";
	END IF;
END $$
DELIMITER ;

#---Max tre variazioni per ordine---#

DELIMITER $$
CREATE TRIGGER controllaVariazioni
BEFORE INSERT ON Variazione
FOR EACH ROW
BEGIN
	DECLARE numeroVariazioni INT;

	SELECT COUNT(*) INTO numeroVariazioni
	FROM Variazione
	WHERE CodOrdine = NEW.CodOrdine;

	IF(numeroVariazioni > 2) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT  = "Non sono ammesse più di tre variazioni per un ordine";
	END IF;
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS aggiuntaOrdine;
DELIMITER $$
CREATE TRIGGER aggiuntaOrdine
AFTER INSERT ON Ordine
FOR EACH ROW
BEGIN
	DECLARE costoPiatto INT;
	SELECT costo INTO costoPiatto FROM Ricetta
	WHERE CodRicetta = NEW.CodRicetta;

	IF(NEW.CodComanda IS NOT NULL) THEN  /*L'ordine è relativo al risorante*/
		UPDATE Fattura 
		SET Importo = Importo+costoPiatto
		WHERE CodFattura = (SELECT CodFattura FROM Comanda 
							WHERE CodComanda = NEW.CodComanda);
	END IF;
    
    IF(NEW.CodAsporto IS NOT NULL) THEN /*L'ordine è relativo al take away*/
		UPDATE Fattura 
		SET Importo = Importo+costoPiatto
		WHERE CodFattura = (SELECT CodFattura FROM ComandaTakeAway
							WHERE CodAsporto = NEW.CodAsporto);
	END IF;						
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS aggiornamentoOrdine;
DELIMITER $$
CREATE TRIGGER aggiornamentoOrdine
AFTER UPDATE ON Ordine
FOR EACH ROW
BEGIN

		DECLARE ready INT;
		DECLARE pony INT;
        

        
        
        /* *******************Mantiene aggiornata la ridondanza************* */
		DECLARE diffCosto INT;
		
		SELECT R.Costo-R1.Costo INTO diffCosto FROM Ricetta R,Ricetta R1
		WHERE R.CodRicetta = NEW.CodRicetta
		AND R1.CodRicetta = OLD.CodRicetta;
		
		IF(NEW.CodComanda IS NOT NULL) THEN  /*L'ordine è relativo al risorante*/
			UPDATE Fattura 
			SET Importo = Importo+diffCosto
			WHERE CodFattura = (SELECT CodFattura FROM Comanda 
								WHERE CodComanda = NEW.CodComanda);
		END IF;
		
		IF(NEW.CodAsporto IS NOT NULL) THEN /*L'ordine è relativo al take away*/
			UPDATE Fattura 
			SET Importo = Importo+diffCosto
			WHERE CodFattura = (SELECT CodFattura FROM ComandaTakeAway
								WHERE CodAsporto = NEW.CodAsporto);
		END IF;
        
        /*+++++++++++Gestisce il completamento delle comande++++++++++++++++*/
        
	IF(NEW.CodAsporto IS NOT NULL) THEN  /*L'ordine è relativo al takeaway*/
		IF(NEW.Stato = 'in preparazione') THEN
			UPDATE ComandaTakeAway
            SET Stato = 'in preparazione'
            WHERE CodAsporto = NEW.CodAsporto;
		END IF;
        
        
        
        SELECT COUNT(*) INTO ready FROM ComandaTakeAway C   /*Controllo se la comanda
													          ha tutti i piatti pronti*/
        WHERE C.CodAsporto = NEW.CodAsporto
        AND 'servizio' = ALL ( SELECT O.Stato FROM Ordine O
								 WHERE O.CodAsporto = C.CodAsporto);
                               
        
		IF(ready = 1) THEN

            UPDATE ComandaTakeAway 
            SET OraPartenza = NOW(),
            CodVeicolo = takeaway(NEW.CodAsporto),
            Stato = 'consegna'
			WHERE CodAsporto = NEW.CodAsporto;
            
            UPDATE Pony  /*Imposto ad occupato lo stato del pony*/
			SET Stato='Occupato'
            WHERE CodVeicolo = pony;
		END IF;
        ELSE IF(NEW.Stato = 'servizio') THEN /*Se almeno un piatto è completato
											   ma non tutti*/
			UPDATE ComandaTakeAway
            SET Stato = 'parziale'
            WHERE CodAsporto = NEW.CodAsporto;
		END IF;
  	END IF;
    
    IF(NEW.CodComanda IS NOT NULL) THEN  /*Ordine relativo al ristorante*/
		IF(NEW.Stato = 'in preparazione') THEN
			UPDATE Comanda
			SET Stato = 'in preparazione'
			WHERE CodComanda = NEW.CodComanda;
		END IF;
        
        SELECT COUNT(*) INTO ready FROM Comanda C
        WHERE C.CodComanda = NEW.CodComanda
        AND 'servizio' = ALL ( SELECT O.Stato FROM Ordine O
								 WHERE O.CodComanda = C.CodComanda);
                                 
		IF(ready = 1) THEN
            UPDATE Comanda 
            SET Stato = 'evasa'
			WHERE CodComanda = NEW.CodComanda;
        ELSE IF(NEW.Stato = 'servizio') THEN
			UPDATE Comanda
            SET Stato='parziale'
            WHERE CodComanda = NEW.CodComanda;
			UPDATE Comanda
            SET Stato = 'parziale'
            WHERE CodComanda = NEW.CodComanda;
		END IF;
		END IF;
	END IF;  
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS rimozioneOrdine;
DELIMITER $$
CREATE TRIGGER rimozioneOrdine
AFTER DELETE ON Ordine
FOR EACH ROW
BEGIN
	DECLARE costoPiatto INT;
    
	SELECT costo INTO costoPiatto FROM Ricetta
	WHERE CodRicetta = OLD.CodRicetta;
    
	IF(OLD.CodComanda IS NOT NULL) THEN  /*L'ordine è relativo al risorante*/
		UPDATE Fattura 
		SET Importo = Importo-costoPiatto
		WHERE CodFattura = (SELECT CodFattura FROM Comanda 
							WHERE CodComanda = OLD.CodComanda);
	END IF;
    
    IF(OLD.CodAsporto IS NOT NULL) THEN /*L'ordine è relativo al take away*/
		UPDATE Fattura 
		SET Importo = Importo-costoPiatto
		WHERE CodFattura = (SELECT CodFattura FROM ComandaTakeAway
							WHERE CodAsporto = OLD.CodAsporto);
	END IF;						
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS aggiuntaRecensione;
DELIMITER $$
CREATE TRIGGER aggiuntaRecensione
AFTER INSERT ON RecensionePiatto
FOR EACH ROW
BEGIN
	UPDATE Ricetta 
	SET NumeroRecensioni = NumeroRecensioni+1,
		SommaRecensioni = SommaRecensioni+NEW.Punteggio
	WHERE CodRicetta = NEW.CodRicetta;
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS aggiornamentoRecensione;
DELIMITER $$
CREATE TRIGGER aggiornamentoRecensione
AFTER UPDATE ON RecensionePiatto
FOR EACH ROW
BEGIN
	DECLARE diffPunteggio INT;
    SET diffPunteggio = NEW.Punteggio-OLD.Punteggio;
	
    UPDATE Ricetta 
	SET SommaRecensioni = SommaRecensioni+diffPunteggio
	WHERE CodRicetta = OLD.CodRicetta; /* Si suppone non sia possibile 
									    cambiare il piatto di una recensione*/
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS rimozioneRecensione;
DELIMITER $$
CREATE TRIGGER rimozioneRecensione
AFTER DELETE ON RecensionePiatto
FOR EACH ROW
BEGIN
	UPDATE Ricetta 
	SET NumeroRecensioni = NumeroRecensioni-1,
		SommaRecensioni = SommaRecensioni-OLD.Punteggio
	WHERE CodRicetta = OLD.CodRicetta;
END $$
DELIMITER ;

DROP EVENT IF EXISTS BanAccount;
DELIMITER $$
CREATE EVENT BanAccount
ON SCHEDULE EVERY 1 WEEK
DO
BEGIN
	DECLARE finito INT DEFAULT 0;
    DECLARE tmpUser CHAR(50);
    
	DECLARE accountBan CURSOR FOR
		SELECT  P.Username 
        FROM Prenotazione P
		WHERE P.Username IS NOT NULL
		AND P.DataPrenotazione < CURRENT_DATE
		AND NOT EXISTS (
			SELECT * FROM Comanda C WHERE
			C.CodPrenotazione = P.CodPrenotazione);
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND
		SET finito = 1;
	
	OPEN accountBan;
    
    scan: LOOP
		FETCH accountBan INTO tmpUser;
        
        IF(finito = 1) THEN LEAVE scan;
        END IF;
        
        UPDATE Account
        SET Ban = 1
        WHERE Username = tmpUser;
	END LOOP scan;
END $$
DELIMITER ;


/*----------------------------------------------------------------------------------------------
	
	3	POPOLAMENTO
	
-----------------------------------------------------------------------------------------------*/
INSERT INTO Sede (Citta, Indirizzo) VALUES	
	('Milano','Via Monti 10'),
	('Torino','Via Prati 12'),
	('Palermo','Via Fratti 120'),
	('Rimini','Via Macelli 64'),
	('Lucca','Via Fillungo 121');

INSERT INTO Ingrediente (NomeIngrediente, Provenienza, Genere, TipoProduzione) VALUES
	('Manzo Argentino','Argentina','Carne','OGM'),
    ('Farina','Italia','Farinaceo','Biologico'),
    ('Salsa di Pomodoro','Italia','Preparato','Propria'),
    ('Cipolla Tropea','Italia','Ortaggio','OGM'),
    ('Riso','Italia','Cereale','Biologico'),
    ('Sale','Italia','Spezia','Biologico'),
    ('Basilico','Italia','Graminacea','Biologico'),
    ('Pane','Italia','Derivato','Industriale'),
    ('Latte','Svizzera','Materia Prima','Biologico'),
    ('Sale','Francia','Spezie','Industriale'),
	('Aglio','Italia','Vegetale','Biologico'),
	('Seppie','Italia','Pesce','Fresco'),
	('Pomodoro','Italia','Verdura','Biologico'),
	('Piselli','Italia','Verdura','Biologico'),
	('Olio','Italia','Codimento','Biologico'),
	('Polpo','Italia','Pesce','Fresco'),
	('Sedano','Italia','Verdura','Biologio'),
	('Carote','Italia','Verdura','Biologico'),
	('Zucchine','Cina','Verdura','OGM'),
	('Penne','Italia','Pasta','Industriale'),
	('Pasta Sfoglia','Italia','Preparato','Propria'),
	('Pera','Cina','Frutta','OGM'),
	('Composto','/','Misto','Propria');
                        
INSERT INTO Allergene (TipoAllergene) VALUES 
	('Glutine'),
	('Crostacei'),
	('Latticini'),
	('Arachidi'),
	('Noci'),
	('Molluschi'),
	('OGM');
	
INSERT INTO Allergia (CodIngrediente, CodAllergene) VALUES
	(2,1),(8,1),(9,3),(12,6),(16,6),(20,1),(21,1),(22,7),(1,7),(19,7);
	
INSERT INTO Account (Username, Nome, Cognome, eMail, Password, Ban) VALUES	
	('Marco88', 'Smeralda', 'Costa', 'lanfra@gmail.com', 'Pippo', 0),
	('Pippo1022', 'Felice', 'Evacuo', 'pippo1022@hotmail.it', 'Coccio', 0),
	('Paperino44', 'Assunta', 'Manno', 'yoko@outlook.it', 'Sbirulo', 0),
	('Argonauta', 'Ernesto', 'Sparalesto', 'sparaspara@gmail.com', 'bang', 0),
	('Gigetto','Emiliana', 'Lasagna', 'gigio@hotmail.it', 'Topo', 0),
	('Grigio', 'Guido', 'Piano', 'solio@gmail.com', 'Arancio', 0),
	('Ultras', 'Marino', 'Spargisale', 'ultras@hotmail.it', 'Verotifoso', 0),
	('Ing', 'Massimo', 'Ingegno', 'ingegnere@gmail.com', 'Tuttoio', 0);

INSERT INTO Magazzino(Citta,Indirizzo,CodSede) VALUES
	('Milano','Via Pelagi 10',1),	
	('Milano','Via Boicio 12',1),
    ('Rimini','Via Coddo 20',4),
    ('Torino','Via Dini 1',2), 
    ('Palermo','Via Gaussi 21',3),
    ('Lucca','Via Amperiti 15',5);

INSERT INTO Macchinario (NomeMacchinario, CodSede) VALUES
 	('Bollitore',1),('Padella',1),('Forno',1),('Abbattitore',1),('Frullatore',1),('Tagliere',1),
	('Bollitore',2),('Padella',2),('Forno',2),('Abbattitore',2),('Frullatore',2),('Tagliere',2),
	('Bollitore',3),('Padella',3),('Forno',3),('Abbattitore',3),('Frullatore',3),('Tagliere',3),
	('Bollitore',4),('Padella',4),('Forno',4),('Abbattitore',4),('Frullatore',4),('Tagliere',4),
	('Bollitore',5),('Padella',5),('Forno',5),('Abbattitore',5),('Frullatore',5),('Tagliere',5),
	('Pianale',1),('Pianale',2),('Pianale',3),('Pianale',4),('Pianale',5),
	('Forno',1),('Forno',2),('Forno',3),('Forno',4),('Forno',5) ;
								
INSERT INTO Funzione (NomeFunzione, Tempo) VALUES 
	('Bollitura riso',15),
    ('Bollitura pasta',5),
	('Riscaldare Seppie',5),
	('Riscaldare Polpo',5),
	('Affettare',1),
	('Arrotolare Pasta Sfoglia',1),
	('Impiattare',1),
	('Soffriggere',1),
	('Aggiungere',0),	
	('Cottura Sfoglia',5),
    ('Tosta',10),
    ('Congelamento',30),
    ('Riscaldare Sugo',2);
	
INSERT INTO Necessita VALUES
	(1,1),(2,2),(2,8),(2,14),(2,20),(2,26),
	(3,1),(3,7),(3,13),(3,19),(3,25),
	(4,2),(4,8),(4,14),(4,20),(4,26),
	(5,6),(5,12),(5,18),(5,24),(5,30),
	(6,31),(6,32),(6,33),(6,34),(6,35),
	(7,31),(7,32),(7,33),(7,34),(7,35),
	(8,2),(8,8),(8,14),(8,20),(8,26),
	(9,2),(9,8),(9,14),(9,20),(9,26),
	(10,31),(10,32),(10,33),(10,34),(10,35),
	(11,3),(12,4),(13,2),(13,8),(13,14),(13,20),(13,26);

SET @data = CURRENT_DATE + INTERVAL 1 MONTH;
SET @data2 = CURRENT_DATE + INTERVAL 10 DAY;
SET @data3 = CURRENT_DATE + INTERVAL 1 DAY;

INSERT INTO Confezione (CodIngrediente,CodMagazzino, Scaffale, CodLotto, Peso, Stato, Danneggiato, Scadenza, PrezzoAcquisto, DataArrivo) VALUES
	(1,1,1,115,1000,'completa',0,@data, 10, CURRENT_DATE),
	(2,1,1,133,1000,'completa',0,@data, 1, CURRENT_DATE),
	(3,2,1,166,800,'parziale',0,@data2, 1, CURRENT_DATE),
	(4,1,1,117,1000,'completa',0,@data, 1, CURRENT_DATE),
	(5,1,1,114,1000,'completa',0,@data, 1, CURRENT_DATE),
	(6,1,1,155,1000,'completa',0,@data, 1, CURRENT_DATE),
	(7,2,1,165,1000,'completa',0,@data3, 1, CURRENT_DATE),
	(8,1,1,125,800,'parziale',0,@data, 1, CURRENT_DATE),
	(9,1,1,175,1000,'completa',0,@data2, 1, CURRENT_DATE),
	(10,1,1,215,1000,'completa',0,@data, 1, CURRENT_DATE),
	(11,1,1,225,1000,'completa',0,@data, 1, CURRENT_DATE),
	(12,1,1,199,1000,'completa',0,@data2, 10, CURRENT_DATE),
	(13,1,1,105,1000,'completa',0,@data, 1, CURRENT_DATE),
	(14,1,1,815,1000,'completa',0,@data3, 1, CURRENT_DATE),
	(15,2,1,315,1000,'completa',0,@data, 1, CURRENT_DATE),
	(16,1,1,415,1000,'completa',0,@data2, 10, CURRENT_DATE),
	(17,1,1,085,1000,'completa',0,@data, 1, CURRENT_DATE),
	(18,1,1,045,1000,'completa',0,@data3, 1, CURRENT_DATE),
	(19,1,1,005,1000,'completa',0,@data, 1, CURRENT_DATE),
	(20,1,1,140,1000,'completa',0,@data2, 1, CURRENT_DATE),
	(21,2,1,150,1000,'completa',0,@data, 1, CURRENT_DATE),
	(22,1,1,160,1000,'completa',0,@data3, 1, CURRENT_DATE),
	(23,1,1,170,1000,'completa',0,@data, 1, CURRENT_DATE),
	
	(1,3,1,115,1000,'completa',0,@data, 10, CURRENT_DATE),
	(2,3,1,133,1000,'completa',0,@data2, 1, CURRENT_DATE),
	(3,3,1,166,800,'parziale',0,@data, 1, CURRENT_DATE),
	(4,3,1,117,1000,'completa',0,@data, 1, CURRENT_DATE),
	(5,3,1,114,1000,'completa',0,@data3, 1, CURRENT_DATE),
	(6,3,1,155,1000,'completa',0,@data, 1, CURRENT_DATE),
	(7,3,1,165,1000,'completa',0,@data2, 1, CURRENT_DATE),
	(8,3,1,125,800,'parziale',0,@data, 1, CURRENT_DATE),
	(9,3,1,175,1000,'completa',0,@data, 1, CURRENT_DATE),
	(10,3,1,215,1000,'completa',0,@data2, 1, CURRENT_DATE),
	(11,3,1,225,1000,'completa',0,@data3, 1, CURRENT_DATE),
	(12,3,1,199,1000,'completa',0,@data, 10, CURRENT_DATE),
	(13,3,1,105,1000,'completa',0,@data, 1, CURRENT_DATE),
	(14,3,1,815,1000,'completa',0,@data, 1, CURRENT_DATE),
	(15,3,1,315,1000,'completa',0,@data3, 1, CURRENT_DATE),
	(16,3,1,415,1000,'completa',0,@data2, 10, CURRENT_DATE),
	(17,3,1,085,1000,'completa',0,@data, 1, CURRENT_DATE),
	(18,3,1,045,1000,'completa',0,@data2, 1, CURRENT_DATE),
	(19,3,1,005,1000,'completa',0,@data, 1, CURRENT_DATE),
	(20,3,1,140,1000,'completa',0,@data, 1, CURRENT_DATE),
	(21,3,1,150,1000,'completa',0,@data2, 1, CURRENT_DATE),
	(22,3,1,160,1000,'completa',0,@data, 1, CURRENT_DATE),
	(23,3,1,170,1000,'completa',0,@data, 1, CURRENT_DATE),
	
	(1,4,1,115,1000,'completa',0,@data2, 10, CURRENT_DATE),
	(2,4,1,133,1000,'completa',0,@data, 1, CURRENT_DATE),
	(3,4,1,166,800,'parziale',0,@data3, 1, CURRENT_DATE),
	(4,4,1,117,1000,'completa',0,@data2, 1, CURRENT_DATE),
	(5,4,1,114,1000,'completa',1,@data, 1, CURRENT_DATE),
	(6,4,1,155,1000,'completa',0,@data, 1, CURRENT_DATE),
	(7,4,1,165,1000,'completa',0,@data2, 1, CURRENT_DATE),
	(8,4,1,125,800,'parziale',0,@data, 1, CURRENT_DATE),
	(9,4,1,175,1000,'completa',0,@data2, 1, CURRENT_DATE),
	(10,4,1,215,1000,'completa',0,@data, 1, CURRENT_DATE),
	(11,4,1,225,1000,'completa',0,@data2, 1, CURRENT_DATE),
	(12,4,1,199,1000,'completa',0,@data2, 10, CURRENT_DATE),
	(13,4,1,105,1000,'completa',0,@data2, 1, CURRENT_DATE),
	(14,4,1,815,1000,'completa',0,@data2, 1, CURRENT_DATE),
	(15,4,1,315,1000,'completa',0,@data2, 1, CURRENT_DATE),
	(16,4,1,415,1000,'completa',0,@data, 10, CURRENT_DATE),
	(17,4,1,085,1000,'completa',0,@data3, 1, CURRENT_DATE),
	(18,4,1,045,1000,'completa',1,@data, 1, CURRENT_DATE),
	(19,4,1,005,1000,'completa',0,@data2, 1, CURRENT_DATE),
	(20,4,1,140,1000,'completa',0,@data2, 1, CURRENT_DATE),
	(21,4,1,150,1000,'completa',0,@data, 1, CURRENT_DATE),
	(22,4,1,160,1000,'completa',0,@data, 1, CURRENT_DATE),
	(23,4,1,170,1000,'completa',0,@data, 1, CURRENT_DATE),
	
	(1,5,1,115,1000,'completa',0,@data, 10, CURRENT_DATE),
	(2,5,1,133,1000,'completa',0,@data, 1, CURRENT_DATE),
	(3,5,1,166,800,'parziale',0,@data2, 1, CURRENT_DATE),
	(4,5,1,117,1000,'completa',0,@data2, 1, CURRENT_DATE),
	(5,5,1,114,1000,'completa',1,@data, 1, CURRENT_DATE),
	(6,5,1,155,1000,'completa',0,@data3, 1, CURRENT_DATE),
	(7,5,1,165,1000,'completa',0,@data2, 1, CURRENT_DATE),
	(8,5,1,125,800,'parziale',0,@data2, 1, CURRENT_DATE),
	(9,5,1,175,1000,'completa',0,@data, 1, CURRENT_DATE),
	(10,5,1,215,1000,'completa',0,@data, 1, CURRENT_DATE),
	(11,5,1,225,1000,'completa',0,@data, 1, CURRENT_DATE),
	(12,5,1,199,1000,'completa',1,@data, 10, CURRENT_DATE),
	(13,5,1,105,1000,'completa',0,@data2, 1, CURRENT_DATE),
	(14,5,1,815,1000,'completa',0,@data, 1, CURRENT_DATE),
	(15,5,1,315,1000,'completa',0,@data, 1, CURRENT_DATE),
	(16,5,1,415,1000,'completa',0,@data2, 10, CURRENT_DATE),
	(17,5,1,085,1000,'completa',0,@data2, 1, CURRENT_DATE),
	(18,5,1,045,1000,'completa',0,@data, 1, CURRENT_DATE),
	(19,5,1,005,1000,'completa',1,@data, 1, CURRENT_DATE),
	(20,5,1,140,1000,'completa',0,@data, 1, CURRENT_DATE),
	(21,5,1,150,1000,'completa',0,@data2, 1, CURRENT_DATE),
	(22,5,1,160,1000,'completa',0,@data2, 1, CURRENT_DATE),
	(23,5,1,170,1000,'completa',0,@data2, 1, CURRENT_DATE),
	
	(1,6,1,115,1000,'completa',0,@data2, 10, CURRENT_DATE),
	(2,6,1,133,1000,'completa',1,@data3, 1, CURRENT_DATE),
	(3,6,1,166,800,'parziale',0,@data, 1, CURRENT_DATE),
	(4,6,1,117,1000,'completa',0,@data2, 1, CURRENT_DATE),
	(5,6,1,114,1000,'completa',0,@data, 1, CURRENT_DATE),
	(6,6,1,155,1000,'completa',0,@data, 1, CURRENT_DATE),
	(7,6,1,165,1000,'completa',0,@data2, 1, CURRENT_DATE),
	(8,6,1,125,800,'parziale',0,@data2, 1, CURRENT_DATE),
	(9,6,1,175,1000,'completa',0,@data, 1, CURRENT_DATE),
	(10,6,1,215,1000,'completa',0,@data, 1, CURRENT_DATE),
	(11,6,1,225,1000,'completa',0,@data, 1, CURRENT_DATE),
	(12,6,1,199,1000,'completa',0,@data, 10, CURRENT_DATE),
	(13,6,1,105,1000,'completa',0,@data, 1, CURRENT_DATE),
	(14,6,1,815,1000,'completa',0,@data3, 1, CURRENT_DATE),
	(15,6,1,315,1000,'completa',0,@data2, 1, CURRENT_DATE),
	(16,6,1,415,1000,'completa',0,@data2, 10, CURRENT_DATE),
	(17,6,1,085,1000,'completa',0,@data, 1, CURRENT_DATE),
	(18,6,1,045,1000,'completa',0,@data3, 1, CURRENT_DATE),
	(19,6,1,005,1000,'completa',0,@data, 1, CURRENT_DATE),
	(20,6,1,140,1000,'completa',0,@data, 1, CURRENT_DATE),
	(21,6,1,150,1000,'completa',0,@data2, 1, CURRENT_DATE),
	(22,6,1,160,1000,'completa',0,@data, 1, CURRENT_DATE),
	(23,6,1,170,1000,'completa',0,@data3, 1, CURRENT_DATE);
	
INSERT INTO Tavolo (NumTavolo, CodSede, Sala, NumPosti) VALUES
	(1, 1, 'Blu', 2), (2, 1, 'Blu', 4), (3, 1, 'Rossa', 2),
	(4, 1, 'Rossa', 2), (5, 1, 'Rossa', 6), (6, 1, 'Blu', 10),	
	(1, 2, 'Blu', 2), (2, 2, 'Blu', 4), (3, 2, 'Rossa', 2),
	(4, 2, 'Rossa', 2), (5, 2, 'Rossa', 6), (6, 2, 'Blu', 10),	
	(1, 3, 'Blu', 2), (2, 3, 'Blu', 4), (3, 3, 'Rossa', 2),
	(4, 3, 'Rossa', 2), (5, 3, 'Rossa', 6), (6, 3, 'Blu', 10),	
	(1, 4, 'Blu', 2), (2, 4, 'Blu', 4), (3, 4, 'Rossa', 2),
	(4, 4, 'Rossa', 2), (5, 4, 'Rossa', 6), (6, 4, 'Blu', 10),	
	(1, 5, 'Blu', 2), (2, 5, 'Blu', 4), (3, 5, 'Rossa', 2),
	(4, 5, 'Rossa', 2), (5, 5, 'Rossa', 6), (6, 5, 'Blu', 10);

	
INSERT INTO Tavolo (NumTavolo, CodSede, Sala, NumPosti) VALUES
	(1, 1, 'Blu', 2), (2, 1, 'Blu', 4), (3, 1, 'Rossa', 2),
	(4, 1, 'Rossa', 2), (5, 1, 'Rossa', 6), (6, 1, 'Blu', 10),	
	(1, 2, 'Blu', 2), (2, 2, 'Blu', 4), (3, 2, 'Rossa', 2),
	(4, 2, 'Rossa', 2), (5, 2, 'Rossa', 6), (6, 2, 'Blu', 10),	
	(1, 3, 'Blu', 2), (2, 3, 'Blu', 4), (3, 3, 'Rossa', 2),
	(4, 3, 'Rossa', 2), (5, 3, 'Rossa', 6), (6, 3, 'Blu', 10),	
	(1, 4, 'Blu', 2), (2, 4, 'Blu', 4), (3, 4, 'Rossa', 2),
	(4, 4, 'Rossa', 2), (5, 4, 'Rossa', 6), (6, 4, 'Blu', 10),	
	(1, 5, 'Blu', 2), (2, 5, 'Blu', 4), (3, 5, 'Rossa', 2),
	(4, 5, 'Rossa', 2), (5, 5, 'Rossa', 6), (6, 5, 'Blu', 10);

INSERT INTO Menu (CodSede, DataInizio, DataFine) VALUES
	(1, '2013-01-01', '2013-12-31'),(1, '2014-01-01', '2016-12-31'),
	(2, '2013-01-01', '2013-12-31'),(2, '2014-01-01', '2016-12-31'),
	(3, '2013-01-01', '2013-12-31'),(3, '2014-01-01', '2016-12-31'),
	(4, '2013-01-01', '2013-12-31'),(4, '2014-01-01', '2016-12-31'),
	(5, '2013-01-01', '2013-12-31'),(5, '2014-01-01', '2016-12-31');

INSERT INTO Ricetta (NomeRicetta, Costo, TestoRicetta, NumeroRecensioni, SommaRecensioni) VALUES
	('Seppie con Piselli', 12, 'Mettere in una pentola a soffriggere aglio, cipolla e olio; aggiungere seppie 
		pomodoro e piselli, cuocere a fuoco lento 15 minuti', 0,0),
	('Polpo su Letto di Verdure', 12, 'Riscaldare il polpo, affettare le verdure e comporre il piatto',0,0),
	('Pasta al Pomodoro', 7, 'Cuocere la pasta, riscaldare il sugo e servire', 0, 0),
	('Bruschetta al Pomodoro', 5, 'Affettare il pomodoro, unire aglio olio e sale, cospargere il pane tagliato a fette',0,0),
	('Sfoglia alle Pere', 5, 'Affettare le pere, avvolgerle con la sfoglia e infornare 5 minuti a 180 gradi',0,0);

INSERT INTO Piatto (CodRicetta, CodMenu) VALUES
	(1,1),(3,1),(4,1),(5,1), (2,2),(3,2),(4,2),(5,2),
	(1,3),(3,3),(4,3),(5,3), (2,4),(3,4),(4,4),(5,4),
	(2,5),(3,5),(4,5),(5,5), (1,6),(3,6),(4,6),(5,6),
	(1,7),(3,7),(4,7),(5,7), (2,8),(3,8),(4,8),(5,8),
	(2,9),(3,9),(4,9),(5,9), (1,10),(3,10),(4,10),(5,10);

INSERT INTO Passaggio(CodRicetta, NumeroPassaggio, CodIngrediente, CodFunzione,Dose) VALUES
	(1,1,11,9,1), (1,2,15,9,1),(1,3,10,9,1),(1,4,23,8,0),(1,5,14,9,30),(1,6,12,9,60),(1,7,13,9,30),(1,8,23,3,0),(1,9,23,7,0),

	(2,1,16,4,60),(2,2,17,5,40),(2,3,18,5,40),(2,4,19,5,30),(2,5,23,7,0),
	
	(3,1,20,2,90),(3,2,3,13,40),(3,3,23,7,0),

	(4,1,13,5,30),(4,2,11,5,1),(4,3,10,5,1),(4,4,8,5,40),(4,5,23,7,0),
	
	(5,1,22,5,20),(5,2,21,6,10),(5,3,23,10,0),(5,4,23,7,0);

	
INSERT INTO SerataTema (NomeSerata, Descrizione,Username) VALUES
	('Disco','Disco Music','Marco88'), ('Egitto','In maschera','Pippo1022'),
	('Pirati','In maschera','Paperino44'), ('Carnevale','In maschera','Argonauta');

INSERT INTO Questionario (CodSede) VALUES
	(1), (2), (3), (4), (5);

INSERT INTO Domanda (CodQuestionario, Testo) VALUES
	(1,'Qualità servizio'), (1,'Intrattenimento'), (1,'Prezzo'),
	(2,'Qualità servizio'), (2,'Intrattenimento'), (2,'Prezzo'),
	(3,'Qualità servizio'), (3,'Intrattenimento'), (3,'Prezzo'),
	(4,'Qualità servizio'), (4,'Intrattenimento'), (4,'Prezzo'),
	(5,'Qualità servizio'), (5,'Intrattenimento'), (5,'Prezzo');
	
INSERT INTO Risposta (NumRisposta, CodDomanda , Punteggio, Testo) VALUES
	(1, 1, 1, 'Scarso'), (2, 1, 2, 'Buono'), (3, 1, 3, 'Ottimo'),
	(1, 2, 1, 'Scarso'), (2, 2, 2, 'Buono'), (3, 2, 3, 'Ottimo'),
	(1, 3, 1, 'Scarso'), (2, 3, 2, 'Buono'), (3, 3, 3, 'Ottimo'),
	(1, 4, 1, 'Scarso'), (2, 4, 2, 'Buono'), (3, 4, 3, 'Ottimo'),
	(1, 5, 1, 'Scarso'), (2, 5, 2, 'Buono'), (3, 5, 3, 'Ottimo'),
	(1, 6, 1, 'Scarso'), (2, 6, 2, 'Buono'), (3, 6, 3, 'Ottimo'),
	(1, 7, 1, 'Scarso'), (2, 7, 2, 'Buono'), (3, 7, 3, 'Ottimo'),
	(1, 8, 1, 'Scarso'), (2, 8, 2, 'Buono'), (3, 8, 3, 'Ottimo'),
	(1, 9, 1, 'Scarso'), (2, 9, 2, 'Buono'), (3, 9, 3, 'Ottimo'),
	(1, 10, 1, 'Scarso'), (2, 10, 2, 'Buono'), (3, 10, 3, 'Ottimo'),
	(1, 11, 1, 'Scarso'), (2, 11, 2, 'Buono'), (3, 11, 3, 'Ottimo'),
	(1, 12, 1, 'Scarso'), (2, 12, 2, 'Buono'), (3, 12, 3, 'Ottimo'),
	(1, 13, 1, 'Scarso'), (2, 13, 2, 'Buono'), (3, 13, 3, 'Ottimo'),
	(1, 14, 1, 'Scarso'), (2, 14, 2, 'Buono'), (3, 14, 3, 'Ottimo'),
	(1, 15, 1, 'Scarso'), (2, 15, 2, 'Buono'), (3, 15, 3, 'Ottimo');
	
INSERT INTO PropostaPiatto (NomePiatto, Procedimento, Ingredienti, Username) VALUES
	('Asparagi e Fontina','Arrotolare una fetta di fontina attorno 
		agli asparagi e cuocere in forno 180° 10 minuti','Asparagi, Fontina, Olio, Sale','Marco88'),
	('Pomodori grainati','Dividere in due il pomodoro, cospargere di mozzarella e pan grattato,
		infornare per 30 minuti a 250°','Pomodoro,Mozzarella,PanGrattato, Olio, Sale','Paperino44');
		
INSERT INTO GradimentoProposta (CodProposta, Username, Punteggio) VALUES
	(1,'Pippo1022',5), (1,'Paperino44',4), (1,'Grigio',5), (1,'Ing',5),
	(2,'Marco88',5), (2,'Paperino44',4), (2,'Grigio',5), (2,'Gigetto',5);

INSERT INTO Recensione (Username, CodSede, ValutazioneSede, PunteggioSede) VALUES
	('Marco88',1,'Buona',4), ('Paperino44',1,'Ottima',5), ('Argonauta',1,'Scarsa',2),
	('Ultras',2,'Buona',4), ('Gigetto',2,'Ottima',5), ('Pippo1022',2,'Scarsa',2),
	('Marco88',3,'Buona',4), ('Paperino44',3,'Ottima',5), ('Grigio',3,'Buona',3),
	('Marco88',4,'Buona',4), ('Ing',4,'Ottima',5), ('Ultras',4,'Scarsa',1),
	('Grigio',5,'Buona',3), ('Paperino44',5,'Ottima',4), ('Pippo1022',5,'Ottima',5);
	
INSERT INTO RisposteUtente (CodRecensione, CodDomanda, NumRisposta) VALUES
	(1,1,3),(1,2,1),(1,3,1), (2,1,3),(2,2,1),(2,3,2), (3,1,2),(3,2,1),(3,3,1),
	(4,1,3),(4,2,1),(4,3,1), (5,1,3),(5,2,1),(5,3,2), (6,1,2),(6,2,1),(6,3,1),
	(7,1,3),(7,2,1),(7,3,1), (8,1,3),(8,2,1),(8,3,2), (9,1,2),(9,2,1),(9,3,1),
	(10,1,3),(10,2,1),(10,3,1), (11,1,3),(11,2,1),(11,3,2), (12,1,2),(12,2,1),(12,3,1),
	(13,1,3),(13,2,1),(13,3,1), (14,1,3),(14,2,1),(14,3,2), (15,1,2),(15,2,1),(15,3,1);

SET @pren = NOW() - INTERVAL 3 DAY;
INSERT INTO Prenotazione (CodSerata,Recapito, Username, DataPrenotazione) VALUES 
	(NULL,NULL,'Marco88',@pren), (NULL,50693845,NULL,@pren),
	(3,NULL,'Ultras',@pren), (3,50691345,NULL,@pren),
	(NULL,NULL,'Grigio',@pren), (NULL,50615845,NULL,@pren),
	(2,NULL,'Ing',@pren), (1,50611845,NULL,@pren),
	(NULL,NULL,'Gigetto',@pren), (NULL,26693845,NULL,@pren);

INSERT INTO Coperto (CodPrenotazione, CodTavolo, NumeroCoperti) VALUES
	(1,2,3),(2,1,1),(3,5,5),(4,6,8),(5,3,2),
	(6,11,6),(7,18,7),(8,22,2),(9,9,2),(10,23,4);
	
INSERT INTO Pony (Stato,CodSede) VALUES
	('libero', 1),('libero',1),('libero',1),
	('libero', 2),('libero',2),('libero',2),
	('libero', 3),('libero',3),('libero',3),
	('libero', 4),('libero',4),('libero',4),
	('libero', 5),('libero',5),('libero',5);

INSERT INTO Fattura(DataEmissione, Importo) VALUES
	('2015-05-06 23:38:33', 0), ('2015-05-06 23:38:33', 0), ('2015-05-06 23:38:33', 0), 
	('2015-05-06 23:38:33', 0), ('2015-05-06 23:38:33', 0), ('2015-05-06 23:38:33', 0), 
	('2015-05-06 23:38:33', 0), ('2015-05-06 23:38:33', 0), ('2015-05-06 23:38:33', 0), 
	('2015-05-06 23:38:33', 0), ('2015-05-06 23:38:33', 0), ('2015-05-06 23:38:33', 0), 
	('2015-05-06 23:38:33', 0), ('2015-05-06 23:38:33', 0), ('2015-05-06 23:38:33', 0), 
	('2015-05-06 23:38:33', 0), ('2015-05-06 23:38:33', 0);
	
INSERT INTO Comanda(Stato, OraAcquisizione, CodTavolo, CodPrenotazione, CodFattura) VALUES
	('evasa','2015-05-06 20:38:33',2,1,1), ('evasa','2015-05-06 20:50:00',1,2,2),
	('evasa','2015-05-06 21:45:00',5,3,3),('evasa','2015-05-06 22:00:00',5,3,3),
	('evasa','2015-05-06 21:45:00',6,4,4),('evasa','2015-05-06 20:45:00',3,5,5),
	('evasa','2015-05-06 20:45:00',11,6,6),('evasa','2015-05-06 20:45:00',18,7,7),
	('evasa','2015-05-06 22:45:00',22,8,8),('evasa','2015-05-06 23:15:00',22,8,8),
	('evasa','2015-05-06 20:45:00',9,9,9),('evasa','2015-05-06 20:45:00',23,10,10);

INSERT INTO ComandaTakeAway(Stato, OraRitorno, OraAcquisizione, OraConsegna, OraPartenza, CodVeicolo, Username, CodSede,CodFattura) VALUES
	('Consegna','2015-05-06 20:45:00' ,'2015-05-06 19:45:00' ,'2015-05-06 20:40:00','2015-05-06 20:35:00',1,'Marco88',1,11),
	('Consegna','2015-05-06 20:48:00' ,'2015-05-06 19:45:00' ,'2015-05-06 20:42:00','2015-05-06 20:00:00',15,'Gigetto',5,12),
	('Consegna','2015-05-06 20:48:00' ,'2015-05-06 19:45:00' ,'2015-05-06 20:42:00','2015-05-06 20:30:00',10,'Argonauta',4,13),
	('Consegna','2015-05-06 21:48:00' ,'2015-05-06 19:45:00' ,'2015-05-06 20:58:00','2015-05-06 20:28:00',7,'Ultras',3,14),
	('Consegna','2015-05-06 20:45:00' ,'2015-05-06 19:45:00' ,'2015-05-06 20:40:00','2015-05-06 20:35:00',3,'Ing',1,15),
	('Consegna','2015-05-06 20:48:00' ,'2015-05-06 19:45:00' ,'2015-05-06 20:42:00','2015-05-06 20:30:00',12,'Paperino44',4,16),
	('Consegna','2015-05-06 20:48:00' ,'2015-05-06 19:45:00' ,'2015-05-06 20:42:00','2015-05-06 20:30:00',4,'Pippo1022',2,17);

INSERT INTO Ordine(CodRicetta, CodAsporto, CodComanda, Stato) VALUES
	(1,NULL,1,'servizio'), (2,NULL,1,'servizio'),(4,NULL,1,'servizio'),
	(2,NULL,2,'servizio'),(3,NULL,2,'servizio'),(2,NULL,2,'servizio'),
	(3,NULL,3,'servizio'),(2,NULL,3,'servizio'),(3,NULL,3,'servizio'),
	(1,NULL,4,'servizio'),(1,NULL,4,'servizio'),(1,NULL,4,'servizio'),
	(1,NULL,5,'servizio'),(5,NULL,5,'servizio'),(1,NULL,5,'servizio'),
	(5,NULL,6,'servizio'),(4,NULL,6,'servizio'),(4,NULL,6,'servizio'),
	(1,NULL,7,'servizio'),(3,NULL,7,'servizio'),(1,NULL,7,'servizio'),
	(3,NULL,8,'servizio'),(1,NULL,8,'servizio'),(1,NULL,8,'servizio'),
	(4,NULL,9,'servizio'),(2,NULL,9,'servizio'),(3,NULL,9,'servizio'),
	(1,NULL,10,'servizio'),(1,NULL,10,'servizio'),(1,NULL,10,'servizio'),
	(5,NULL,11,'servizio'),(1,NULL,11,'servizio'),(1,NULL,11,'servizio'),
	(1,NULL,12,'servizio'),(3,NULL,12,'servizio'),(5,NULL,12,'servizio'),
	(4,1,NULL,'servizio'),(3,1,NULL,'servizio'),(5,1,NULL,'servizio'),
	(1,2,NULL,'servizio'),(4,2,NULL,'servizio'),(1,2,NULL,'servizio'),
	(5,3,NULL,'servizio'),(1,3,NULL,'servizio'),(5,3,NULL,'servizio'),
	(1,4,NULL,'servizio'),(3,4,NULL,'servizio'),(3,4,NULL,'servizio'),
	(3,5,NULL,'servizio'),(5,5,NULL,'servizio'),(5,5,NULL,'servizio'),
	(1,6,NULL,'servizio'),(3,6,NULL,'servizio'),(2,6,NULL,'servizio'),
	(2,7,NULL,'servizio'),(4,7,NULL,'servizio'),(4,7,NULL,'servizio');

INSERT INTO VariazionePossibile(NomeVariazione, CodFunzione, CodIngrediente, NumeroPassaggio, CodRicetta, Disponibile, Username) VALUES
	('Togli Aglio',NULL,NULL,1,1,0,NULL), ( 'Aggiungi Pomodoro',9,13, 3,2,0,NULL);
    
INSERT INTO Variazione(CodVariazione, CodOrdine) VALUES
	(1,1),(2,2);

INSERT INTO GradimentoProposta(CodProposta, Username, Punteggio) VALUES
	(1,'Argonauta',4);

INSERT INTO  RecensionePiatto(CodRecensione, CodRicetta, Testo, Punteggio) VALUES
	(1,1,'Piatto Discreto',4), (2,4,'Non Male',5);

INSERT INTO ValutazioneRecensione(Punteggio, CodRecensionePiatto,Username) VALUES
	(5,1,'Ing'), (1,2,'Gigetto');


/*----------------------------------------------------------------------------------------------
	
	4	FUNZIONE ALìNALYTICS "RIFORIMENTO MAGAZZINO"
	
-----------------------------------------------------------------------------------------------*/
	
	CREATE TABLE IF NOT EXISTS MV_Rifornimento (
	Ingrediente INT NOT NULL,
	Sede INT NOT NULL,
	Quantita INT NOT NULL,  /*Espressa in gr*/
    DataOrdine DATE,
    DataArrivo DATE,
	FOREIGN KEY(Ingrediente) REFERENCES Ingrediente(CodIngrediente),
	FOREIGN KEY(Sede) REFERENCES Sede(CodSede)
);


SET @intr = 5;
CREATE OR REPLACE VIEW IngredientiRicetta AS
SELECT DISTINCT CodRicetta,CodIngrediente,Dose FROM Passaggio;

CREATE OR REPLACE VIEW OrdinazioniRistoranteRicetta AS
SELECT T.CodSede,O.CodRicetta,COUNT(*) NumeroOrdinazioni FROM Tavolo T
INNER JOIN Comanda C USING(CodTavolo)
INNER JOIN Ordine O USING(CodComanda)
WHERE C.OraAcquisizione > NOW() - INTERVAL 1 YEAR
GROUP BY T.CodSede,O.CodRicetta;

CREATE OR REPLACE VIEW OrdinazioniTakeRicetta AS
SELECT CodSede,CodRicetta,COUNT(*) NumeroOrdinazioni FROM comandaTakeAway
INNER JOIN Ordine O USING(CodAsporto)
GROUP BY CodSede,CodRicetta;

CREATE OR REPLACE VIEW ConsumoIngredientiSedeCoperto AS
SELECT CodIngrediente,CodSede,Dose*NumeroOrdinazioni AS Consumo FROM IngredientiRicetta NATURAL JOIN OrdinazioniRistoranteRicetta
WHERE CodIngrediente != 23
GROUP BY CodIngrediente,CodSede
ORDER BY CodIngrediente,CodSede;

CREATE OR REPLACE VIEW ConsumoIngredientiSedeTake AS
SELECT CodIngrediente,CodSede,Dose*NumeroOrdinazioni AS Consumo FROM IngredientiRicetta NATURAL JOIN OrdinazioniTakeRicetta
WHERE CodIngrediente !=23
GROUP BY CodIngrediente,CodSede
ORDER BY CodIngrediente,CodSede;


CREATE OR REPLACE VIEW PrenotazioniProxSett AS
SELECT CodSede,SUM(NumeroCoperti) AS Persone FROM Coperto INNER JOIN Tavolo USING(CodTavolo)
											   INNER JOIN Prenotazione USING(CodPrenotazione)
WHERE DataPrenotazione BETWEEN CURRENT_DATE() + INTERVAL 1 WEEK AND CURRENT_DATE()
AND DataPrenotazione > CURRENT_DATE()
GROUP BY CodSede;              

CREATE OR REPLACE VIEW PrenotazioniPrecSett AS
SELECT CodSede,SUM(NumeroCoperti) AS Persone FROM Coperto INNER JOIN Tavolo USING(CodTavolo)
											   INNER JOIN Prenotazione USING(CodPrenotazione)
WHERE DataPrenotazione BETWEEN CURRENT_DATE()- INTERVAL 1 WEEK AND CURRENT_DATE() 
GROUP BY CodSede;                                       

CREATE OR REPLACE VIEW SpecchioUtilizzoIngrediente AS
SELECT CodIngrediente,CodSede,IF(Consumo IS NULL,0,Consumo)*(S.Persone+P.Persone) AS Consumo
FROM Ingrediente I LEFT OUTER JOIN ConsumoIngredientiSedeCoperto USING(CodIngrediente)
				   INNER JOIN PrenotazioniProxSett S USING(CodSede)
				   INNER JOIN PrenotazioniPrecSett P USING(CodSede)
UNION ALL
SELECT CodIngrediente,CodSede,IF(Consumo IS NULL,0,Consumo) AS Consumo
FROM Ingrediente I LEFT OUTER JOIN ConsumoIngredientiSedeTake
USING(CodIngrediente);

REPLACE INTO MV_Rifornimento
	SELECT CodIngrediente,CodSede,SUM(Consumo),CURRENT_DATE(),CURRENT_DATE()+INTERVAL @intr DAY
	FROM SpecchioUtilizzoIngrediente 
	WHERE CodSede IS NOT NULL
	GROUP BY CodIngrediente,CodSede
	ORDER BY Consumo DESC;



#--Stored procedure per il refresh della materialized view--#

DROP PROCEDURE IF EXISTS refresh_MV_Rifornimento;
DELIMITER $$
CREATE PROCEDURE refresh_MV_Rifornimento(OUT esito INT)
BEGIN
	DECLARE esito INT DEFAULT 0;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		SET esito = 1;
		SELECT "Errore, impossibile aggiornare la MV_Rifornimento";
	END;

	TRUNCATE TABLE MV_Rifornimento;

	REPLACE INTO MV_Rifornimento
		SELECT CodIngrediente,CodSede,SUM(Consumo),CURRENT_DATE(),CURRENT_DATE()+INTERVAL @intr DAY
		FROM SpecchioUtilizzoIngrediente 
		WHERE CodSede IS NOT NULL
		GROUP BY CodIngrediente,CodSede
		ORDER BY Consumo DESC;
END $$
DELIMITER ;

#--Event per il deferred refresh, schedule every 1 week--#
DROP EVENT IF EXISTS deferred_refresh_Rifornimento;
DELIMITER $$
CREATE EVENT deferred_refresh_Rifornimento
ON SCHEDULE EVERY 1 WEEK
ON COMPLETION PRESERVE
DO
BEGIN
	SET @esito = 0;
	CALL refresh_MV_Rifornimento(@esito);

	IF (@esito = 1) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Errore refresh temporal trigger';
	END IF;

END $$
DELIMITER ;


	
	
	
	
/*----------------------------------------------------------------------------------------------
	
	5	VINCOLI DI INTEGRITA' DATABASE	PARTE 2	
	
-----------------------------------------------------------------------------------------------*/		

DROP TRIGGER IF EXISTS aggiuntaPiattoMenu;
DELIMITER $$
CREATE TRIGGER aggiuntaPiattoMenu
BEFORE INSERT ON Piatto
FOR EACH ROW
BEGIN
	DECLARE consumoPiatto INT;
    DECLARE nuovoPiatto INT;
    DECLARE numeroPrenotazioni INT;
    DECLARE sede INT;
    DECLARE mediaPeriodo DOUBLE;
    DECLARE finito INT DEFAULT 0;
    DECLARE codIngrediente INT;
    DECLARE dose INT;
    DECLARE contenutoMagazzino INT;
    DECLARE prenotazioniSerata INT;
    
    DECLARE cursoreIngredienti CURSOR FOR
    SELECT DISTINCT P.CodIngrediente,P.Dose FROM Ricetta R
    INNER JOIN Passaggio P USING(CodRicetta)
    WHERE P.CodIngrediente != 23
    AND P.CodRicetta = NEW.CodRicetta;
    
	DECLARE CONTINUE HANDLER FOR NOT FOUND
		SET finito = 1;
    
    CREATE TEMPORARY TABLE IF NOT EXISTS prenotazioniPeriodo (
		Anno INT,
        Mese INT,
        Numero INT
	);
    
	SELECT CodSede INTO sede FROM Menu WHERE CodMenu = NEW.CodMenu;

    REPLACE INTO prenotazioniPeriodo
    SELECT YEAR(DataPrenotazione) AS Anno,MONTH(DataPrenotazione) AS Mese,COUNT(*) AS Numero FROM Prenotazione
	INNER JOIN Coperto C USING(CodPrenotazione)
	INNER JOIN Tavolo T USING(CodTavolo)
	WHERE T.CodSede = sede
    AND MONTH(DataPrenotazione) BETWEEN MONTH(CURRENT_DATE)-1 AND MONTH(CURRENT_DATE)+1
	GROUP BY Anno,Mese;
    
    SELECT COUNT(*) INTO prenotazioniSerata FROM Prenotazione
    INNER JOIN Coperto C USING(CodPrenotazione)
    INNER JOIN Tavolo T USING(CodTavolo)
    WHERE T.CodSede = sede
    AND DataPrenotazione > CURRENT_DATE AND CURRENT_DATE;
    
    SELECT AVG(Numero) INTO mediaPeriodo FROM PrenotazioniPeriodo;
    
    SELECT COUNT(*) INTO nuovoPiatto FROM Menu 
    WHERE CodMenu = NEW.CodMenu
    AND DataInizio BETWEEN CURRENT_DATE - INTERVAL 2 DAY AND CURRENT_DATE + INTERVAL 2 DAY;
    
    SELECT ( SELECT COUNT(*) FROM Ordine O
		 INNER JOIN Comanda USING(CodComanda)
		 INNER JOIN Tavolo T USING(CodTavolo)
		 WHERE T.CodSede = sede
		 AND O.CodRicetta = NEW.codRicetta)
		+
        (SELECT COUNT(*) FROM Ordine O
		 INNER JOIN ComandaTakeAway CT USING(CodAsporto)
		 WHERE CT.CodSede = sede
		 AND O.CodRicetta = NEW.codRicetta) INTO consumoPiatto;
         
	OPEN cursoreIngredienti;
        
    scan: LOOP
		FETCH cursoreIngredienti INTO codIngrediente,dose;
                
        IF(finito = 1) THEN LEAVE scan;
        END IF;
        
        
        SELECT IF(SUM(C.Peso) IS NULL,0,SUM(C.Peso)) + IF(MV.Quantita IS NULL,0,MV.Quantita) INTO contenutoMagazzino FROM Confezione C
        INNER JOIN Magazzino M USING(CodMagazzino)
        INNER JOIN mv_rifornimento MV USING(CodIngrediente)
        WHERE M.CodSede = sede
        AND MV.Sede = sede
        AND DATEDIFF(MV.DataArrivo,CURRENT_DATE()) <= 3  /*ARRIVO IMMINENTE DELL'INGREDIENTE IN MAGAZZINO*/
        AND C.CodIngrediente = codIngrediente;
                
        IF(	dose*(consumoPiatto+prenotazioniSerata +1 ) + dose * (consumoPiatto+prenotazioniSerata+1) * 1/3 * mediaPeriodo * nuovoPiatto >= contenutoMagazzino) THEN
			SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = "Quantità ingredienti non sufficiente all'inserimento del piatto";
		END IF;
		
	END LOOP scan;
END $$
DELIMITER ;

/*----------------------------------------------------------------------------------------------
	
	6	FUNZIONE ANALYTICS "MAGAZZINO INTELLIGENTE"	
	
-----------------------------------------------------------------------------------------------*/	

DROP PROCEDURE IF EXISTS MagazzinoIntelligente;
DROP FUNCTION IF EXISTS Punteggio;
DELIMITER $$
CREATE FUNCTION Punteggio (Ricetta INT(11), Sede INT(11))
RETURNS DOUBLE NOT DETERMINISTIC
BEGIN

	DECLARE Finito INT DEFAULT 0;
    DECLARE Ingrediente INT;
    DECLARE GiorniScadenza INT;
    DECLARE ConfezioniPresenti INT;
    DECLARE Punteggio DOUBLE DEFAULT 0;
    DECLARE MediaRecensioni DOUBLE;
    DECLARE ConfezioniAperte INT;
    DECLARE ScorriIngredienti CURSOR FOR
		(	SELECT DISTINCT(C.CodIngrediente), DATEDIFF(C.Scadenza, CURRENT_DATE) AS GiorniAllaScadenza
			FROM Confezione C INNER JOIN Magazzino M USING(CodMagazzino)
				INNER JOIN Passaggio P USING(CodIngrediente)
			WHERE C.Scadenza = ( 	SELECT MIN(C1.Scadenza)
									FROM Confezione C1 INNER JOIN Magazzino M1 USING (CodMagazzino)
									WHERE C.CodIngrediente = C1.CodIngrediente
										AND M1.CodSede=Sede)
			AND M.CodSede = Sede
			AND P.CodRicetta = Ricetta);
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET Finito = 1;
    
    OPEN ScorriIngredienti;
    scan: LOOP
		FETCH ScorriIngredienti INTO Ingrediente, GiorniScadenza;
    
		IF Finito = 1 THEN
			LEAVE scan;
		END IF;
        
        /* verifico se non ci sono confezioni relative all'ingrediente, 
        in tal caso sarebbe impossibile preparare la ricetta */
        SELECT COUNT(*) INTO ConfezioniPresenti
		FROM Confezione C INNER JOIN Magazzino M USING(CodMagazzino)
        WHERE C.CodIngrediente = Ingrediente	
			AND M.CodSede = Sede;
            
		IF ConfezioniPresenti = 0 THEN
			SET Punteggio = -1;
            LEAVE scan;
		END IF;
        
        /* conto le confezioni aperte */        
        SELECT COUNT(*) INTO ConfezioniAperte
        FROM Confezione C INNER JOIN Magazzino M USING(CodMagazzino)
        WHERE M.CodSede = Sede
			AND C.CodIngrediente = Ingrediente
            AND C.Stato = 'parziale';
            
		/* effettuo  1+scatole aperte / giorni  alla scadenza 
		e la sommo al punteggio ottenuto dagli altri ingredienti */
       SET Punteggio = Punteggio + ((1 + ConfezioniAperte) / GiorniScadenza);
	END LOOP scan;
	CLOSE ScorriIngredienti;
    
	IF Punteggio > -1 THEN
		/* recupero il punteggio medio delle recensioni*/
		SELECT SommaRecensioni / NumeroRecensioni INTO MediaRecensioni
		FROM Ricetta 
		WHERE CodRicetta = Ricetta;    
		
		/* se non esistono recensioni viene assegnato un punteggio pari alla media delle 
			recensioni sugli altri piatti per non penalizzare il piatto con un punteggio nullo */
		IF MediaRecensioni IS NULL THEN 
			SELECT AVG(SommaRecensioni / NumeroRecensioni) INTO MediaRecensioni
			FROM Ricetta;
		END IF;
		/* calcolo il punteggio finale pesando i punti delle recensione */
		SET Punteggio = (0.8 * Punteggio) + (0.2 * MediaRecensioni);
	END IF;
    
    RETURN Punteggio; /* se il valore di ritorno =-1, la ricetta non viene proposta */
END; $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE MagazzinoIntelligente (IN Sede INT, INOUT Stringa VARCHAR(255))
BEGIN
	DECLARE Finito INT DEFAULT 0;
    DECLARE Ricetta INT;
    DECLARE NomeRic VARCHAR(255) DEFAULT "";
    DECLARE PuntiRicetta DOUBLE;
	DECLARE ScorriRicette CURSOR FOR (	SELECT CodRicetta
										FROM Ricetta);
	DECLARE Stampa CURSOR FOR ( SELECT NomeRicetta
								FROM PunteggioRicetta INNER JOIN Ricetta USING(CodRicetta)
                                ORDER BY PunteggioR DESC 
                                LIMIT 10);
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET Finito = 1;
    
    /* creo la tabella dove salvare le ricette con i pnteggi */
	CREATE TEMPORARY TABLE IF NOT EXISTS PunteggioRicetta(
		CodRicetta INT(11) PRIMARY KEY,
		PunteggioR DOUBLE
	)ENGINE = InnoDB DEFAULT CHARSET = UTF8;
	TRUNCATE PunteggioRicetta;
    
    OPEN ScorriRicette;
    scan: LOOP
		FETCH ScorriRicette INTO Ricetta;        
		IF Finito = 1 THEN
			LEAVE scan;
		END IF;
        
        SET PuntiRicetta = Punteggio(Ricetta, Sede);
		IF PuntiRicetta > -1 THEN
			INSERT INTO PunteggioRicetta VALUES (Ricetta, PuntiRicetta);
		END IF;
        
	END LOOP scan;
    CLOSE ScorriRicette;
    SET Finito = 0;
    
    OPEN Stampa;
    scan2: LOOP
		FETCH Stampa INTO NomeRic;
        
		IF Finito = 1 THEN
			LEAVE scan2;
		END IF;
        
       SET Stringa = CONCAT(Stringa,NomeRic,";");
       
	END LOOP scan2;
	CLOSE Stampa;
 
    DROP TEMPORARY TABLE PunteggioRicetta;
END; $$
DELIMITER ;


/*----------------------------------------------------------------------------------------------
	
	7	FUNZIONE ANALYTICS "QUALITA' DEL TAKE AWAY"
	
-----------------------------------------------------------------------------------------------*/	

/*  
	Viene realizzata una materializad-view aggiornata con cadenza mensile che contiene:
	codiceVeicolo, codiceAsporto, ritardoConsegna, ritardoRienteo.
	Gli ultimi due sono clcolati dai tempi medi globali  mensili, vengono inoltre proiettati solo quelli che hanno un ritardo
	maggiore del 20% rispetto ai rispettivi tempi
*/

CREATE TABLE IF NOT EXISTS mv_QualitaTakeAway (
	CodAsporto INT(11) PRIMARY KEY,
	Pony INT(11) NOT NULL,
    RitardoConsegna INT(11) NOT NULL,
    RitardoRientro INT(11) NOT NULL,
    FOREIGN KEY (CodAsporto) REFERENCES ComandaTakeAway(CodAsporto)
		ON DELETE CASCADE 
        ON UPDATE CASCADE,
	FOREIGN KEY (Pony) REFERENCES Pony(CodVeicolo)
		ON DELETE CASCADE
        ON UPDATE CASCADE
)ENGINE=innoDB DEFAULT CHARSET= UTF8;

DROP EVENT IF EXISTS QualitaTakeAway;

DELIMITER $$
CREATE EVENT QualitaTakeAway 
ON SCHEDULE EVERY 1 MONTH ON COMPLETION PRESERVE
DO
BEGIN 
	DECLARE MediaConsegne INT DEFAULT 0;
    DECLARE MediaRientri INT DEFAULT 0;
    DECLARE Finito INT DEFAULT 0;
    /* i limiti servono per definire i margini da non superare per essere segnalati */
    DECLARE	LimiteConsegne INT DEFAULT 0;
    DECLARE LimiteRientri INT DEFAULT 0;
    DECLARE Pony INT;
    DECLARE Partenza DATETIME;
    DECLARE Consegna DATETIME;
    DECLARE Rientro DATETIME;
    DECLARE Asporto INT;
    DECLARE ConsegnaAttuale INT;
    DECLARE RientroAttuale INT;
    DECLARE Inserimento CURSOR FOR (SELECT CodAsporto, CodVeicolo, oraPartenza, oraConsegna, oraRitorno
									FROM ComandaTakeAway INNER JOIN Pony USING (CodVeicolo)
                                    WHERE OraAcquisizione BETWEEN CURRENT_DATE - INTERVAL 1 MONTH AND CURRENT_DATE - INTERVAL 1 DAY);
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET Finito = 1;
    
    /* calcolo la media dei tempi per il mese in oggetto */    
    SELECT AVG(D.TempiConsegne) INTO MediaConsegne
	FROM (	SELECT TIMESTAMPDIFF(MINUTE, oraPartenza, oraConsegna) AS TempiConsegne
			FROM ComandaTakeAway INNER JOIN Pony USING (CodVeicolo)
			WHERE OraAcquisizione BETWEEN CURRENT_DATE - INTERVAL 1 MONTH AND CURRENT_DATE - INTERVAL 1 DAY) AS D;
                        
    SELECT AVG(D.TempiRientri) INTO MediaRientri
	FROM (	SELECT TIMESTAMPDIFF(MINUTE, oraConsegna, oraRitorno) AS TempiRientri
			FROM ComandaTakeAway INNER JOIN Pony USING(CodVeicolo)
			WHERE OraAcquisizione BETWEEN CURRENT_DATE - INTERVAL 1 MONTH AND CURRENT_DATE - INTERVAL 1 DAY) AS D;
	
    /* pongo i margini per la segnalazione */
    SET LimiteConsegne = MediaConsegne * 1.2;
    SET LimiteRientri = MediaRientri * 1.2;
    
    OPEN Inserimento;
    scan: LOOP
		FETCH Inserimento INTO Asporto, Pony, Partenza, Consegna, Rientro;
        IF Finito = 1 THEN
			LEAVE scan;
		END IF;
        SET ConsegnaAttuale = TIMESTAMPDIFF(MINUTE, Partenza, Consegna);
        SET RientroAttuale = TIMESTAMPDIFF(MINUTE, Consegna, Rientro);
        
        /* verifco se effettuare la segnalazione */
        IF ConsegnaAttuale >= LimiteConsegne OR RientroAttuale >= LimiteRientri THEN
			/* preparo i ritardi da inserire nella tabella */
			SET ConsegnaAttuale = ConsegnaAttuale - MediaConsegne;
			SET RientroAttuale = RientroAttuale - MediaRientri;
			INSERT INTO _QualitaTakeAway VALUES (Asporto, Pony, ConsegnaAttuale, RientroAttuale);
        END IF;
        
	END LOOP scan;
    CLOSE Inserimento;               
END; $$
DELIMITER ;

SET GLOBAL event_scheduler = ON;

/* POPOLAMENTO TABELLA CON VECCHI RECORD */

DROP PROCEDURE IF EXISTS InizializzazioneQualita;

DELIMITER $$
CREATE PROCEDURE InizializzazioneQualita()
BEGIN 
	DECLARE MediaConsegne INT DEFAULT 0;
    DECLARE MediaRientri INT DEFAULT 0;
    DECLARE Finito INT DEFAULT 0;
    /* i limiti servono per definire i margini da non superare per essere segnalati */
    DECLARE	LimiteConsegne INT DEFAULT 0;
    DECLARE LimiteRientri INT DEFAULT 0;
    DECLARE Pony INT;
    DECLARE Partenza DATETIME;
    DECLARE Consegna DATETIME;
    DECLARE Rientro DATETIME;
    DECLARE Asporto INT;
    DECLARE ConsegnaAttuale INT;
    DECLARE RientroAttuale INT;
    DECLARE Inserimento CURSOR FOR (SELECT CodAsporto, CodVeicolo, oraPartenza, oraConsegna, oraRitorno
									FROM ComandaTakeAway INNER JOIN Pony USING (CodVeicolo)
                                    WHERE OraAcquisizione BETWEEN CURRENT_DATE - INTERVAL 12 MONTH AND CURRENT_DATE - INTERVAL 1 DAY);
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET Finito = 1;
    
    /* calcolo la media dei tempi per il mese in oggetto */    
    SELECT AVG(D.TempiConsegne) INTO MediaConsegne
	FROM (	SELECT TIMESTAMPDIFF(MINUTE, oraPartenza, oraConsegna) AS TempiConsegne
			FROM ComandaTakeAway INNER JOIN Pony USING (CodVeicolo)
			WHERE OraAcquisizione BETWEEN CURRENT_DATE - INTERVAL 12 MONTH AND CURRENT_DATE - INTERVAL 1 DAY) AS D;
                        
    SELECT AVG(D.TempiRientri) INTO MediaRientri
	FROM (	SELECT TIMESTAMPDIFF(MINUTE, oraConsegna, oraRitorno) AS TempiRientri
			FROM ComandaTakeAway INNER JOIN Pony USING(CodVeicolo)
			WHERE OraAcquisizione BETWEEN CURRENT_DATE - INTERVAL 12 MONTH AND CURRENT_DATE - INTERVAL 1 DAY) AS D;
	
    /* pongo i margini per la segnalazione */
    SET LimiteConsegne = MediaConsegne * 1.2;
    SET LimiteRientri = MediaRientri * 1.2;
    
    OPEN Inserimento;
    scan: LOOP
		FETCH Inserimento INTO Asporto, Pony, Partenza, Consegna, Rientro;
        IF Finito = 1 THEN
			LEAVE scan;
		END IF;
        SET ConsegnaAttuale = TIMESTAMPDIFF(MINUTE, Partenza, Consegna);
        SET RientroAttuale = TIMESTAMPDIFF(MINUTE, Consegna, Rientro);
        
        /* verifco se effettuare la segnalazione */
        IF ConsegnaAttuale >= LimiteConsegne OR RientroAttuale >= LimiteRientri THEN
			/* preparo i ritardi da inserire nella tabella */
			SET ConsegnaAttuale = ConsegnaAttuale - MediaConsegne;
			SET RientroAttuale = RientroAttuale - MediaRientri;
			INSERT INTO mv_QualitaTakeAway VALUES (Asporto, Pony, ConsegnaAttuale, RientroAttuale);
        END IF;        
	END LOOP scan;
    CLOSE Inserimento;      
                                     
END; $$
DELIMITER ;

CALL InizializzazioneQualita;
CALL refresh_mv_Rifornimento(@oxi);