--------------------------------------------------------
--  File creato - mercoledì-gennaio-25-2017
--------------------------------------------------------
--------------------------------------------------------
--  DDL for View ASSIST_INDIVIDUALI
--------------------------------------------------------

  CREATE OR REPLACE  VIEW "ASSIST_INDIVIDUALI" ("IDGIOCATORE", "NOME", "COGNOME", "ASSIST") AS
  SELECT G.IDgiocatore, G.Nome, G.Cognome, COUNT(E.IDevento)
	FROM GIOCATORE G JOIN EVENTI E ON G.IDgiocatore = E.IDgiocatore
	WHERE E.Evento = 'Assist'
GROUP BY  G.IDgiocatore, G.Nome, G.Cognome;
--------------------------------------------------------
--  DDL for View ASSIST_PARTITA
--------------------------------------------------------

  CREATE OR REPLACE  VIEW "ASSIST_PARTITA" ("IDGIOCATORE", "IDPARTITA", "NOME", "COGNOME", "SQUADRA", "ASSIST") AS
  SELECT SI.IDgiocatore, E.IDPARTITA, SI.Nome, SI.Cognome, SI.SQUADRA,COUNT(E.IDevento)
	FROM STAT_INDIVIDUALI SI JOIN EVENTI E ON SI.IDGIOCATORE = E.IDGIOCATORE
	WHERE E.Evento = 'Assist'
GROUP BY  SI.IDgiocatore, E.IDPARTITA, SI.Nome, SI.Cognome, SI.SQUADRA;
--------------------------------------------------------
--  DDL for View CARDG_INDIVIDUALI
--------------------------------------------------------

  CREATE OR REPLACE  VIEW "CARDG_INDIVIDUALI" ("IDGIOCATORE", "NOME", "COGNOME", "AMMONIZIONI") AS
  SELECT G.IDgiocatore, G.Nome, G.Cognome, COUNT(E.IDevento)
	FROM GIOCATORE G JOIN EVENTI E ON G.IDgiocatore = E.IDgiocatore
	WHERE E.Evento = 'CartellinoG'
GROUP BY  G.IDgiocatore, G.Nome, G.Cognome;
--------------------------------------------------------
--  DDL for View CARDR_INDIVIDUALI
--------------------------------------------------------

  CREATE OR REPLACE  VIEW "CARDR_INDIVIDUALI" ("IDGIOCATORE", "NOME", "COGNOME", "ESPULSIONI") AS
  SELECT G.IDgiocatore, G.Nome, G.Cognome, COUNT(E.IDevento)
	FROM GIOCATORE G JOIN EVENTI E ON G.IDgiocatore = E.IDgiocatore
	WHERE E.Evento = 'CartellinoR'
GROUP BY  G.IDgiocatore, G.Nome, G.Cognome;
--------------------------------------------------------
--  DDL for View FALLI_INDIVIDUALI
--------------------------------------------------------

  CREATE OR REPLACE  VIEW "FALLI_INDIVIDUALI" ("IDGIOCATORE", "NOME", "COGNOME", "FALLO") AS
  SELECT G.IDgiocatore, G.Nome, G.Cognome, COUNT(E.IDevento)
	FROM GIOCATORE G JOIN EVENTI E ON G.IDgiocatore = E.IDgiocatore
	WHERE E.Evento = 'Fallo'
GROUP BY  G.IDgiocatore, G.Nome, G.Cognome;
--------------------------------------------------------
--  DDL for View FUORIGIOCO_INDIVIDUALI
--------------------------------------------------------

  CREATE OR REPLACE  VIEW "FUORIGIOCO_INDIVIDUALI" ("IDGIOCATORE", "NOME", "COGNOME", "FUORIGIOCO") AS
  SELECT G.IDgiocatore, G.Nome, G.Cognome, COUNT(E.IDevento)
	FROM GIOCATORE G JOIN EVENTI E ON G.IDgiocatore = E.IDgiocatore
	WHERE E.Evento = 'Fuorigioco'
GROUP BY  G.IDgiocatore, G.Nome, G.Cognome;
--------------------------------------------------------
--  DDL for View GOAL_INDIVIDUALI
--------------------------------------------------------

  CREATE OR REPLACE  VIEW "GOAL_INDIVIDUALI" ("IDGIOCATORE", "NOME", "COGNOME", "GOAL") AS
  SELECT G.IDgiocatore, G.Nome, G.Cognome, COUNT(E.IDevento)
	FROM GIOCATORE G JOIN EVENTI E ON G.IDGIOCATORE = E.IDGIOCATORE
	WHERE E.Evento = 'Goal'
GROUP BY  G.IDgiocatore, G.Nome, G.Cognome;
--------------------------------------------------------
--  DDL for View GOAL_PARTITA
--------------------------------------------------------

  CREATE OR REPLACE  VIEW "GOAL_PARTITA" ("IDGIOCATORE", "IDPARTITA", "NOME", "COGNOME", "SQUADRA", "GOAL") AS
  SELECT SI.IDgiocatore, E.IDPARTITA, SI.Nome, SI.Cognome, SI.SQUADRA,COUNT(E.IDevento)
	FROM STAT_INDIVIDUALI SI JOIN EVENTI E ON SI.IDGIOCATORE = E.IDGIOCATORE
	WHERE E.Evento = 'Goal'
GROUP BY  SI.IDgiocatore, E.IDPARTITA, SI.Nome, SI.Cognome, SI.SQUADRA;
--------------------------------------------------------
--  DDL for View GOAL_SQUADRA_PARTITA
--------------------------------------------------------

  CREATE OR REPLACE  VIEW "GOAL_SQUADRA_PARTITA" ("IDSQUADRA", "SQUADRA", "IDPARTITA", "GOAL") AS
  SELECT STAT_INDIVIDUALI.IDSQUADRA, SQUADRA.NOME, GOAL_PARTITA.IDPARTITA, SUM (GOAL_PARTITA.GOAL)
FROM GOAL_PARTITA, STAT_INDIVIDUALI, SQUADRA
WHERE GOAL_PARTITA.IDGIOCATORE=STAT_INDIVIDUALI.IDGIOCATORE AND SQUADRA.IDSQUADRA=STAT_INDIVIDUALI.IDSQUADRA
GROUP BY STAT_INDIVIDUALI.IDSQUADRA, SQUADRA.NOME, IDPARTITA;
--------------------------------------------------------
--  DDL for View STAT_INDIVIDUALI
--------------------------------------------------------

  CREATE OR REPLACE  VIEW "STAT_INDIVIDUALI" ("IDGIOCATORE", "RUOLO", "NOME", "COGNOME", "IDSQUADRA", "SQUADRA", "GOAL", "TIRI", "FALLI", "AMMONIZIONI", "ESPULSIONI", "FUORIGIOCO", "ASSIST", "TIRIINPORTA") AS
  SELECT GIO.IDgiocatore, GIO.RUOLO, GIO.Nome, GIO.Cognome, SQ.IDSQUADRA, SQ.Nome, COALESCE(G.Goal,0), COALESCE(T.Tiri,0), COALESCE(F.Fallo,0), COALESCE(CG.Ammonizioni,0), COALESCE(CR.Espulsioni,0), COALESCE(FG.Fuorigioco,0), COALESCE(AI.Assist,0), COALESCE(TI.TiroInPorta,0)
	FROM ((((((((GIOCATORE GIO LEFT OUTER JOIN GOAL_INDIVIDUALI G ON GIO.IDgiocatore = G.IDgiocatore) LEFT OUTER JOIN TIRI_INDIVIDUALI T ON GIO.IDgiocatore = T.IDgiocatore) LEFT OUTER JOIN FALLI_INDIVIDUALI F ON GIO.IDgiocatore = F.IDgiocatore) LEFT OUTER JOIN CARDG_INDIVIDUALI CG ON GIO.IDgiocatore = CG.IDgiocatore) LEFT OUTER JOIN CARDR_INDIVIDUALI CR ON GIO.IDgiocatore = CR.IDgiocatore) LEFT OUTER JOIN FUORIGIOCO_INDIVIDUALI FG ON GIO.IDgiocatore = FG.IDgiocatore) LEFT JOIN ASSIST_INDIVIDUALI  AI ON GIO.IDgiocatore = AI.IDgiocatore) LEFT OUTER JOIN TIP_INDIVIDUALI TI ON GIO.IDgiocatore = TI.IDgiocatore) JOIN (SQUADRA SQ JOIN SQUADRA_GIOCATORI SQG ON SQ.IDsquadra = SQG.IDsquadra) ON GIO.IDgiocatore = SQG.IDgiocatore;
--------------------------------------------------------
--  DDL for View TIP_INDIVIDUALI
--------------------------------------------------------

  CREATE OR REPLACE  VIEW "TIP_INDIVIDUALI" ("IDGIOCATORE", "NOME", "COGNOME", "TIROINPORTA") AS
  SELECT G.IDgiocatore, G.Nome, G.Cognome, COUNT(E.IDevento)
	FROM GIOCATORE G JOIN EVENTI E ON G.IDgiocatore = E.IDgiocatore
	WHERE E.Evento = 'TiroInPorta'
GROUP BY  G.IDgiocatore, G.Nome, G.Cognome;
--------------------------------------------------------
--  DDL for View TIRI_INDIVIDUALI
--------------------------------------------------------

  CREATE OR REPLACE  VIEW "TIRI_INDIVIDUALI" ("IDGIOCATORE", "NOME", "COGNOME", "TIRI") AS
  SELECT G.IDgiocatore, G.Nome, G.Cognome, COUNT(E.IDevento)
	FROM GIOCATORE G JOIN EVENTI E ON G.IDgiocatore = E.IDgiocatore
	WHERE E.Evento = 'Tiri'
GROUP BY  G.IDgiocatore, G.Nome, G.Cognome;
--------------------------------------------------------
--  DDL for View VISTA_ASSIST
--------------------------------------------------------

  CREATE OR REPLACE  VIEW "VISTA_ASSIST" ("IDTORNEO", "GIOCATORE", "SQUADRA", "ASSIST") AS
  SELECT P.IDTORNEOG, AP.COGNOME, AP.SQUADRA, SUM(AP.ASSIST)
FROM (ASSIST_PARTITA AP INNER JOIN PARTITA P ON P.IDPARTITA = AP.IDPARTITA)
GROUP BY P.IDTORNEOG, AP.COGNOME, AP.SQUADRA;
--------------------------------------------------------
--  DDL for View VISTA_EVENTI
--------------------------------------------------------

  CREATE OR REPLACE  VIEW "VISTA_EVENTI" ("IDEVENTO", "IDGIOCATORE", "IDPARTITA", "MINUTO", "SQUADRA", "EVENTO", "GIOCATORE") AS
  SELECT EVENTI.IDEVENTO, STAT_INDIVIDUALI.IDGIOCATORE, EVENTI.IDPARTITA, EVENTI.MINUTO, STAT_INDIVIDUALI.SQUADRA, EVENTI.EVENTO, STAT_INDIVIDUALI.COGNOME
FROM (EVENTI INNER JOIN PARTITA ON EVENTI.IDPARTITA = PARTITA.IDPARTITA) INNER JOIN STAT_INDIVIDUALI ON EVENTI.IDGIOCATORE = STAT_INDIVIDUALI.IDGIOCATORE
ORDER BY EVENTI.MINUTO DESC;
--------------------------------------------------------
--  DDL for View VISTA_MARCATORI
--------------------------------------------------------

  CREATE OR REPLACE  VIEW "VISTA_MARCATORI" ("IDTORNEO", "GIOCATORE", "SQUADRA", "GOAL") AS
  SELECT P.IDTORNEOG, GP.COGNOME, GP.SQUADRA, SUM(GP.GOAL)
FROM (GOAL_PARTITA GP INNER JOIN PARTITA P ON P.IDPARTITA = GP.IDPARTITA) --LEFT JOIN ASSIST_PARTITA AP ON  )
GROUP BY P.IDTORNEOG, GP.COGNOME, GP.SQUADRA;
--------------------------------------------------------
--  DDL for View VISTA_RIS_PARTITE
--------------------------------------------------------

  CREATE OR REPLACE  VIEW "VISTA_RIS_PARTITE" ("IDPARTITA", "IDSQ1", "SQUADRA1", "GOL1", "GOL2", "SQUADRA2", "IDSQ2", "IDTORNEOG", "IDTORNEOE", "NUMERO_TURNO") AS
  SELECT PAR.IDPARTITA, PAR.IDSQ1, ST.SQUADRA, COALESCE(G1.GOAL,0) AS GOL1, COALESCE(G2.GOAL,0) AS GOL2, STAT.SQUADRA, PAR.IDSQ2, PG.IDTORNEOG, PE.IDTORNEOE, PA.NUMERO_TURNO_TORNEO
  FROM ((((((PARTITA PAR INNER JOIN STAT_INDIVIDUALI ST ON PAR.IDSQ1=ST.IDSQUADRA) INNER JOIN STAT_INDIVIDUALI STAT ON PAR.IDSQ2=STAT.IDSQUADRA)
    LEFT OUTER JOIN GOAL_SQUADRA_PARTITA G1 ON PAR.IDSQ1=G1.IDSQUADRA AND PAR.IDPARTITA=G1.IDPARTITA)
    LEFT OUTER JOIN GOAL_SQUADRA_PARTITA G2 ON PAR.IDSQ2=G2.IDSQUADRA AND PAR.IDPARTITA=G2.IDPARTITA)
    LEFT OUTER JOIN (PARTECIPANTI_GIRONI PG INNER JOIN PARTITA P ON P.IDTORNEOG = PG.IDTORNEOG) ON P.IDPARTITA = PAR.IDPARTITA)
    LEFT OUTER JOIN (PARTECIPANTI_ELIMINAZIONE PE INNER JOIN PARTITA P ON P.IDTORNEOE = PE.IDTORNEOE) ON P.IDPARTITA = PAR.IDPARTITA)
    LEFT OUTER JOIN (PARTITA PA INNER JOIN GOAL_SQUADRA_PARTITA G3 ON PA.IDPARTITA = G3.IDPARTITA) ON PA.IDPARTITA = PAR.IDPARTITA
GROUP BY PAR.IDPARTITA, PAR.IDSQ1,ST.SQUADRA,G1.GOAL, G2.GOAL, STAT.SQUADRA, PAR.IDSQ2, PG.IDTORNEOG, PE.IDTORNEOE, PA.NUMERO_TURNO_TORNEO;
--------------------------------------------------------
--  DDL for View VISTA_STAFF
--------------------------------------------------------

  CREATE OR REPLACE  VIEW "VISTA_STAFF" ("NOME", "COGNOME", "IDSTAFF", "NAZIONALITA", "DATANASCITA", "SQUADRA", "PROFESSIONE") AS
  SELECT ST.Nome, ST.Cognome, ST.IDstaff, ST.LuogoNascita, ST.DataNascita, SQ.Nome, ST.Professione
	FROM STAFF ST JOIN SQUADRA SQ ON ST.IDSQUADRA = SQ.IDSQUADRA;

--------------------------------------------------------
--  DDL for Table EVENTI
--------------------------------------------------------

  CREATE TABLE "EVENTI"
   (	"IDEVENTO" NUMBER(*,0),
	"IDPARTITA" NUMBER(*,0),
	"IDGIOCATORE" NUMBER(*,0),
	"MINUTO" FLOAT(126),
	"EVENTO" VARCHAR2(20 BYTE)
  );
--------------------------------------------------------
--  DDL for Table GIOCATORE
--------------------------------------------------------

  CREATE TABLE "GIOCATORE"
   (	"IDGIOCATORE" NUMBER(*,0),
	"NOME" VARCHAR2(30 BYTE),
	"COGNOME" VARCHAR2(30 BYTE),
	"RUOLO" VARCHAR2(20 BYTE)
   )
--------------------------------------------------------
--  DDL for Table INCONTRI
--------------------------------------------------------

  CREATE TABLE "INCONTRI"
   (	"IDPARTITA" NUMBER(*,0),
	"IDSQUADRA" NUMBER(*,0)
   );
--------------------------------------------------------
--  DDL for Table PARTECIPANTI_ELIMINAZIONE
--------------------------------------------------------

  CREATE TABLE "PARTECIPANTI_ELIMINAZIONE"
   (	"IDTORNEOE" NUMBER(*,0),
	"IDSQUADRA" NUMBER(*,0)
   );
--------------------------------------------------------
--  DDL for Table PARTECIPANTI_GIRONI
--------------------------------------------------------

  CREATE TABLE "PARTECIPANTI_GIRONI"
   (	"IDTORNEOG" NUMBER(*,0),
	"IDSQUADRA" NUMBER(*,0)
   );
--------------------------------------------------------
--  DDL for Table PARTITA
--------------------------------------------------------

  CREATE TABLE "PARTITA"
   (	"IDPARTITA" NUMBER(*,0),
	"IDTORNEOG" NUMBER(*,0),
	"IDTORNEOE" NUMBER(*,0),
	"IDSQ1" NUMBER(*,0),
	"IDSQ2" NUMBER(*,0),
	"NUMERO_TURNO_TORNEO" NUMBER(*,0),
	"STADIO" VARCHAR2(30 BYTE),
	"DATA" DATE
   );
--------------------------------------------------------
--  DDL for Table SQUADRA
--------------------------------------------------------

  CREATE TABLE "SQUADRA"
   (	"IDSQUADRA" NUMBER(*,0),
	"NOME" VARCHAR2(30 BYTE),
	"TIPO" VARCHAR2(10 BYTE)
   );
--------------------------------------------------------
--  DDL for Table SQUADRA_GIOCATORI
--------------------------------------------------------

  CREATE TABLE "SQUADRA_GIOCATORI"
   (	"IDSQUADRA" NUMBER(*,0),
	"IDGIOCATORE" NUMBER(*,0)
   );
--------------------------------------------------------
--  DDL for Table STAFF
--------------------------------------------------------

  CREATE TABLE "STAFF"
   (	"IDSTAFF" NUMBER(*,0),
	"IDSQUADRA" NUMBER(*,0),
	"NOME" VARCHAR2(30 BYTE),
	"COGNOME" VARCHAR2(30 BYTE),
	"LUOGONASCITA" VARCHAR2(30 BYTE),
	"DATANASCITA" DATE,
	"PROFESSIONE" VARCHAR2(30 BYTE)
   );
--------------------------------------------------------
--  DDL for Table TORNEO_ELIMINAZIONE
--------------------------------------------------------

  CREATE TABLE "TORNEO_ELIMINAZIONE"
   (	"IDTORNEOE" NUMBER(*,0),
	"STAGIONEE" CHAR(9 BYTE),
	"NOMETORNEOE" VARCHAR2(30 BYTE)
  );
--------------------------------------------------------
--  DDL for Table TORNEO_GIRONI
--------------------------------------------------------

  CREATE TABLE "TORNEO_GIRONI"
   (	"IDTORNEOG" NUMBER(*,0),
	"STAGIONEG" CHAR(9 BYTE),
	"NOMETORNEOG" VARCHAR2(30 BYTE)
   )

Insert into EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('2','1','7','24','Goal');
Insert into EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('3','1','21','24','Assist');
Insert into EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('1','1','14','2','Goal');
Insert into EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('4','1','2','68','Assist');
Insert into EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('5','1','20','68','Goal');
Insert into EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('6','2','41','13','Assist');
Insert into EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('7','2','62','13','Goal');
Insert into EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('8','2','48','26','Goal');
Insert into EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('9','2','21','57','Goal');
Insert into EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('10','2','21','60','Assist');
Insert into EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('11','2','11','60','Goal');
Insert into EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('12','2','8','80','Assist');
Insert into EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('13','2','21','80','Goal');
Insert into EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('14','3','130','12','Goal');
Insert into EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('15','3','118','38','Goal');
Insert into EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('16','3','20','60','Goal');
Insert into EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('17','3','20','69','Goal');
Insert into EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('18','3','20','76','Goal');
Insert into EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('19','3','21','87','Goal');
Insert into EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('20','4','20','12','Goal');
Insert into EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('21','4','20','21','Goal');
Insert into EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('22','4','122','40','Goal');
Insert into EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('23','4','110','45','Goal');
Insert into EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('24','4','107','89','Goal');
Insert into EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('25','4','107','89','CartellinoG');
Insert into EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('26','5','110','23','CartellinoG');
Insert into EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('27','5','110','29','Goal');
Insert into EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('28','5','41','39','Goal');
Insert into EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('29','5','48','60','Goal');
Insert into EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('30','5','122','60','CartellinoG');
Insert into EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('31','5','122','60','CartellinoR');
Insert into EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('32','6','107','23','Goal');
Insert into EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('33','6','107','60','CartellinoG');
Insert into EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('34','7','107','40','Goal');
Insert into EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('35','7','107','40','Fuorigioco');
Insert into EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('36','8','107','21','CartellinoG');
Insert into EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('37','8','107','60','Tiri');
Insert into EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('38','9','30','21','Goal');
Insert into EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('39','9','76','65','Goal');
Insert into EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('40','9','20','87','Goal');
Insert into EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('41','10','20','21','Goal');
Insert into EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('42','10','20','30','Goal');
Insert into EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('43','10','20','16','Goal');
Insert into EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('44','11','88','1','Goal');
Insert into EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('45','11','38','40','Goal');
Insert into EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('47','12','78','31','Goal');
Insert into EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('48','12','70','45','CartellinoR');
Insert into EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('49','12','95','69','CartellinoG');
Insert into EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('50','1','62','23','Goal');
Insert into EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('51','1','43','65','Assist');
Insert into EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('52','1','38','65','Goal');
Insert into EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('53','12','101','56','Goal');
Insert into EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('54','1','2','45','CartellinoG');
Insert into EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('55','13','20','1','Goal');
Insert into EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('56','13','57','80','Goal');
Insert into EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('57','13','11','90','Goal');
Insert into EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('58','14','20','23','Goal');
Insert into EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('59','15','107','23','Goal');
Insert into EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('60','16','107','56','Goal');
Insert into EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('61','16','11','45','Assist');
Insert into EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('62','16','3','45','Goal');
Insert into EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('63','16','21','89','Goal');
Insert into EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('64','16','130','24','CartellinoG');


Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('129','Wojciech','Szczesny','portiere');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('130','Francesco','Totti','attaccante');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('131','Marco','Tumminello','attaccante');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('132','Thomas','Vermaelen','difensore');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('1','Raul','Albiol','difensore');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('2','Marques Loureiro','Allan','centrocampista');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('3','Jose Maria','Callejon','attaccante');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('4','Vlad','Chiriches','difensore');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('5','Amadou','Diawara','centrocampista');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('6','Omar','El Kaddouri','centrocampista');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('7','Manolo','Gabbiadini','attaccante');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('8','Faouzi','Ghoulam','difensore');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('9','Emanuele','Giaccherini','centrocampista');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('10','Antonio','Granata','difensore');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('11','Marek','Hamsik','centrocampista');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('12','Elseid','Hysaj','difensore');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('13','Lorenzo','Insigne','attaccante');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('14','Luiz','Jorginho','centrocampista');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('15','Kalidou','Koulibaly','difensore');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('16','Igor','Lasicki','difensore');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('17','Henrique do Nascimento ','Leandrinho','attaccante');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('18','Christian','Maggio','difensore');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('19','Nikola','Maksimovic','difensore');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('20','Dries','Mertens','attaccante');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('21','Arkadiusz','Milik','attaccante');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('22','Antonio','Negro','attaccante');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('23','Leonardo','Pavoletti','attaccante');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('24','Cabral Barbosa','Rafael','portiere');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('25','Pepe','Reina','portiere');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('26','Marko','Rog','centrocampista');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('27','Luigi','Sepe','portiere');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('28','Ivan','Strinic','difensore');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('29','Lorenzo','Tonelli','difensore');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('30','Piotr','Zielinski','centrocampista');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('31','Sandro Lobo Silva','Alex','difensore');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('32','Kwadwo','Asamoah','centrocampista');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('33','Emil','Audero','portiere');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('34','Andrea','Barzagli','difensore');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('35','Mehdi','Benatia','difensore');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('36','Leonardo','Bonucci','difensore');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('37','Gianluigi','Buffon','portiere');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('38','Giorgio','Chiellini','difensore');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('39','Luca','Clemenza','attaccante');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('40','Luca','Coccolo','difensore');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('41','Juan Guillermo','Cuadrado','centrocampista');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('42','Da Silva','Dani Alves','difensore');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('43','Paolo','De Ceglie','difensore');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('44','Mattia','Del Favero','portiere');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('45','Paulo','Dybala','attaccante');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('46','Patrice','Evra','difensore');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('47','Anderson','Hernanes','centrocampista');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('48','Gonzalo','Higuain','attaccante');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('49','Grigoris','Kastanos','centrocampista');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('50','Moise','Kean','attaccante');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('51','Sami','Khedira','centrocampista');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('52','Mario','Lemina','centrocampista');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('53','Stephan','Lichtsteiner','difensore');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('54','Leonardo','Loria','portiere');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('55','Roman','Macek','centrocampista');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('56','Rolando','Mandragora','centrocampista');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('57','Mario','Mandzukic','attaccante');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('58','Claudio','Marchisio','centrocampista');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('59','Federico','Mattiello','difensore');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('60','Murara Norberto','Neto','portiere');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('61','Marko','Pjaca','attaccante');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('62','Miralem','Pjanic','centrocampista');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('63','Tomas','Rincon','centrocampista');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('64','Daniele','Rugani','difensore');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('65','Alessandro','Semprini','difensore');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('66','Stefano','Sturaro','centrocampista');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('67','Alessandro','Vogliacco','difensore');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('68','Marius','Adamonis','portiere');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('69','Felipe','Anderson','attaccante');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('70','Dusan','Basta','difensore');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('71','Jacinto','Bastos','difensore');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('72','Lucas Rodrigo','Biglia','centrocampista');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('73','Luca','Borrelli','portiere');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('74','Stefan','De Vrij','difensore');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('75','Filip','Djordjevic','attaccante');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('76','Alvaro','Gonzalez','centrocampista');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('77','Wesley','Hoedt','difensore');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('78','Ciro','Immobile','attaccante');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('79','Duje','Javorcic','centrocampista');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('80','Balde Diao','Keita','attaccante');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('81','Ricardo','Kishna','attaccante');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('82','Moritz','Leitner','centrocampista');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('83','Cristiano','Lombardi','attaccante');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('84','Alberto Romero','Luis','attaccante');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('85','Jordan','Lukaku','difensore');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('86','Senad','Lulic','centrocampista');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('87','Federico','Marchetti','portiere');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('88','Sergej','Milinkovic-Savic','centrocampista');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('89','Joseph Marie','Minala','centrocampista');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('90','Ravel Ryan','Morrison','centrocampista');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('91','Alessandro','Murgia','centrocampista');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('92','Marco','Parolo','centrocampista');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('93','Gabarron Gil','Patric','difensore');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('94','Gianluca','Pollace','difensore');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('95','Stefan','Radu','difensore');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('96','Alessandro','Rossi','attaccante');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('97','Thomas','Strakosha','portiere');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('98','Mamadou','Tounkara','attaccante');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('99','Ivan','Vargic','portiere');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('100','Freitas Ribeiro','Vinicius','centrocampista');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('101','Fortuna Dos Santos','Wallace','difensore');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('102','Ramsê³ Becker','Alisson','portiere');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('103','Lorenzo','Crisanto','portiere');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('104','Daniele','De Rossi','centrocampista');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('105','Eros','De Santis','difensore');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('106','Edin','Dzeko','attaccante');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('107','Stephan','El Shaarawy','attaccante');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('108','Palmieri','Emerson','difensore');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('109','Federico Julian','Fazio','difensore');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('110','Alessandro','Florenzi','centrocampista');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('111','Santos Da Silva','Gerson','centrocampista');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('112','Lorenzo','Grossi','difensore');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('113','Guilherme','Juan Jesus','difensore');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('114','Bogdan','Lobont','portiere');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('115','Kostas','Manolas','difensore');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('116','Riccardo','Marchizza','difensore');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('117','Duarte','Mario Rui','difensore');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('118','Radja','Nainggolan','centrocampista');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('119','Abdullahi','Nura','difensore');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('120','Leandro','Paredes','centrocampista');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('121','Bruno Da Silva','Peres','centrocampista');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('122','Diego','Perotti','attaccante');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('123','Andrea','Romagnoli','portiere');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('124','Antonio','Rudiger','difensore');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('125','Mohamed','Salah','attaccante');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('126','Moustapha','Seck','difensore');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('127','Edoardo','Soleri','attaccante');
Insert into GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('128','Kevin','Strootman','centrocampista');


Insert into INCONTRI (IDPARTITA,IDSQUADRA) values ('1','2');
Insert into INCONTRI (IDPARTITA,IDSQUADRA) values ('3','2');
Insert into INCONTRI (IDPARTITA,IDSQUADRA) values ('2','2');
Insert into INCONTRI (IDPARTITA,IDSQUADRA) values ('4','2');
Insert into INCONTRI (IDPARTITA,IDSQUADRA) values ('5','2');
Insert into INCONTRI (IDPARTITA,IDSQUADRA) values ('6','2');
Insert into INCONTRI (IDPARTITA,IDSQUADRA) values ('7','2');
Insert into INCONTRI (IDPARTITA,IDSQUADRA) values ('8','2');
Insert into INCONTRI (IDPARTITA,IDSQUADRA) values ('9','2');
Insert into INCONTRI (IDPARTITA,IDSQUADRA) values ('10','2');
Insert into INCONTRI (IDPARTITA,IDSQUADRA) values ('11','2');
Insert into INCONTRI (IDPARTITA,IDSQUADRA) values ('12','2');
Insert into INCONTRI (IDPARTITA,IDSQUADRA) values ('13','2');
Insert into INCONTRI (IDPARTITA,IDSQUADRA) values ('14','2');
Insert into INCONTRI (IDPARTITA,IDSQUADRA) values ('15','2');
Insert into INCONTRI (IDPARTITA,IDSQUADRA) values ('16','2');
Insert into INCONTRI (IDPARTITA,IDSQUADRA) values ('1','2');
Insert into INCONTRI (IDPARTITA,IDSQUADRA) values ('3','2');
Insert into INCONTRI (IDPARTITA,IDSQUADRA) values ('2','2');
Insert into INCONTRI (IDPARTITA,IDSQUADRA) values ('4','2');
Insert into INCONTRI (IDPARTITA,IDSQUADRA) values ('5','2');
Insert into INCONTRI (IDPARTITA,IDSQUADRA) values ('6','2');
Insert into INCONTRI (IDPARTITA,IDSQUADRA) values ('7','2');
Insert into INCONTRI (IDPARTITA,IDSQUADRA) values ('8','2');
Insert into INCONTRI (IDPARTITA,IDSQUADRA) values ('9','2');
Insert into INCONTRI (IDPARTITA,IDSQUADRA) values ('10','2');
Insert into INCONTRI (IDPARTITA,IDSQUADRA) values ('11','2');
Insert into INCONTRI (IDPARTITA,IDSQUADRA) values ('12','2');
Insert into INCONTRI (IDPARTITA,IDSQUADRA) values ('13','2');
Insert into INCONTRI (IDPARTITA,IDSQUADRA) values ('14','2');
Insert into INCONTRI (IDPARTITA,IDSQUADRA) values ('15','2');
Insert into INCONTRI (IDPARTITA,IDSQUADRA) values ('16','2');


Insert into PARTECIPANTI_ELIMINAZIONE (IDTORNEOE,IDSQUADRA) values ('1','3');
Insert into PARTECIPANTI_ELIMINAZIONE (IDTORNEOE,IDSQUADRA) values ('1','4');
Insert into PARTECIPANTI_ELIMINAZIONE (IDTORNEOE,IDSQUADRA) values ('1','1');
Insert into PARTECIPANTI_ELIMINAZIONE (IDTORNEOE,IDSQUADRA) values ('1','2');


Insert into PARTECIPANTI_GIRONI (IDTORNEOG,IDSQUADRA) values ('1','3');
Insert into PARTECIPANTI_GIRONI (IDTORNEOG,IDSQUADRA) values ('1','1');
Insert into PARTECIPANTI_GIRONI (IDTORNEOG,IDSQUADRA) values ('1','4');
Insert into PARTECIPANTI_GIRONI (IDTORNEOG,IDSQUADRA) values ('2','1');
Insert into PARTECIPANTI_GIRONI (IDTORNEOG,IDSQUADRA) values ('1','2');
Insert into PARTECIPANTI_GIRONI (IDTORNEOG,IDSQUADRA) values ('2','2');


Insert into PARTITA (IDPARTITA,IDTORNEOG,IDTORNEOE,IDSQ1,IDSQ2,NUMERO_TURNO_TORNEO,STADIO,DATA) values ('1','1',null,'1','2',null,'San Paolo',to_date('01-MAR-16','DD-MON-RR'));
Insert into PARTITA (IDPARTITA,IDTORNEOG,IDTORNEOE,IDSQ1,IDSQ2,NUMERO_TURNO_TORNEO,STADIO,DATA) values ('3','1',null,'3','1',null,'Stadio Olimpico',to_date('28-FEB-16','DD-MON-RR'));
Insert into PARTITA (IDPARTITA,IDTORNEOG,IDTORNEOE,IDSQ1,IDSQ2,NUMERO_TURNO_TORNEO,STADIO,DATA) values ('2','1',null,'2','1',null,'Juventus Stadium',to_date('16-FEB-16','DD-MON-RR'));
Insert into PARTITA (IDPARTITA,IDTORNEOG,IDTORNEOE,IDSQ1,IDSQ2,NUMERO_TURNO_TORNEO,STADIO,DATA) values ('4','1',null,'1','3',null,'San Paolo',to_date('15-MAR-16','DD-MON-RR'));
Insert into PARTITA (IDPARTITA,IDTORNEOG,IDTORNEOE,IDSQ1,IDSQ2,NUMERO_TURNO_TORNEO,STADIO,DATA) values ('5','1',null,'2','3',null,'Juventus Stadium',to_date('25-MAR-16','DD-MON-RR'));
Insert into PARTITA (IDPARTITA,IDTORNEOG,IDTORNEOE,IDSQ1,IDSQ2,NUMERO_TURNO_TORNEO,STADIO,DATA) values ('6','1',null,'3','4',null,'Stadio Olimpico',to_date('01-APR-16','DD-MON-RR'));
Insert into PARTITA (IDPARTITA,IDTORNEOG,IDTORNEOE,IDSQ1,IDSQ2,NUMERO_TURNO_TORNEO,STADIO,DATA) values ('7','1',null,'4','3',null,'Stadio Olimpico',to_date('10-APR-16','DD-MON-RR'));
Insert into PARTITA (IDPARTITA,IDTORNEOG,IDTORNEOE,IDSQ1,IDSQ2,NUMERO_TURNO_TORNEO,STADIO,DATA) values ('8','1',null,'3','2',null,'Stadio Olimpico',to_date('16-APR-16','DD-MON-RR'));
Insert into PARTITA (IDPARTITA,IDTORNEOG,IDTORNEOE,IDSQ1,IDSQ2,NUMERO_TURNO_TORNEO,STADIO,DATA) values ('9','1',null,'1','4',null,'San Paolo',to_date('27-APR-16','DD-MON-RR'));
Insert into PARTITA (IDPARTITA,IDTORNEOG,IDTORNEOE,IDSQ1,IDSQ2,NUMERO_TURNO_TORNEO,STADIO,DATA) values ('10','1',null,'4','1',null,'Stadio Olimpico',to_date('27-APR-16','DD-MON-RR'));
Insert into PARTITA (IDPARTITA,IDTORNEOG,IDTORNEOE,IDSQ1,IDSQ2,NUMERO_TURNO_TORNEO,STADIO,DATA) values ('11','1',null,'2','4',null,'Juventus Stadium',to_date('30-APR-16','DD-MON-RR'));
Insert into PARTITA (IDPARTITA,IDTORNEOG,IDTORNEOE,IDSQ1,IDSQ2,NUMERO_TURNO_TORNEO,STADIO,DATA) values ('12','1',null,'4','2',null,'Stadio Olimpico',to_date('10-MAG-16','DD-MON-RR'));
Insert into PARTITA (IDPARTITA,IDTORNEOG,IDTORNEOE,IDSQ1,IDSQ2,NUMERO_TURNO_TORNEO,STADIO,DATA) values ('13','2',null,'1','2',null,'San Polo',to_date('02-GEN-17','DD-MON-RR'));
Insert into PARTITA (IDPARTITA,IDTORNEOG,IDTORNEOE,IDSQ1,IDSQ2,NUMERO_TURNO_TORNEO,STADIO,DATA) values ('14',null,'1','1','2','1','San Paolo',to_date('21-GEN-17','DD-MON-RR'));
Insert into PARTITA (IDPARTITA,IDTORNEOG,IDTORNEOE,IDSQ1,IDSQ2,NUMERO_TURNO_TORNEO,STADIO,DATA) values ('15',null,'1','3','4','1','Stadio Olimpico',to_date('21-GEN-17','DD-MON-RR'));
Insert into PARTITA (IDPARTITA,IDTORNEOG,IDTORNEOE,IDSQ1,IDSQ2,NUMERO_TURNO_TORNEO,STADIO,DATA) values ('16',null,'1','1','3','2','San Siro',to_date('30-GEN-17','DD-MON-RR'));


Insert into SQUADRA (IDSQUADRA,NOME,TIPO) values ('1','Napoli','club');
Insert into SQUADRA (IDSQUADRA,NOME,TIPO) values ('3','Roma','club');
Insert into SQUADRA (IDSQUADRA,NOME,TIPO) values ('4','Lazio','club');
Insert into SQUADRA (IDSQUADRA,NOME,TIPO) values ('2','Juventus','club');


Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('1','1');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('1','2');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('1','3');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('1','4');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('1','5');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('1','6');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('1','7');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('1','8');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('1','9');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('1','10');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('1','11');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('1','12');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('1','13');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('1','14');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('1','15');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('1','16');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('1','17');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('1','18');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('1','19');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('1','20');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('1','21');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('1','22');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('1','23');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('1','24');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('1','25');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('1','26');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('1','27');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('1','28');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('1','29');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('1','30');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('2','31');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('2','32');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('2','33');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('2','34');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('2','35');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('2','36');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('2','37');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('2','38');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('2','39');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('2','40');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('2','41');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('2','42');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('2','43');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('2','44');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('2','45');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('2','46');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('2','47');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('2','48');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('2','49');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('2','50');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('2','51');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('2','52');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('2','53');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('2','54');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('2','55');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('2','56');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('2','57');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('2','58');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('2','59');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('2','60');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('2','61');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('2','62');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('2','63');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('2','64');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('2','65');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('2','66');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('2','67');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('4','68');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('4','69');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('4','70');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('4','71');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('4','72');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('4','73');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('4','74');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('4','75');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('4','76');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('4','77');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('4','78');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('4','79');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('4','80');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('4','81');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('4','82');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('4','83');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('4','84');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('4','85');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('4','86');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('4','87');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('4','88');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('4','89');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('4','90');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('4','91');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('4','92');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('4','93');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('4','94');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('4','95');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('4','96');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('4','97');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('4','98');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('4','99');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('4','100');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('4','101');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('3','102');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('3','103');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('3','104');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('3','105');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('3','106');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('3','107');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('3','108');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('3','109');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('3','110');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('3','111');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('3','112');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('3','113');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('3','114');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('3','115');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('3','116');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('3','117');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('3','118');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('3','119');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('3','120');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('3','121');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('3','122');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('3','123');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('3','124');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('3','125');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('3','126');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('3','127');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('3','128');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('3','129');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('3','130');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('3','131');
Insert into SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('3','132');


Insert into TORNEO_ELIMINAZIONE (IDTORNEOE,STAGIONEE,NOMETORNEOE) values ('1','2016     ','Torneo Speriamo Bene');

Insert into TORNEO_GIRONI (IDTORNEOG,STAGIONEG,NOMETORNEOG) values ('1','2016     ','Torneo A');
Insert into TORNEO_GIRONI (IDTORNEOG,STAGIONEG,NOMETORNEOG) values ('2','2016     ','tORNEO pROVA');


--------------------------------------------------------
--  DDL for Trigger INS_INCONTRI
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "INS_INCONTRI" AFTER INSERT ON PARTITA
BEGIN
IF INSERTING  THEN
INSERT INTO INCONTRI (IDPARTITA, IDSQUADRA)
  SELECT IDPARTITA, IDSQ1
  FROM PARTITA
  WHERE IDPARTITA = (SELECT MAX(IDPARTITA) FROM PARTITA);
END IF;

IF INSERTING THEN
INSERT INTO INCONTRI (IDPARTITA, IDSQUADRA)
  SELECT IDPARTITA, IDSQ2
  FROM PARTITA
  WHERE IDPARTITA = (SELECT MAX(IDPARTITA) FROM PARTITA);
END IF;
END;
/

ALTER TRIGGER "INS_INCONTRI" ENABLE;

--------------------------------------------------------
--  DDL for Trigger UPD_INCONTRI
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "UPD_INCONTRI" AFTER UPDATE OF IDSQ2 ON PARTITA
FOR EACH ROW
BEGIN
  UPDATE INCONTRI I
  SET I.IDSQUADRA = :NEW.IDSQ2
  WHERE (SELECT IDPARTITA FROM PARTITA) = IDPARTITA
    AND I.IDSQUADRA = :OLD.IDSQ2
    AND I.IDSQUADRA = (SELECT IDSQ1 FROM PARTITA);
END;
/
ALTER TRIGGER "UPD_INCONTRI" DISABLE;

--------------------------------------------------------
--  Constraints for Table EVENTI
--------------------------------------------------------

  ALTER TABLE "EVENTI" ADD PRIMARY KEY ("IDEVENTO");
  ALTER TABLE "EVENTI" ADD CHECK (Evento IN ('Goal', 'Tiri', 'CartellinoG', 'CartellinoR', 'Fuorigioco', 'Assist', 'TiroInPorta')) ENABLE;
  ALTER TABLE "EVENTI" MODIFY ("EVENTO" NOT NULL ENABLE);
  ALTER TABLE "EVENTI" MODIFY ("MINUTO" NOT NULL ENABLE);
  ALTER TABLE "EVENTI" MODIFY ("IDGIOCATORE" NOT NULL ENABLE);
  ALTER TABLE "EVENTI" MODIFY ("IDPARTITA" NOT NULL ENABLE);

--------------------------------------------------------
--  Constraints for Table GIOCATORE
--------------------------------------------------------

  ALTER TABLE "GIOCATORE" ADD PRIMARY KEY ("IDGIOCATORE");
  ALTER TABLE "GIOCATORE" ADD CHECK (Ruolo IN ('portiere', 'difensore', 'centrocampista', 'attaccante')) ENABLE;
  ALTER TABLE "GIOCATORE" MODIFY ("RUOLO" NOT NULL ENABLE);
  ALTER TABLE "GIOCATORE" MODIFY ("COGNOME" NOT NULL ENABLE);
  ALTER TABLE "GIOCATORE" MODIFY ("NOME" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table INCONTRI
--------------------------------------------------------

  ALTER TABLE "INCONTRI" MODIFY ("IDSQUADRA" NOT NULL ENABLE);
  ALTER TABLE "INCONTRI" MODIFY ("IDPARTITA" NOT NULL ENABLE);

--------------------------------------------------------
--  Constraints for Table PARTECIPANTI_ELIMINAZIONE
--------------------------------------------------------

  ALTER TABLE "PARTECIPANTI_ELIMINAZIONE" MODIFY ("IDSQUADRA" NOT NULL ENABLE);
  ALTER TABLE "PARTECIPANTI_ELIMINAZIONE" MODIFY ("IDTORNEOE" NOT NULL ENABLE);

--------------------------------------------------------
--  Constraints for Table PARTECIPANTI_GIRONI
--------------------------------------------------------

  ALTER TABLE "PARTECIPANTI_GIRONI" MODIFY ("IDSQUADRA" NOT NULL ENABLE);
  ALTER TABLE "PARTECIPANTI_GIRONI" MODIFY ("IDTORNEOG" NOT NULL ENABLE);

--------------------------------------------------------
--  Constraints for Table PARTITA
--------------------------------------------------------

  ALTER TABLE "PARTITA" ADD PRIMARY KEY ("IDPARTITA");
  ALTER TABLE "PARTITA" MODIFY ("DATA" NOT NULL ENABLE);
  ALTER TABLE "PARTITA" MODIFY ("STADIO" NOT NULL ENABLE);
  ALTER TABLE "PARTITA" MODIFY ("IDSQ2" NOT NULL ENABLE);
  ALTER TABLE "PARTITA" MODIFY ("IDSQ1" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table SQUADRA
--------------------------------------------------------

  ALTER TABLE "SQUADRA" ADD PRIMARY KEY ("IDSQUADRA");
  ALTER TABLE "SQUADRA" ADD CHECK (Tipo IN ('club', 'nazionale')) ENABLE;
  ALTER TABLE "SQUADRA" MODIFY ("TIPO" NOT NULL ENABLE);
  ALTER TABLE "SQUADRA" MODIFY ("NOME" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table SQUADRA_GIOCATORI
--------------------------------------------------------

  ALTER TABLE "SQUADRA_GIOCATORI" MODIFY ("IDGIOCATORE" NOT NULL ENABLE);
  ALTER TABLE "SQUADRA_GIOCATORI" MODIFY ("IDSQUADRA" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table STAFF
--------------------------------------------------------

  ALTER TABLE "STAFF" ADD PRIMARY KEY ("IDSTAFF");
  ALTER TABLE "STAFF" ADD CHECK (Professione IN ('allenatore', 'dirigente', 'presidente')) ENABLE;
  ALTER TABLE "STAFF" MODIFY ("PROFESSIONE" NOT NULL ENABLE);
  ALTER TABLE "STAFF" MODIFY ("DATANASCITA" NOT NULL ENABLE);
  ALTER TABLE "STAFF" MODIFY ("LUOGONASCITA" NOT NULL ENABLE);
  ALTER TABLE "STAFF" MODIFY ("COGNOME" NOT NULL ENABLE);
  ALTER TABLE "STAFF" MODIFY ("NOME" NOT NULL ENABLE);
  ALTER TABLE "STAFF" MODIFY ("IDSQUADRA" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table TORNEO_ELIMINAZIONE
--------------------------------------------------------

  ALTER TABLE "TORNEO_ELIMINAZIONE" ADD PRIMARY KEY ("IDTORNEOE");
  ALTER TABLE "TORNEO_ELIMINAZIONE" MODIFY ("NOMETORNEOE" NOT NULL ENABLE);
  ALTER TABLE "TORNEO_ELIMINAZIONE" MODIFY ("STAGIONEE" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table TORNEO_GIRONI
--------------------------------------------------------

  ALTER TABLE "TORNEO_GIRONI" ADD PRIMARY KEY ("IDTORNEOG");
  ALTER TABLE "TORNEO_GIRONI" MODIFY ("NOMETORNEOG" NOT NULL ENABLE);
  ALTER TABLE "TORNEO_GIRONI" MODIFY ("STAGIONEG" NOT NULL ENABLE);

  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  ALTER TABLE STAFF
ADD CONSTRAINT IDsquadra_STAFF_FK
 FOREIGN KEY (IDsquadra) REFERENCES SQUADRA(IDsquadra)
ON DELETE CASCADE	ENABLE;

ALTER TABLE SQUADRA_GIOCATORI
ADD CONSTRAINT IDsquadra_SQ_GIOCATORI_FK
 FOREIGN KEY (IDsquadra) REFERENCES SQUADRA(IDsquadra)
ON DELETE CASCADE	ENABLE;

ALTER TABLE SQUADRA_GIOCATORI
ADD CONSTRAINT IDgiocatore_SQ_GIOCATORI_FK
 FOREIGN KEY (IDgiocatore) REFERENCES GIOCATORE(IDgiocatore)
ON DELETE CASCADE	ENABLE;

ALTER TABLE EVENTI
ADD CONSTRAINT IDgiocatore_EVENTI_FK
FOREIGN KEY (IDgiocatore) REFERENCES GIOCATORE(IDgiocatore)
ON DELETE CASCADE	ENABLE;

ALTER TABLE EVENTI
ADD CONSTRAINT IDpartita_EVENTI_FK
FOREIGN KEY (IDpartita) REFERENCES PARTITA(IDpartita)
ON DELETE CASCADE	ENABLE;

ALTER TABLE PARTITA
ADD CONSTRAINT IDtorneoG_PARTITA_FK
 FOREIGN KEY (IDtorneoG) REFERENCES TORNEO_GIRONI(IDtorneoG)
ON DELETE CASCADE	ENABLE;
ALTER TABLE PARTITA
ADD CONSTRAINT IDtorneoE_PARTITA_FK
 FOREIGN KEY (IDtorneoE) REFERENCES TORNEO_ELIMINAZIONE(IDtorneoE)
ON DELETE CASCADE	ENABLE;

ALTER TABLE INCONTRI
ADD CONSTRAINT IDpartita_INCONTRI_FK
 FOREIGN KEY (IDpartita) REFERENCES PARTITA(IDpartita)
ON DELETE CASCADE	ENABLE;
ALTER TABLE INCONTRI
ADD CONSTRAINT IDsquadra_INCONTRI_FK
 FOREIGN KEY (IDsquadra) REFERENCES SQUADRA(IDsquadra)
ON DELETE CASCADE	ENABLE;

ALTER TABLE  PARTECIPANTI_GIRONI
ADD CONSTRAINT IDtorneoG_PART_GIR_FK
 FOREIGN KEY (IDtorneoG) REFERENCES TORNEO_GIRONI(IDtorneoG)
	ON DELETE CASCADE	ENABLE;
ALTER TABLE  PARTECIPANTI_GIRONI
ADD CONSTRAINT IDsquadraG_PART_GIR_FK
 FOREIGN KEY (IDsquadra) REFERENCES SQUADRA(IDsquadra)
ON DELETE CASCADE	ENABLE;

ALTER TABLE  PARTECIPANTI_ELIMINAZIONE
ADD CONSTRAINT IDtorneoE_FK
FOREIGN KEY (IDtorneoE) REFERENCES TORNEO_ELIMINAZIONE(IDtorneoE)
ON DELETE CASCADE	ENABLE;
ALTER TABLE  PARTECIPANTI_ELIMINAZIONE
ADD CONSTRAINT IDsquadraE_FK
 FOREIGN KEY (IDsquadra) REFERENCES SQUADRA(IDsquadra)
ON DELETE CASCADE	ENABLE;