--------------------------------------------------------
--  File creato - sabato-gennaio-21-2017   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for View ASSIST_INDIVIDUALI
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "ANDREA"."ASSIST_INDIVIDUALI" ("IDGIOCATORE", "NOME", "COGNOME", "ASSIST") AS 
  SELECT G.IDgiocatore, G.Nome, G.Cognome, COUNT(E.IDevento)
	FROM GIOCATORE G JOIN EVENTI E ON G.IDgiocatore = E.IDgiocatore
	WHERE E.Evento = 'Assist'
GROUP BY  G.IDgiocatore, G.Nome, G.Cognome;
--------------------------------------------------------
--  DDL for View ASSIST_PARTITA
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "ANDREA"."ASSIST_PARTITA" ("IDGIOCATORE", "IDPARTITA", "NOME", "COGNOME", "SQUADRA", "ASSIST") AS 
  SELECT SI.IDgiocatore, E.IDPARTITA, SI.Nome, SI.Cognome, SI.SQUADRA,COUNT(E.IDevento)
	FROM STAT_INDIVIDUALI SI JOIN EVENTI E ON SI.IDGIOCATORE = E.IDGIOCATORE
	WHERE E.Evento = 'Assist'
GROUP BY  SI.IDgiocatore, E.IDPARTITA, SI.Nome, SI.Cognome, SI.SQUADRA;
--------------------------------------------------------
--  DDL for View CARDG_INDIVIDUALI
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "ANDREA"."CARDG_INDIVIDUALI" ("IDGIOCATORE", "NOME", "COGNOME", "AMMONIZIONI") AS 
  SELECT G.IDgiocatore, G.Nome, G.Cognome, COUNT(E.IDevento)
	FROM GIOCATORE G JOIN EVENTI E ON G.IDgiocatore = E.IDgiocatore
	WHERE E.Evento = 'CartellinoG'
GROUP BY  G.IDgiocatore, G.Nome, G.Cognome;
--------------------------------------------------------
--  DDL for View CARDR_INDIVIDUALI
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "ANDREA"."CARDR_INDIVIDUALI" ("IDGIOCATORE", "NOME", "COGNOME", "ESPULSIONI") AS 
  SELECT G.IDgiocatore, G.Nome, G.Cognome, COUNT(E.IDevento)
	FROM GIOCATORE G JOIN EVENTI E ON G.IDgiocatore = E.IDgiocatore
	WHERE E.Evento = 'CartellinoR'
GROUP BY  G.IDgiocatore, G.Nome, G.Cognome;
--------------------------------------------------------
--  DDL for View FALLI_INDIVIDUALI
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "ANDREA"."FALLI_INDIVIDUALI" ("IDGIOCATORE", "NOME", "COGNOME", "FALLO") AS 
  SELECT G.IDgiocatore, G.Nome, G.Cognome, COUNT(E.IDevento)
	FROM GIOCATORE G JOIN EVENTI E ON G.IDgiocatore = E.IDgiocatore
	WHERE E.Evento = 'Fallo'
GROUP BY  G.IDgiocatore, G.Nome, G.Cognome;
--------------------------------------------------------
--  DDL for View FUORIGIOCO_INDIVIDUALI
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "ANDREA"."FUORIGIOCO_INDIVIDUALI" ("IDGIOCATORE", "NOME", "COGNOME", "FUORIGIOCO") AS 
  SELECT G.IDgiocatore, G.Nome, G.Cognome, COUNT(E.IDevento)
	FROM GIOCATORE G JOIN EVENTI E ON G.IDgiocatore = E.IDgiocatore
	WHERE E.Evento = 'Fuorigioco'
GROUP BY  G.IDgiocatore, G.Nome, G.Cognome;
--------------------------------------------------------
--  DDL for View GOAL_INDIVIDUALI
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "ANDREA"."GOAL_INDIVIDUALI" ("IDGIOCATORE", "NOME", "COGNOME", "GOAL") AS 
  SELECT G.IDgiocatore, G.Nome, G.Cognome, COUNT(E.IDevento)
	FROM GIOCATORE G JOIN EVENTI E ON G.IDGIOCATORE = E.IDGIOCATORE
	WHERE E.Evento = 'Goal'
GROUP BY  G.IDgiocatore, G.Nome, G.Cognome;
--------------------------------------------------------
--  DDL for View GOAL_PARTITA
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "ANDREA"."GOAL_PARTITA" ("IDGIOCATORE", "IDPARTITA", "NOME", "COGNOME", "SQUADRA", "GOAL") AS 
  SELECT SI.IDgiocatore, E.IDPARTITA, SI.Nome, SI.Cognome, SI.SQUADRA,COUNT(E.IDevento)
	FROM STAT_INDIVIDUALI SI JOIN EVENTI E ON SI.IDGIOCATORE = E.IDGIOCATORE
	WHERE E.Evento = 'Goal'
GROUP BY  SI.IDgiocatore, E.IDPARTITA, SI.Nome, SI.Cognome, SI.SQUADRA;
--------------------------------------------------------
--  DDL for View GOAL_SQUADRA_PARTITA
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "ANDREA"."GOAL_SQUADRA_PARTITA" ("IDSQUADRA", "SQUADRA", "IDPARTITA", "GOAL") AS 
  SELECT STAT_INDIVIDUALI.IDSQUADRA, SQUADRA.NOME, GOAL_PARTITA.IDPARTITA, SUM (GOAL_PARTITA.GOAL)
FROM GOAL_PARTITA, STAT_INDIVIDUALI, SQUADRA
WHERE GOAL_PARTITA.IDGIOCATORE=STAT_INDIVIDUALI.IDGIOCATORE AND SQUADRA.IDSQUADRA=STAT_INDIVIDUALI.IDSQUADRA
GROUP BY STAT_INDIVIDUALI.IDSQUADRA, SQUADRA.NOME, IDPARTITA;
--------------------------------------------------------
--  DDL for View STAT_INDIVIDUALI
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "ANDREA"."STAT_INDIVIDUALI" ("IDGIOCATORE", "NOME", "COGNOME", "IDSQUADRA", "SQUADRA", "GOAL", "TIRI", "FALLI", "AMMONIZIONI", "ESPULSIONI", "FUORIGIOCO", "ASSIST", "TIRIINPORTA") AS 
  SELECT GIO.IDgiocatore, GIO.Nome, GIO.Cognome, SQ.IDSQUADRA, SQ.Nome, COALESCE(G.Goal,0), COALESCE(T.Tiri,0), COALESCE(F.Fallo,0), COALESCE(CG.Ammonizioni,0), COALESCE(CR.Espulsioni,0), COALESCE(FG.Fuorigioco,0), COALESCE(AI.Assist,0), COALESCE(TI.TiroInPorta,0)
	FROM ((((((((GIOCATORE GIO LEFT OUTER JOIN GOAL_INDIVIDUALI G ON GIO.IDgiocatore = G.IDgiocatore) LEFT OUTER JOIN TIRI_INDIVIDUALI T ON GIO.IDgiocatore = T.IDgiocatore) LEFT OUTER JOIN FALLI_INDIVIDUALI F ON GIO.IDgiocatore = F.IDgiocatore) LEFT OUTER JOIN CARDG_INDIVIDUALI CG ON GIO.IDgiocatore = CG.IDgiocatore) LEFT OUTER JOIN CARDR_INDIVIDUALI CR ON GIO.IDgiocatore = CR.IDgiocatore) LEFT OUTER JOIN FUORIGIOCO_INDIVIDUALI FG ON GIO.IDgiocatore = FG.IDgiocatore) LEFT JOIN ASSIST_INDIVIDUALI  AI ON GIO.IDgiocatore = AI.IDgiocatore) LEFT OUTER JOIN TIP_INDIVIDUALI TI ON GIO.IDgiocatore = TI.IDgiocatore) JOIN (SQUADRA SQ JOIN SQUADRA_GIOCATORI SQG ON SQ.IDsquadra = SQG.IDsquadra) ON GIO.IDgiocatore = SQG.IDgiocatore;
--------------------------------------------------------
--  DDL for View TIP_INDIVIDUALI
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "ANDREA"."TIP_INDIVIDUALI" ("IDGIOCATORE", "NOME", "COGNOME", "TIROINPORTA") AS 
  SELECT G.IDgiocatore, G.Nome, G.Cognome, COUNT(E.IDevento)
	FROM GIOCATORE G JOIN EVENTI E ON G.IDgiocatore = E.IDgiocatore
	WHERE E.Evento = 'TiroInPorta'
GROUP BY  G.IDgiocatore, G.Nome, G.Cognome;
--------------------------------------------------------
--  DDL for View TIRI_INDIVIDUALI
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "ANDREA"."TIRI_INDIVIDUALI" ("IDGIOCATORE", "NOME", "COGNOME", "TIRI") AS 
  SELECT G.IDgiocatore, G.Nome, G.Cognome, COUNT(E.IDevento)
	FROM GIOCATORE G JOIN EVENTI E ON G.IDgiocatore = E.IDgiocatore
	WHERE E.Evento = 'Tiri'
GROUP BY  G.IDgiocatore, G.Nome, G.Cognome;
--------------------------------------------------------
--  DDL for View VISTA_ASSIST
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "ANDREA"."VISTA_ASSIST" ("IDTORNEO", "GIOCATORE", "SQUADRA", "ASSIST") AS 
  SELECT P.IDTORNEOG, AP.COGNOME, AP.SQUADRA, SUM(AP.ASSIST)
FROM (ASSIST_PARTITA AP INNER JOIN PARTITA P ON P.IDPARTITA = AP.IDPARTITA)
GROUP BY P.IDTORNEOG, AP.COGNOME, AP.SQUADRA;
--------------------------------------------------------
--  DDL for View VISTA_EVENTI
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "ANDREA"."VISTA_EVENTI" ("IDPARTITA", "MINUTO", "SQUADRA", "EVENTO", "GIOCATORE") AS 
  SELECT EVENTI.IDPARTITA, EVENTI.MINUTO, STAT_INDIVIDUALI.SQUADRA, EVENTI.EVENTO, STAT_INDIVIDUALI.COGNOME
FROM (EVENTI INNER JOIN PARTITA ON EVENTI.IDPARTITA = PARTITA.IDPARTITA) INNER JOIN STAT_INDIVIDUALI ON EVENTI.IDGIOCATORE = STAT_INDIVIDUALI.IDGIOCATORE
ORDER BY MINUTO DESC;
--------------------------------------------------------
--  DDL for View VISTA_MARCATORI
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "ANDREA"."VISTA_MARCATORI" ("IDTORNEO", "GIOCATORE", "SQUADRA", "GOAL") AS 
  SELECT P.IDTORNEOG, GP.COGNOME, GP.SQUADRA, SUM(GP.GOAL)
FROM (GOAL_PARTITA GP INNER JOIN PARTITA P ON P.IDPARTITA = GP.IDPARTITA) --LEFT JOIN ASSIST_PARTITA AP ON  )
GROUP BY P.IDTORNEOG, GP.COGNOME, GP.SQUADRA;
--------------------------------------------------------
--  DDL for View VISTA_RIS_PARTITE
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "ANDREA"."VISTA_RIS_PARTITE" ("IDPARTITA", "IDSQ1", "SQUADRA1", "GOL1", "GOL2", "SQUADRA2", "IDSQ2", "PG.IDTORNEOG", "PE.IDTORNEOE") AS 
  SELECT I.IDPARTITA, I.IDSQ1, ST.SQUADRA, COALESCE(G1.GOAL,0) AS GOL1, COALESCE(G2.GOAL,0) AS GOL2, STAT.SQUADRA, I.IDSQ2, PG.IDTORNEOG, PE.IDTORNEOE
FROM (((((INCONTRI I LEFT JOIN STAT_INDIVIDUALI ST ON I.IDSQ1=ST.IDSQUADRA) LEFT JOIN STAT_INDIVIDUALI STAT ON I.IDSQ2=STAT.IDSQUADRA) 
    LEFT JOIN GOAL_SQUADRA_PARTITA G1 ON I.IDSQ1=G1.IDSQUADRA AND I.IDPARTITA=G1.IDPARTITA)
    LEFT JOIN GOAL_SQUADRA_PARTITA G2 ON I.IDSQ2=G2.IDSQUADRA AND I.IDPARTITA=G2.IDPARTITA)
    LEFT JOIN (PARTECIPANTI_GIRONI PG LEFT JOIN PARTITA P ON P.IDTORNEOG = PG.IDTORNEOG) ON P.IDPARTITA = I.IDPARTITA)
    LEFT JOIN (PARTECIPANTI_ELIMINAZIONE PE LEFT JOIN PARTITA P ON P.IDTORNEOE = PE.IDTORNEOE) ON P.IDPARTITA = I.IDPARTITA
GROUP BY I.IDPARTITA, I.IDSQ1, ST.SQUADRA,G1.GOAL, G2.GOAL, STAT.SQUADRA, I.IDSQ2, PG.IDTORNEOG, PE.IDTORNEOE;
--------------------------------------------------------
--  DDL for View VISTA_STAFF
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "ANDREA"."VISTA_STAFF" ("NOME", "COGNOME", "IDSTAFF", "NAZIONALITA", "DATANASCITA", "SQUADRA", "PROFESSIONE") AS 
  SELECT ST.Nome, ST.Cognome, ST.IDstaff, ST.LuogoNascita, ST.DataNascita, SQ.Nome, ST.Professione
	FROM STAFF ST JOIN SQUADRA SQ ON ST.IDSQUADRA = SQ.IDSQUADRA;
--------------------------------------------------------
--  DDL for Table EVENTI
--------------------------------------------------------

  CREATE TABLE "ANDREA"."EVENTI" 
   (	"IDEVENTO" NUMBER(*,0), 
	"IDPARTITA" NUMBER(*,0), 
	"IDGIOCATORE" NUMBER(*,0), 
	"MINUTO" FLOAT(126), 
	"EVENTO" VARCHAR2(20 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Table GIOCATORE
--------------------------------------------------------

  CREATE TABLE "ANDREA"."GIOCATORE" 
   (	"IDGIOCATORE" NUMBER(*,0), 
	"NOME" VARCHAR2(30 BYTE), 
	"COGNOME" VARCHAR2(30 BYTE), 
	"RUOLO" VARCHAR2(20 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Table INCONTRI
--------------------------------------------------------

  CREATE TABLE "ANDREA"."INCONTRI" 
   (	"IDPARTITA" NUMBER(*,0), 
	"IDSQ1" NUMBER(*,0), 
	"IDSQ2" NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Table PARTECIPANTI_ELIMINAZIONE
--------------------------------------------------------

  CREATE TABLE "ANDREA"."PARTECIPANTI_ELIMINAZIONE" 
   (	"IDTORNEOE" NUMBER(*,0), 
	"IDSQUADRA" NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Table PARTECIPANTI_GIRONI
--------------------------------------------------------

  CREATE TABLE "ANDREA"."PARTECIPANTI_GIRONI" 
   (	"IDTORNEOG" NUMBER(*,0), 
	"IDSQUADRA" NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Table PARTITA
--------------------------------------------------------

  CREATE TABLE "ANDREA"."PARTITA" 
   (	"IDPARTITA" NUMBER(*,0), 
	"IDTORNEOG" NUMBER(*,0), 
	"IDTORNEOE" NUMBER(*,0), 
	"IDSQ1" NUMBER(*,0), 
	"IDSQ2" NUMBER(*,0), 
	"NUMERO_TURNO_TORNEO" NUMBER(*,0), 
	"STADIO" VARCHAR2(30 BYTE), 
	"DATA" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Table SQUADRA
--------------------------------------------------------

  CREATE TABLE "ANDREA"."SQUADRA" 
   (	"IDSQUADRA" NUMBER(*,0), 
	"NOME" VARCHAR2(30 BYTE), 
	"TIPO" VARCHAR2(10 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Table SQUADRA_GIOCATORI
--------------------------------------------------------

  CREATE TABLE "ANDREA"."SQUADRA_GIOCATORI" 
   (	"IDSQUADRA" NUMBER(*,0), 
	"IDGIOCATORE" NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Table STAFF
--------------------------------------------------------

  CREATE TABLE "ANDREA"."STAFF" 
   (	"IDSTAFF" NUMBER(*,0), 
	"IDSQUADRA" NUMBER(*,0), 
	"NOME" VARCHAR2(30 BYTE), 
	"COGNOME" VARCHAR2(30 BYTE), 
	"LUOGONASCITA" VARCHAR2(30 BYTE), 
	"DATANASCITA" DATE, 
	"PROFESSIONE" VARCHAR2(30 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Table TORNEO_ELIMINAZIONE
--------------------------------------------------------

  CREATE TABLE "ANDREA"."TORNEO_ELIMINAZIONE" 
   (	"IDTORNEOE" NUMBER(*,0), 
	"STAGIONEE" CHAR(9 BYTE), 
	"NOMETORNEOE" VARCHAR2(30 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Table TORNEO_GIRONI
--------------------------------------------------------

  CREATE TABLE "ANDREA"."TORNEO_GIRONI" 
   (	"IDTORNEOG" NUMBER(*,0), 
	"STAGIONEG" CHAR(9 BYTE), 
	"NOMETORNEOG" VARCHAR2(30 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
REM INSERTING into ANDREA.EVENTI
SET DEFINE OFF;
Insert into ANDREA.EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('2','1','7','24','Goal');
Insert into ANDREA.EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('3','1','21','24','Assist');
Insert into ANDREA.EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('1','1','14','2','Goal');
Insert into ANDREA.EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('4','1','2','68','Assist');
Insert into ANDREA.EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('5','1','20','68','Goal');
Insert into ANDREA.EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('6','2','41','13','Assist');
Insert into ANDREA.EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('7','2','62','13','Goal');
Insert into ANDREA.EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('8','2','48','26','Goal');
Insert into ANDREA.EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('9','2','21','57','Goal');
Insert into ANDREA.EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('10','2','21','60','Assist');
Insert into ANDREA.EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('11','2','11','60','Goal');
Insert into ANDREA.EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('12','2','8','80','Assist');
Insert into ANDREA.EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('13','2','21','80','Goal');
Insert into ANDREA.EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('14','3','130','12','Goal');
Insert into ANDREA.EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('15','3','118','38','Goal');
Insert into ANDREA.EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('16','3','20','60','Goal');
Insert into ANDREA.EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('17','3','20','69','Goal');
Insert into ANDREA.EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('18','3','20','76','Goal');
Insert into ANDREA.EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('19','3','21','87','Goal');
Insert into ANDREA.EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('20','4','20','12','Goal');
Insert into ANDREA.EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('21','4','20','21','Goal');
Insert into ANDREA.EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('22','4','122','40','Goal');
Insert into ANDREA.EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('23','4','110','45','Goal');
Insert into ANDREA.EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('24','4','107','89','Goal');
Insert into ANDREA.EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('25','4','107','89','CartellinoG');
Insert into ANDREA.EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('26','5','110','23','CartellinoG');
Insert into ANDREA.EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('27','5','110','29','Goal');
Insert into ANDREA.EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('28','5','41','39','Goal');
Insert into ANDREA.EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('29','5','48','60','Goal');
Insert into ANDREA.EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('30','5','122','60','CartellinoG');
Insert into ANDREA.EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('31','5','122','60','CartellinoR');
Insert into ANDREA.EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('32','6','107','23','Goal');
Insert into ANDREA.EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('33','6','107','60','CartellinoG');
Insert into ANDREA.EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('34','7','107','40','Goal');
Insert into ANDREA.EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('35','7','107','40','Fuorigioco');
Insert into ANDREA.EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('36','8','107','21','CartellinoG');
Insert into ANDREA.EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('37','8','107','60','Tiri');
Insert into ANDREA.EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('38','9','30','21','Goal');
Insert into ANDREA.EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('39','9','76','65','Goal');
Insert into ANDREA.EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('40','9','20','87','Goal');
Insert into ANDREA.EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('41','10','20','21','Goal');
Insert into ANDREA.EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('42','10','20','30','Goal');
Insert into ANDREA.EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('43','10','20','16','Goal');
Insert into ANDREA.EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('44','11','88','1','Goal');
Insert into ANDREA.EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('45','11','38','40','Goal');
Insert into ANDREA.EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('47','12','78','31','Goal');
Insert into ANDREA.EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('48','12','70','45','CartellinoR');
Insert into ANDREA.EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('49','12','95','69','CartellinoG');
Insert into ANDREA.EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('50','1','62','23','Goal');
Insert into ANDREA.EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('51','1','43','65','Assist');
Insert into ANDREA.EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('52','1','38','65','Goal');
Insert into ANDREA.EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('53','12','101','56','Goal');
Insert into ANDREA.EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('54','1','2','45','CartellinoG');
Insert into ANDREA.EVENTI (IDEVENTO,IDPARTITA,IDGIOCATORE,MINUTO,EVENTO) values ('55','13','20','1','Goal');
REM INSERTING into ANDREA.GIOCATORE
SET DEFINE OFF;
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('129','Wojciech','Szczesny','portiere');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('130','Francesco','Totti','attaccante');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('131','Marco','Tumminello','attaccante');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('132','Thomas','Vermaelen','difensore');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('1','Raul','Albiol','difensore');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('2','Marques Loureiro','Allan','centrocampista');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('3','Jose Maria','Callejon','attaccante');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('4','Vlad','Chiriches','difensore');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('5','Amadou','Diawara','centrocampista');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('6','Omar','El Kaddouri','centrocampista');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('7','Manolo','Gabbiadini','attaccante');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('8','Faouzi','Ghoulam','difensore');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('9','Emanuele','Giaccherini','centrocampista');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('10','Antonio','Granata','difensore');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('11','Marek','Hamsik','centrocampista');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('12','Elseid','Hysaj','difensore');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('13','Lorenzo','Insigne','attaccante');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('14','Luiz','Jorginho','centrocampista');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('15','Kalidou','Koulibaly','difensore');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('16','Igor','Lasicki','difensore');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('17','Henrique do Nascimento ','Leandrinho','attaccante');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('18','Christian','Maggio','difensore');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('19','Nikola','Maksimovic','difensore');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('20','Dries','Mertens','attaccante');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('21','Arkadiusz','Milik','attaccante');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('22','Antonio','Negro','attaccante');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('23','Leonardo','Pavoletti','attaccante');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('24','Cabral Barbosa','Rafael','portiere');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('25','Pepe','Reina','portiere');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('26','Marko','Rog','centrocampista');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('27','Luigi','Sepe','portiere');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('28','Ivan','Strinic','difensore');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('29','Lorenzo','Tonelli','difensore');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('30','Piotr','Zielinski','centrocampista');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('31','Sandro Lobo Silva','Alex','difensore');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('32','Kwadwo','Asamoah','centrocampista');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('33','Emil','Audero','portiere');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('34','Andrea','Barzagli','difensore');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('35','Mehdi','Benatia','difensore');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('36','Leonardo','Bonucci','difensore');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('37','Gianluigi','Buffon','portiere');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('38','Giorgio','Chiellini','difensore');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('39','Luca','Clemenza','attaccante');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('40','Luca','Coccolo','difensore');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('41','Juan Guillermo','Cuadrado','centrocampista');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('42','Da Silva','Dani Alves','difensore');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('43','Paolo','De Ceglie','difensore');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('44','Mattia','Del Favero','portiere');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('45','Paulo','Dybala','attaccante');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('46','Patrice','Evra','difensore');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('47','Anderson','Hernanes','centrocampista');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('48','Gonzalo','Higuain','attaccante');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('49','Grigoris','Kastanos','centrocampista');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('50','Moise','Kean','attaccante');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('51','Sami','Khedira','centrocampista');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('52','Mario','Lemina','centrocampista');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('53','Stephan','Lichtsteiner','difensore');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('54','Leonardo','Loria','portiere');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('55','Roman','Macek','centrocampista');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('56','Rolando','Mandragora','centrocampista');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('57','Mario','Mandzukic','attaccante');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('58','Claudio','Marchisio','centrocampista');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('59','Federico','Mattiello','difensore');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('60','Murara Norberto','Neto','portiere');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('61','Marko','Pjaca','attaccante');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('62','Miralem','Pjanic','centrocampista');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('63','Tomas','Rincon','centrocampista');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('64','Daniele','Rugani','difensore');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('65','Alessandro','Semprini','difensore');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('66','Stefano','Sturaro','centrocampista');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('67','Alessandro','Vogliacco','difensore');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('68','Marius','Adamonis','portiere');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('69','Felipe','Anderson','attaccante');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('70','Dusan','Basta','difensore');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('71','Jacinto','Bastos','difensore');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('72','Lucas Rodrigo','Biglia','centrocampista');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('73','Luca','Borrelli','portiere');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('74','Stefan','De Vrij','difensore');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('75','Filip','Djordjevic','attaccante');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('76','Alvaro','Gonzalez','centrocampista');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('77','Wesley','Hoedt','difensore');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('78','Ciro','Immobile','attaccante');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('79','Duje','Javorcic','centrocampista');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('80','Balde Diao','Keita','attaccante');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('81','Ricardo','Kishna','attaccante');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('82','Moritz','Leitner','centrocampista');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('83','Cristiano','Lombardi','attaccante');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('84','Alberto Romero','Luis','attaccante');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('85','Jordan','Lukaku','difensore');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('86','Senad','Lulic','centrocampista');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('87','Federico','Marchetti','portiere');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('88','Sergej','Milinkovic-Savic','centrocampista');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('89','Joseph Marie','Minala','centrocampista');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('90','Ravel Ryan','Morrison','centrocampista');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('91','Alessandro','Murgia','centrocampista');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('92','Marco','Parolo','centrocampista');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('93','Gabarron Gil','Patric','difensore');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('94','Gianluca','Pollace','difensore');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('95','Stefan','Radu','difensore');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('96','Alessandro','Rossi','attaccante');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('97','Thomas','Strakosha','portiere');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('98','Mamadou','Tounkara','attaccante');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('99','Ivan','Vargic','portiere');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('100','Freitas Ribeiro','Vinicius','centrocampista');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('101','Fortuna Dos Santos','Wallace','difensore');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('102','Rams고Becker','Alisson','portiere');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('103','Lorenzo','Crisanto','portiere');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('104','Daniele','De Rossi','centrocampista');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('105','Eros','De Santis','difensore');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('106','Edin','Dzeko','attaccante');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('107','Stephan','El Shaarawy','attaccante');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('108','Palmieri','Emerson','difensore');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('109','Federico Julian','Fazio','difensore');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('110','Alessandro','Florenzi','centrocampista');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('111','Santos Da Silva','Gerson','centrocampista');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('112','Lorenzo','Grossi','difensore');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('113','Guilherme','Juan Jesus','difensore');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('114','Bogdan','Lobont','portiere');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('115','Kostas','Manolas','difensore');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('116','Riccardo','Marchizza','difensore');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('117','Duarte','Mario Rui','difensore');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('118','Radja','Nainggolan','centrocampista');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('119','Abdullahi','Nura','difensore');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('120','Leandro','Paredes','centrocampista');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('121','Bruno Da Silva','Peres','centrocampista');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('122','Diego','Perotti','attaccante');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('123','Andrea','Romagnoli','portiere');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('124','Antonio','Rudiger','difensore');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('125','Mohamed','Salah','attaccante');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('126','Moustapha','Seck','difensore');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('127','Edoardo','Soleri','attaccante');
Insert into ANDREA.GIOCATORE (IDGIOCATORE,NOME,COGNOME,RUOLO) values ('128','Kevin','Strootman','centrocampista');
REM INSERTING into ANDREA.INCONTRI
SET DEFINE OFF;
Insert into ANDREA.INCONTRI (IDPARTITA,IDSQ1,IDSQ2) values ('1','1','2');
Insert into ANDREA.INCONTRI (IDPARTITA,IDSQ1,IDSQ2) values ('3','3','1');
Insert into ANDREA.INCONTRI (IDPARTITA,IDSQ1,IDSQ2) values ('2','2','1');
Insert into ANDREA.INCONTRI (IDPARTITA,IDSQ1,IDSQ2) values ('4','1','3');
Insert into ANDREA.INCONTRI (IDPARTITA,IDSQ1,IDSQ2) values ('5','2','3');
Insert into ANDREA.INCONTRI (IDPARTITA,IDSQ1,IDSQ2) values ('6','3','4');
Insert into ANDREA.INCONTRI (IDPARTITA,IDSQ1,IDSQ2) values ('7','4','3');
Insert into ANDREA.INCONTRI (IDPARTITA,IDSQ1,IDSQ2) values ('8','3','2');
Insert into ANDREA.INCONTRI (IDPARTITA,IDSQ1,IDSQ2) values ('9','1','4');
Insert into ANDREA.INCONTRI (IDPARTITA,IDSQ1,IDSQ2) values ('10','4','1');
Insert into ANDREA.INCONTRI (IDPARTITA,IDSQ1,IDSQ2) values ('11','2','4');
Insert into ANDREA.INCONTRI (IDPARTITA,IDSQ1,IDSQ2) values ('12','4','2');
Insert into ANDREA.INCONTRI (IDPARTITA,IDSQ1,IDSQ2) values ('13','1','2');
REM INSERTING into ANDREA.PARTECIPANTI_ELIMINAZIONE
SET DEFINE OFF;
REM INSERTING into ANDREA.PARTECIPANTI_GIRONI
SET DEFINE OFF;
Insert into ANDREA.PARTECIPANTI_GIRONI (IDTORNEOG,IDSQUADRA) values ('1','3');
Insert into ANDREA.PARTECIPANTI_GIRONI (IDTORNEOG,IDSQUADRA) values ('1','1');
Insert into ANDREA.PARTECIPANTI_GIRONI (IDTORNEOG,IDSQUADRA) values ('1','4');
Insert into ANDREA.PARTECIPANTI_GIRONI (IDTORNEOG,IDSQUADRA) values ('2','1');
Insert into ANDREA.PARTECIPANTI_GIRONI (IDTORNEOG,IDSQUADRA) values ('1','2');
Insert into ANDREA.PARTECIPANTI_GIRONI (IDTORNEOG,IDSQUADRA) values ('2','2');
REM INSERTING into ANDREA.PARTITA
SET DEFINE OFF;
Insert into ANDREA.PARTITA (IDPARTITA,IDTORNEOG,IDTORNEOE,IDSQ1,IDSQ2,NUMERO_TURNO_TORNEO,STADIO,DATA) values ('1','1',null,'1','2',null,'San Paolo',to_date('01-MAR-16','DD-MON-RR'));
Insert into ANDREA.PARTITA (IDPARTITA,IDTORNEOG,IDTORNEOE,IDSQ1,IDSQ2,NUMERO_TURNO_TORNEO,STADIO,DATA) values ('3','1',null,'3','1',null,'Stadio Olimpico',to_date('28-FEB-16','DD-MON-RR'));
Insert into ANDREA.PARTITA (IDPARTITA,IDTORNEOG,IDTORNEOE,IDSQ1,IDSQ2,NUMERO_TURNO_TORNEO,STADIO,DATA) values ('2','1',null,'2','1',null,'Juventus Stadium',to_date('16-FEB-16','DD-MON-RR'));
Insert into ANDREA.PARTITA (IDPARTITA,IDTORNEOG,IDTORNEOE,IDSQ1,IDSQ2,NUMERO_TURNO_TORNEO,STADIO,DATA) values ('4','1',null,'1','3',null,'San Paolo',to_date('15-MAR-16','DD-MON-RR'));
Insert into ANDREA.PARTITA (IDPARTITA,IDTORNEOG,IDTORNEOE,IDSQ1,IDSQ2,NUMERO_TURNO_TORNEO,STADIO,DATA) values ('5','1',null,'2','3',null,'Juventus Stadium',to_date('25-MAR-16','DD-MON-RR'));
Insert into ANDREA.PARTITA (IDPARTITA,IDTORNEOG,IDTORNEOE,IDSQ1,IDSQ2,NUMERO_TURNO_TORNEO,STADIO,DATA) values ('6','1',null,'3','4',null,'Stadio Olimpico',to_date('01-APR-16','DD-MON-RR'));
Insert into ANDREA.PARTITA (IDPARTITA,IDTORNEOG,IDTORNEOE,IDSQ1,IDSQ2,NUMERO_TURNO_TORNEO,STADIO,DATA) values ('7','1',null,'4','3',null,'Stadio Olimpico',to_date('10-APR-16','DD-MON-RR'));
Insert into ANDREA.PARTITA (IDPARTITA,IDTORNEOG,IDTORNEOE,IDSQ1,IDSQ2,NUMERO_TURNO_TORNEO,STADIO,DATA) values ('8','1',null,'3','2',null,'Stadio Olimpico',to_date('16-APR-16','DD-MON-RR'));
Insert into ANDREA.PARTITA (IDPARTITA,IDTORNEOG,IDTORNEOE,IDSQ1,IDSQ2,NUMERO_TURNO_TORNEO,STADIO,DATA) values ('9','1',null,'1','4',null,'San Paolo',to_date('27-APR-16','DD-MON-RR'));
Insert into ANDREA.PARTITA (IDPARTITA,IDTORNEOG,IDTORNEOE,IDSQ1,IDSQ2,NUMERO_TURNO_TORNEO,STADIO,DATA) values ('10','1',null,'4','1',null,'Stadio Olimpico',to_date('27-APR-16','DD-MON-RR'));
Insert into ANDREA.PARTITA (IDPARTITA,IDTORNEOG,IDTORNEOE,IDSQ1,IDSQ2,NUMERO_TURNO_TORNEO,STADIO,DATA) values ('11','1',null,'2','4',null,'Juventus Stadium',to_date('30-APR-16','DD-MON-RR'));
Insert into ANDREA.PARTITA (IDPARTITA,IDTORNEOG,IDTORNEOE,IDSQ1,IDSQ2,NUMERO_TURNO_TORNEO,STADIO,DATA) values ('12','1',null,'4','2',null,'Stadio Olimpico',to_date('10-MAG-16','DD-MON-RR'));
Insert into ANDREA.PARTITA (IDPARTITA,IDTORNEOG,IDTORNEOE,IDSQ1,IDSQ2,NUMERO_TURNO_TORNEO,STADIO,DATA) values ('13','2',null,'1','2',null,'EF',to_date('02-GEN-17','DD-MON-RR'));
REM INSERTING into ANDREA.SQUADRA
SET DEFINE OFF;
Insert into ANDREA.SQUADRA (IDSQUADRA,NOME,TIPO) values ('1','Napoli','club');
Insert into ANDREA.SQUADRA (IDSQUADRA,NOME,TIPO) values ('3','Roma','club');
Insert into ANDREA.SQUADRA (IDSQUADRA,NOME,TIPO) values ('4','Lazio','club');
Insert into ANDREA.SQUADRA (IDSQUADRA,NOME,TIPO) values ('2','Juventus','club');
REM INSERTING into ANDREA.SQUADRA_GIOCATORI
SET DEFINE OFF;
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('1','1');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('1','2');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('1','3');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('1','4');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('1','5');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('1','6');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('1','7');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('1','8');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('1','9');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('1','10');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('1','11');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('1','12');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('1','13');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('1','14');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('1','15');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('1','16');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('1','17');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('1','18');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('1','19');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('1','20');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('1','21');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('1','22');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('1','23');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('1','24');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('1','25');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('1','26');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('1','27');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('1','28');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('1','29');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('1','30');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('2','31');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('2','32');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('2','33');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('2','34');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('2','35');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('2','36');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('2','37');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('2','38');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('2','39');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('2','40');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('2','41');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('2','42');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('2','43');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('2','44');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('2','45');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('2','46');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('2','47');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('2','48');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('2','49');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('2','50');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('2','51');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('2','52');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('2','53');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('2','54');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('2','55');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('2','56');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('2','57');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('2','58');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('2','59');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('2','60');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('2','61');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('2','62');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('2','63');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('2','64');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('2','65');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('2','66');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('2','67');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('4','68');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('4','69');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('4','70');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('4','71');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('4','72');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('4','73');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('4','74');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('4','75');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('4','76');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('4','77');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('4','78');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('4','79');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('4','80');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('4','81');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('4','82');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('4','83');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('4','84');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('4','85');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('4','86');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('4','87');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('4','88');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('4','89');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('4','90');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('4','91');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('4','92');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('4','93');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('4','94');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('4','95');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('4','96');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('4','97');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('4','98');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('4','99');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('4','100');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('4','101');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('3','102');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('3','103');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('3','104');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('3','105');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('3','106');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('3','107');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('3','108');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('3','109');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('3','110');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('3','111');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('3','112');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('3','113');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('3','114');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('3','115');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('3','116');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('3','117');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('3','118');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('3','119');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('3','120');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('3','121');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('3','122');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('3','123');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('3','124');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('3','125');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('3','126');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('3','127');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('3','128');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('3','129');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('3','130');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('3','131');
Insert into ANDREA.SQUADRA_GIOCATORI (IDSQUADRA,IDGIOCATORE) values ('3','132');
REM INSERTING into ANDREA.STAFF
SET DEFINE OFF;
REM INSERTING into ANDREA.TORNEO_ELIMINAZIONE
SET DEFINE OFF;
REM INSERTING into ANDREA.TORNEO_GIRONI
SET DEFINE OFF;
Insert into ANDREA.TORNEO_GIRONI (IDTORNEOG,STAGIONEG,NOMETORNEOG) values ('1','2016     ','Torneo A');
Insert into ANDREA.TORNEO_GIRONI (IDTORNEOG,STAGIONEG,NOMETORNEOG) values ('2','2016     ','tORNEO pROVA');
REM INSERTING into ANDREA.ASSIST_INDIVIDUALI
SET DEFINE OFF;
Insert into ANDREA.ASSIST_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,ASSIST) values ('21','Arkadiusz','Milik','2');
Insert into ANDREA.ASSIST_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,ASSIST) values ('2','Marques Loureiro','Allan','1');
Insert into ANDREA.ASSIST_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,ASSIST) values ('41','Juan Guillermo','Cuadrado','1');
Insert into ANDREA.ASSIST_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,ASSIST) values ('8','Faouzi','Ghoulam','1');
Insert into ANDREA.ASSIST_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,ASSIST) values ('43','Paolo','De Ceglie','1');
REM INSERTING into ANDREA.ASSIST_PARTITA
SET DEFINE OFF;
Insert into ANDREA.ASSIST_PARTITA (IDGIOCATORE,IDPARTITA,NOME,COGNOME,SQUADRA,ASSIST) values ('8','2','Faouzi','Ghoulam','Napoli','1');
Insert into ANDREA.ASSIST_PARTITA (IDGIOCATORE,IDPARTITA,NOME,COGNOME,SQUADRA,ASSIST) values ('21','2','Arkadiusz','Milik','Napoli','1');
Insert into ANDREA.ASSIST_PARTITA (IDGIOCATORE,IDPARTITA,NOME,COGNOME,SQUADRA,ASSIST) values ('2','1','Marques Loureiro','Allan','Napoli','1');
Insert into ANDREA.ASSIST_PARTITA (IDGIOCATORE,IDPARTITA,NOME,COGNOME,SQUADRA,ASSIST) values ('41','2','Juan Guillermo','Cuadrado','Juventus','1');
Insert into ANDREA.ASSIST_PARTITA (IDGIOCATORE,IDPARTITA,NOME,COGNOME,SQUADRA,ASSIST) values ('43','1','Paolo','De Ceglie','Juventus','1');
Insert into ANDREA.ASSIST_PARTITA (IDGIOCATORE,IDPARTITA,NOME,COGNOME,SQUADRA,ASSIST) values ('21','1','Arkadiusz','Milik','Napoli','1');
REM INSERTING into ANDREA.CARDG_INDIVIDUALI
SET DEFINE OFF;
Insert into ANDREA.CARDG_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,AMMONIZIONI) values ('95','Stefan','Radu','1');
Insert into ANDREA.CARDG_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,AMMONIZIONI) values ('2','Marques Loureiro','Allan','1');
Insert into ANDREA.CARDG_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,AMMONIZIONI) values ('122','Diego','Perotti','1');
Insert into ANDREA.CARDG_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,AMMONIZIONI) values ('107','Stephan','El Shaarawy','3');
Insert into ANDREA.CARDG_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,AMMONIZIONI) values ('110','Alessandro','Florenzi','1');
REM INSERTING into ANDREA.CARDR_INDIVIDUALI
SET DEFINE OFF;
Insert into ANDREA.CARDR_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,ESPULSIONI) values ('70','Dusan','Basta','1');
Insert into ANDREA.CARDR_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,ESPULSIONI) values ('122','Diego','Perotti','1');
REM INSERTING into ANDREA.FALLI_INDIVIDUALI
SET DEFINE OFF;
REM INSERTING into ANDREA.FUORIGIOCO_INDIVIDUALI
SET DEFINE OFF;
Insert into ANDREA.FUORIGIOCO_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,FUORIGIOCO) values ('107','Stephan','El Shaarawy','1');
REM INSERTING into ANDREA.GOAL_INDIVIDUALI
SET DEFINE OFF;
Insert into ANDREA.GOAL_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,GOAL) values ('21','Arkadiusz','Milik','3');
Insert into ANDREA.GOAL_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,GOAL) values ('62','Miralem','Pjanic','2');
Insert into ANDREA.GOAL_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,GOAL) values ('88','Sergej','Milinkovic-Savic','1');
Insert into ANDREA.GOAL_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,GOAL) values ('101','Fortuna Dos Santos','Wallace','1');
Insert into ANDREA.GOAL_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,GOAL) values ('118','Radja','Nainggolan','1');
Insert into ANDREA.GOAL_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,GOAL) values ('41','Juan Guillermo','Cuadrado','1');
Insert into ANDREA.GOAL_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,GOAL) values ('48','Gonzalo','Higuain','2');
Insert into ANDREA.GOAL_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,GOAL) values ('76','Alvaro','Gonzalez','1');
Insert into ANDREA.GOAL_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,GOAL) values ('78','Ciro','Immobile','1');
Insert into ANDREA.GOAL_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,GOAL) values ('122','Diego','Perotti','1');
Insert into ANDREA.GOAL_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,GOAL) values ('11','Marek','Hamsik','1');
Insert into ANDREA.GOAL_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,GOAL) values ('20','Dries','Mertens','11');
Insert into ANDREA.GOAL_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,GOAL) values ('38','Giorgio','Chiellini','2');
Insert into ANDREA.GOAL_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,GOAL) values ('107','Stephan','El Shaarawy','3');
Insert into ANDREA.GOAL_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,GOAL) values ('30','Piotr','Zielinski','1');
Insert into ANDREA.GOAL_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,GOAL) values ('110','Alessandro','Florenzi','2');
Insert into ANDREA.GOAL_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,GOAL) values ('130','Francesco','Totti','1');
Insert into ANDREA.GOAL_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,GOAL) values ('7','Manolo','Gabbiadini','1');
Insert into ANDREA.GOAL_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,GOAL) values ('14','Luiz','Jorginho','1');
REM INSERTING into ANDREA.GOAL_PARTITA
SET DEFINE OFF;
Insert into ANDREA.GOAL_PARTITA (IDGIOCATORE,IDPARTITA,NOME,COGNOME,SQUADRA,GOAL) values ('30','9','Piotr','Zielinski','Napoli','1');
Insert into ANDREA.GOAL_PARTITA (IDGIOCATORE,IDPARTITA,NOME,COGNOME,SQUADRA,GOAL) values ('21','2','Arkadiusz','Milik','Napoli','2');
Insert into ANDREA.GOAL_PARTITA (IDGIOCATORE,IDPARTITA,NOME,COGNOME,SQUADRA,GOAL) values ('20','4','Dries','Mertens','Napoli','2');
Insert into ANDREA.GOAL_PARTITA (IDGIOCATORE,IDPARTITA,NOME,COGNOME,SQUADRA,GOAL) values ('20','3','Dries','Mertens','Napoli','3');
Insert into ANDREA.GOAL_PARTITA (IDGIOCATORE,IDPARTITA,NOME,COGNOME,SQUADRA,GOAL) values ('14','1','Luiz','Jorginho','Napoli','1');
Insert into ANDREA.GOAL_PARTITA (IDGIOCATORE,IDPARTITA,NOME,COGNOME,SQUADRA,GOAL) values ('122','4','Diego','Perotti','Roma','1');
Insert into ANDREA.GOAL_PARTITA (IDGIOCATORE,IDPARTITA,NOME,COGNOME,SQUADRA,GOAL) values ('118','3','Radja','Nainggolan','Roma','1');
Insert into ANDREA.GOAL_PARTITA (IDGIOCATORE,IDPARTITA,NOME,COGNOME,SQUADRA,GOAL) values ('41','5','Juan Guillermo','Cuadrado','Juventus','1');
Insert into ANDREA.GOAL_PARTITA (IDGIOCATORE,IDPARTITA,NOME,COGNOME,SQUADRA,GOAL) values ('20','13','Dries','Mertens','Napoli','1');
Insert into ANDREA.GOAL_PARTITA (IDGIOCATORE,IDPARTITA,NOME,COGNOME,SQUADRA,GOAL) values ('7','1','Manolo','Gabbiadini','Napoli','1');
Insert into ANDREA.GOAL_PARTITA (IDGIOCATORE,IDPARTITA,NOME,COGNOME,SQUADRA,GOAL) values ('130','3','Francesco','Totti','Roma','1');
Insert into ANDREA.GOAL_PARTITA (IDGIOCATORE,IDPARTITA,NOME,COGNOME,SQUADRA,GOAL) values ('107','4','Stephan','El Shaarawy','Roma','1');
Insert into ANDREA.GOAL_PARTITA (IDGIOCATORE,IDPARTITA,NOME,COGNOME,SQUADRA,GOAL) values ('78','12','Ciro','Immobile','Lazio','1');
Insert into ANDREA.GOAL_PARTITA (IDGIOCATORE,IDPARTITA,NOME,COGNOME,SQUADRA,GOAL) values ('48','2','Gonzalo','Higuain','Juventus','1');
Insert into ANDREA.GOAL_PARTITA (IDGIOCATORE,IDPARTITA,NOME,COGNOME,SQUADRA,GOAL) values ('38','11','Giorgio','Chiellini','Juventus','1');
Insert into ANDREA.GOAL_PARTITA (IDGIOCATORE,IDPARTITA,NOME,COGNOME,SQUADRA,GOAL) values ('21','3','Arkadiusz','Milik','Napoli','1');
Insert into ANDREA.GOAL_PARTITA (IDGIOCATORE,IDPARTITA,NOME,COGNOME,SQUADRA,GOAL) values ('11','2','Marek','Hamsik','Napoli','1');
Insert into ANDREA.GOAL_PARTITA (IDGIOCATORE,IDPARTITA,NOME,COGNOME,SQUADRA,GOAL) values ('110','4','Alessandro','Florenzi','Roma','1');
Insert into ANDREA.GOAL_PARTITA (IDGIOCATORE,IDPARTITA,NOME,COGNOME,SQUADRA,GOAL) values ('107','7','Stephan','El Shaarawy','Roma','1');
Insert into ANDREA.GOAL_PARTITA (IDGIOCATORE,IDPARTITA,NOME,COGNOME,SQUADRA,GOAL) values ('88','11','Sergej','Milinkovic-Savic','Lazio','1');
Insert into ANDREA.GOAL_PARTITA (IDGIOCATORE,IDPARTITA,NOME,COGNOME,SQUADRA,GOAL) values ('62','1','Miralem','Pjanic','Juventus','1');
Insert into ANDREA.GOAL_PARTITA (IDGIOCATORE,IDPARTITA,NOME,COGNOME,SQUADRA,GOAL) values ('62','2','Miralem','Pjanic','Juventus','1');
Insert into ANDREA.GOAL_PARTITA (IDGIOCATORE,IDPARTITA,NOME,COGNOME,SQUADRA,GOAL) values ('48','5','Gonzalo','Higuain','Juventus','1');
Insert into ANDREA.GOAL_PARTITA (IDGIOCATORE,IDPARTITA,NOME,COGNOME,SQUADRA,GOAL) values ('20','9','Dries','Mertens','Napoli','1');
Insert into ANDREA.GOAL_PARTITA (IDGIOCATORE,IDPARTITA,NOME,COGNOME,SQUADRA,GOAL) values ('101','12','Fortuna Dos Santos','Wallace','Lazio','1');
Insert into ANDREA.GOAL_PARTITA (IDGIOCATORE,IDPARTITA,NOME,COGNOME,SQUADRA,GOAL) values ('76','9','Alvaro','Gonzalez','Lazio','1');
Insert into ANDREA.GOAL_PARTITA (IDGIOCATORE,IDPARTITA,NOME,COGNOME,SQUADRA,GOAL) values ('20','10','Dries','Mertens','Napoli','3');
Insert into ANDREA.GOAL_PARTITA (IDGIOCATORE,IDPARTITA,NOME,COGNOME,SQUADRA,GOAL) values ('20','1','Dries','Mertens','Napoli','1');
Insert into ANDREA.GOAL_PARTITA (IDGIOCATORE,IDPARTITA,NOME,COGNOME,SQUADRA,GOAL) values ('110','5','Alessandro','Florenzi','Roma','1');
Insert into ANDREA.GOAL_PARTITA (IDGIOCATORE,IDPARTITA,NOME,COGNOME,SQUADRA,GOAL) values ('107','6','Stephan','El Shaarawy','Roma','1');
Insert into ANDREA.GOAL_PARTITA (IDGIOCATORE,IDPARTITA,NOME,COGNOME,SQUADRA,GOAL) values ('38','1','Giorgio','Chiellini','Juventus','1');
REM INSERTING into ANDREA.GOAL_SQUADRA_PARTITA
SET DEFINE OFF;
Insert into ANDREA.GOAL_SQUADRA_PARTITA (IDSQUADRA,SQUADRA,IDPARTITA,GOAL) values ('1','Napoli','3','4');
Insert into ANDREA.GOAL_SQUADRA_PARTITA (IDSQUADRA,SQUADRA,IDPARTITA,GOAL) values ('2','Juventus','2','2');
Insert into ANDREA.GOAL_SQUADRA_PARTITA (IDSQUADRA,SQUADRA,IDPARTITA,GOAL) values ('1','Napoli','9','2');
Insert into ANDREA.GOAL_SQUADRA_PARTITA (IDSQUADRA,SQUADRA,IDPARTITA,GOAL) values ('2','Juventus','1','2');
Insert into ANDREA.GOAL_SQUADRA_PARTITA (IDSQUADRA,SQUADRA,IDPARTITA,GOAL) values ('4','Lazio','12','2');
Insert into ANDREA.GOAL_SQUADRA_PARTITA (IDSQUADRA,SQUADRA,IDPARTITA,GOAL) values ('1','Napoli','1','3');
Insert into ANDREA.GOAL_SQUADRA_PARTITA (IDSQUADRA,SQUADRA,IDPARTITA,GOAL) values ('1','Napoli','10','3');
Insert into ANDREA.GOAL_SQUADRA_PARTITA (IDSQUADRA,SQUADRA,IDPARTITA,GOAL) values ('1','Napoli','13','1');
Insert into ANDREA.GOAL_SQUADRA_PARTITA (IDSQUADRA,SQUADRA,IDPARTITA,GOAL) values ('2','Juventus','11','1');
Insert into ANDREA.GOAL_SQUADRA_PARTITA (IDSQUADRA,SQUADRA,IDPARTITA,GOAL) values ('1','Napoli','2','3');
Insert into ANDREA.GOAL_SQUADRA_PARTITA (IDSQUADRA,SQUADRA,IDPARTITA,GOAL) values ('4','Lazio','11','1');
Insert into ANDREA.GOAL_SQUADRA_PARTITA (IDSQUADRA,SQUADRA,IDPARTITA,GOAL) values ('2','Juventus','5','2');
Insert into ANDREA.GOAL_SQUADRA_PARTITA (IDSQUADRA,SQUADRA,IDPARTITA,GOAL) values ('3','Roma','3','2');
Insert into ANDREA.GOAL_SQUADRA_PARTITA (IDSQUADRA,SQUADRA,IDPARTITA,GOAL) values ('4','Lazio','9','1');
Insert into ANDREA.GOAL_SQUADRA_PARTITA (IDSQUADRA,SQUADRA,IDPARTITA,GOAL) values ('1','Napoli','4','2');
Insert into ANDREA.GOAL_SQUADRA_PARTITA (IDSQUADRA,SQUADRA,IDPARTITA,GOAL) values ('3','Roma','6','1');
Insert into ANDREA.GOAL_SQUADRA_PARTITA (IDSQUADRA,SQUADRA,IDPARTITA,GOAL) values ('3','Roma','5','1');
Insert into ANDREA.GOAL_SQUADRA_PARTITA (IDSQUADRA,SQUADRA,IDPARTITA,GOAL) values ('3','Roma','4','3');
Insert into ANDREA.GOAL_SQUADRA_PARTITA (IDSQUADRA,SQUADRA,IDPARTITA,GOAL) values ('3','Roma','7','1');
REM INSERTING into ANDREA.STAT_INDIVIDUALI
SET DEFINE OFF;
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('107','Stephan','El Shaarawy','3','Roma','3','1','0','3','0','1','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('121','Bruno Da Silva','Peres','3','Roma','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('86','Senad','Lulic','4','Lazio','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('41','Juan Guillermo','Cuadrado','2','Juventus','1','0','0','0','0','0','1','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('104','Daniele','De Rossi','3','Roma','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('28','Ivan','Strinic','1','Napoli','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('76','Alvaro','Gonzalez','4','Lazio','1','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('99','Ivan','Vargic','4','Lazio','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('25','Pepe','Reina','1','Napoli','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('90','Ravel Ryan','Morrison','4','Lazio','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('31','Sandro Lobo Silva','Alex','2','Juventus','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('103','Lorenzo','Crisanto','3','Roma','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('119','Abdullahi','Nura','3','Roma','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('32','Kwadwo','Asamoah','2','Juventus','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('89','Joseph Marie','Minala','4','Lazio','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('16','Igor','Lasicki','1','Napoli','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('33','Emil','Audero','2','Juventus','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('20','Dries','Mertens','1','Napoli','11','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('57','Mario','Mandzukic','2','Juventus','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('6','Omar','El Kaddouri','1','Napoli','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('126','Moustapha','Seck','3','Roma','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('27','Luigi','Sepe','1','Napoli','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('125','Mohamed','Salah','3','Roma','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('61','Marko','Pjaca','2','Juventus','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('60','Murara Norberto','Neto','2','Juventus','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('77','Wesley','Hoedt','4','Lazio','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('3','Jose Maria','Callejon','1','Napoli','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('101','Fortuna Dos Santos','Wallace','4','Lazio','1','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('82','Moritz','Leitner','4','Lazio','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('123','Andrea','Romagnoli','3','Roma','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('65','Alessandro','Semprini','2','Juventus','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('21','Arkadiusz','Milik','1','Napoli','3','0','0','0','0','0','2','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('10','Antonio','Granata','1','Napoli','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('129','Wojciech','Szczesny','3','Roma','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('79','Duje','Javorcic','4','Lazio','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('95','Stefan','Radu','4','Lazio','0','0','0','1','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('105','Eros','De Santis','3','Roma','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('23','Leonardo','Pavoletti','1','Napoli','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('73','Luca','Borrelli','4','Lazio','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('68','Marius','Adamonis','4','Lazio','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('116','Riccardo','Marchizza','3','Roma','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('115','Kostas','Manolas','3','Roma','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('37','Gianluigi','Buffon','2','Juventus','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('85','Jordan','Lukaku','4','Lazio','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('53','Stephan','Lichtsteiner','2','Juventus','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('59','Federico','Mattiello','2','Juventus','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('88','Sergej','Milinkovic-Savic','4','Lazio','1','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('17','Henrique do Nascimento ','Leandrinho','1','Napoli','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('52','Mario','Lemina','2','Juventus','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('63','Tomas','Rincon','2','Juventus','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('45','Paulo','Dybala','2','Juventus','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('108','Palmieri','Emerson','3','Roma','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('14','Luiz','Jorginho','1','Napoli','1','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('120','Leandro','Paredes','3','Roma','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('9','Emanuele','Giaccherini','1','Napoli','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('78','Ciro','Immobile','4','Lazio','1','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('38','Giorgio','Chiellini','2','Juventus','2','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('117','Duarte','Mario Rui','3','Roma','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('22','Antonio','Negro','1','Napoli','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('43','Paolo','De Ceglie','2','Juventus','0','0','0','0','0','0','1','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('131','Marco','Tumminello','3','Roma','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('84','Alberto Romero','Luis','4','Lazio','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('44','Mattia','Del Favero','2','Juventus','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('54','Leonardo','Loria','2','Juventus','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('70','Dusan','Basta','4','Lazio','0','0','0','0','1','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('102','Rams고Becker','Alisson','3','Roma','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('49','Grigoris','Kastanos','2','Juventus','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('128','Kevin','Strootman','3','Roma','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('58','Claudio','Marchisio','2','Juventus','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('98','Mamadou','Tounkara','4','Lazio','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('24','Cabral Barbosa','Rafael','1','Napoli','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('62','Miralem','Pjanic','2','Juventus','2','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('55','Roman','Macek','2','Juventus','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('42','Da Silva','Dani Alves','2','Juventus','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('5','Amadou','Diawara','1','Napoli','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('36','Leonardo','Bonucci','2','Juventus','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('8','Faouzi','Ghoulam','1','Napoli','0','0','0','0','0','0','1','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('69','Felipe','Anderson','4','Lazio','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('80','Balde Diao','Keita','4','Lazio','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('13','Lorenzo','Insigne','1','Napoli','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('39','Luca','Clemenza','2','Juventus','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('11','Marek','Hamsik','1','Napoli','1','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('114','Bogdan','Lobont','3','Roma','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('124','Antonio','Rudiger','3','Roma','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('29','Lorenzo','Tonelli','1','Napoli','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('66','Stefano','Sturaro','2','Juventus','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('34','Andrea','Barzagli','2','Juventus','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('91','Alessandro','Murgia','4','Lazio','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('112','Lorenzo','Grossi','3','Roma','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('26','Marko','Rog','1','Napoli','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('110','Alessandro','Florenzi','3','Roma','2','0','0','1','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('15','Kalidou','Koulibaly','1','Napoli','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('75','Filip','Djordjevic','4','Lazio','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('122','Diego','Perotti','3','Roma','1','0','0','1','1','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('18','Christian','Maggio','1','Napoli','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('51','Sami','Khedira','2','Juventus','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('30','Piotr','Zielinski','1','Napoli','1','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('4','Vlad','Chiriches','1','Napoli','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('72','Lucas Rodrigo','Biglia','4','Lazio','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('92','Marco','Parolo','4','Lazio','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('109','Federico Julian','Fazio','3','Roma','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('46','Patrice','Evra','2','Juventus','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('1','Raul','Albiol','1','Napoli','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('83','Cristiano','Lombardi','4','Lazio','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('2','Marques Loureiro','Allan','1','Napoli','0','0','0','1','0','0','1','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('106','Edin','Dzeko','3','Roma','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('56','Rolando','Mandragora','2','Juventus','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('50','Moise','Kean','2','Juventus','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('118','Radja','Nainggolan','3','Roma','1','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('111','Santos Da Silva','Gerson','3','Roma','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('48','Gonzalo','Higuain','2','Juventus','2','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('64','Daniele','Rugani','2','Juventus','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('87','Federico','Marchetti','4','Lazio','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('12','Elseid','Hysaj','1','Napoli','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('19','Nikola','Maksimovic','1','Napoli','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('132','Thomas','Vermaelen','3','Roma','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('93','Gabarron Gil','Patric','4','Lazio','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('96','Alessandro','Rossi','4','Lazio','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('94','Gianluca','Pollace','4','Lazio','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('7','Manolo','Gabbiadini','1','Napoli','1','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('113','Guilherme','Juan Jesus','3','Roma','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('127','Edoardo','Soleri','3','Roma','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('130','Francesco','Totti','3','Roma','1','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('47','Anderson','Hernanes','2','Juventus','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('71','Jacinto','Bastos','4','Lazio','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('100','Freitas Ribeiro','Vinicius','4','Lazio','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('67','Alessandro','Vogliacco','2','Juventus','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('74','Stefan','De Vrij','4','Lazio','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('40','Luca','Coccolo','2','Juventus','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('35','Mehdi','Benatia','2','Juventus','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('81','Ricardo','Kishna','4','Lazio','0','0','0','0','0','0','0','0');
Insert into ANDREA.STAT_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,IDSQUADRA,SQUADRA,GOAL,TIRI,FALLI,AMMONIZIONI,ESPULSIONI,FUORIGIOCO,ASSIST,TIRIINPORTA) values ('97','Thomas','Strakosha','4','Lazio','0','0','0','0','0','0','0','0');
REM INSERTING into ANDREA.TIP_INDIVIDUALI
SET DEFINE OFF;
REM INSERTING into ANDREA.TIRI_INDIVIDUALI
SET DEFINE OFF;
Insert into ANDREA.TIRI_INDIVIDUALI (IDGIOCATORE,NOME,COGNOME,TIRI) values ('107','Stephan','El Shaarawy','1');
REM INSERTING into ANDREA.VISTA_ASSIST
SET DEFINE OFF;
Insert into ANDREA.VISTA_ASSIST (IDTORNEO,GIOCATORE,SQUADRA,ASSIST) values ('1','De Ceglie','Juventus','1');
Insert into ANDREA.VISTA_ASSIST (IDTORNEO,GIOCATORE,SQUADRA,ASSIST) values ('1','Ghoulam','Napoli','1');
Insert into ANDREA.VISTA_ASSIST (IDTORNEO,GIOCATORE,SQUADRA,ASSIST) values ('1','Cuadrado','Juventus','1');
Insert into ANDREA.VISTA_ASSIST (IDTORNEO,GIOCATORE,SQUADRA,ASSIST) values ('1','Milik','Napoli','2');
Insert into ANDREA.VISTA_ASSIST (IDTORNEO,GIOCATORE,SQUADRA,ASSIST) values ('1','Allan','Napoli','1');
REM INSERTING into ANDREA.VISTA_EVENTI
SET DEFINE OFF;
Insert into ANDREA.VISTA_EVENTI (IDPARTITA,MINUTO,SQUADRA,EVENTO,GIOCATORE) values ('4','89','Roma','Goal','El Shaarawy');
Insert into ANDREA.VISTA_EVENTI (IDPARTITA,MINUTO,SQUADRA,EVENTO,GIOCATORE) values ('4','89','Roma','CartellinoG','El Shaarawy');
Insert into ANDREA.VISTA_EVENTI (IDPARTITA,MINUTO,SQUADRA,EVENTO,GIOCATORE) values ('9','87','Napoli','Goal','Mertens');
Insert into ANDREA.VISTA_EVENTI (IDPARTITA,MINUTO,SQUADRA,EVENTO,GIOCATORE) values ('3','87','Napoli','Goal','Milik');
Insert into ANDREA.VISTA_EVENTI (IDPARTITA,MINUTO,SQUADRA,EVENTO,GIOCATORE) values ('2','80','Napoli','Assist','Ghoulam');
Insert into ANDREA.VISTA_EVENTI (IDPARTITA,MINUTO,SQUADRA,EVENTO,GIOCATORE) values ('2','80','Napoli','Goal','Milik');
Insert into ANDREA.VISTA_EVENTI (IDPARTITA,MINUTO,SQUADRA,EVENTO,GIOCATORE) values ('3','76','Napoli','Goal','Mertens');
Insert into ANDREA.VISTA_EVENTI (IDPARTITA,MINUTO,SQUADRA,EVENTO,GIOCATORE) values ('12','69','Lazio','CartellinoG','Radu');
Insert into ANDREA.VISTA_EVENTI (IDPARTITA,MINUTO,SQUADRA,EVENTO,GIOCATORE) values ('3','69','Napoli','Goal','Mertens');
Insert into ANDREA.VISTA_EVENTI (IDPARTITA,MINUTO,SQUADRA,EVENTO,GIOCATORE) values ('1','68','Napoli','Assist','Allan');
Insert into ANDREA.VISTA_EVENTI (IDPARTITA,MINUTO,SQUADRA,EVENTO,GIOCATORE) values ('1','68','Napoli','Goal','Mertens');
Insert into ANDREA.VISTA_EVENTI (IDPARTITA,MINUTO,SQUADRA,EVENTO,GIOCATORE) values ('9','65','Lazio','Goal','Gonzalez');
Insert into ANDREA.VISTA_EVENTI (IDPARTITA,MINUTO,SQUADRA,EVENTO,GIOCATORE) values ('1','65','Juventus','Assist','De Ceglie');
Insert into ANDREA.VISTA_EVENTI (IDPARTITA,MINUTO,SQUADRA,EVENTO,GIOCATORE) values ('1','65','Juventus','Goal','Chiellini');
Insert into ANDREA.VISTA_EVENTI (IDPARTITA,MINUTO,SQUADRA,EVENTO,GIOCATORE) values ('5','60','Roma','CartellinoG','Perotti');
Insert into ANDREA.VISTA_EVENTI (IDPARTITA,MINUTO,SQUADRA,EVENTO,GIOCATORE) values ('5','60','Roma','CartellinoR','Perotti');
Insert into ANDREA.VISTA_EVENTI (IDPARTITA,MINUTO,SQUADRA,EVENTO,GIOCATORE) values ('2','60','Napoli','Assist','Milik');
Insert into ANDREA.VISTA_EVENTI (IDPARTITA,MINUTO,SQUADRA,EVENTO,GIOCATORE) values ('3','60','Napoli','Goal','Mertens');
Insert into ANDREA.VISTA_EVENTI (IDPARTITA,MINUTO,SQUADRA,EVENTO,GIOCATORE) values ('5','60','Juventus','Goal','Higuain');
Insert into ANDREA.VISTA_EVENTI (IDPARTITA,MINUTO,SQUADRA,EVENTO,GIOCATORE) values ('8','60','Roma','Tiri','El Shaarawy');
Insert into ANDREA.VISTA_EVENTI (IDPARTITA,MINUTO,SQUADRA,EVENTO,GIOCATORE) values ('6','60','Roma','CartellinoG','El Shaarawy');
Insert into ANDREA.VISTA_EVENTI (IDPARTITA,MINUTO,SQUADRA,EVENTO,GIOCATORE) values ('2','60','Napoli','Goal','Hamsik');
Insert into ANDREA.VISTA_EVENTI (IDPARTITA,MINUTO,SQUADRA,EVENTO,GIOCATORE) values ('2','57','Napoli','Goal','Milik');
Insert into ANDREA.VISTA_EVENTI (IDPARTITA,MINUTO,SQUADRA,EVENTO,GIOCATORE) values ('12','56','Lazio','Goal','Wallace');
Insert into ANDREA.VISTA_EVENTI (IDPARTITA,MINUTO,SQUADRA,EVENTO,GIOCATORE) values ('4','45','Roma','Goal','Florenzi');
Insert into ANDREA.VISTA_EVENTI (IDPARTITA,MINUTO,SQUADRA,EVENTO,GIOCATORE) values ('12','45','Lazio','CartellinoR','Basta');
Insert into ANDREA.VISTA_EVENTI (IDPARTITA,MINUTO,SQUADRA,EVENTO,GIOCATORE) values ('1','45','Napoli','CartellinoG','Allan');
Insert into ANDREA.VISTA_EVENTI (IDPARTITA,MINUTO,SQUADRA,EVENTO,GIOCATORE) values ('4','40','Roma','Goal','Perotti');
Insert into ANDREA.VISTA_EVENTI (IDPARTITA,MINUTO,SQUADRA,EVENTO,GIOCATORE) values ('11','40','Juventus','Goal','Chiellini');
Insert into ANDREA.VISTA_EVENTI (IDPARTITA,MINUTO,SQUADRA,EVENTO,GIOCATORE) values ('7','40','Roma','Goal','El Shaarawy');
Insert into ANDREA.VISTA_EVENTI (IDPARTITA,MINUTO,SQUADRA,EVENTO,GIOCATORE) values ('7','40','Roma','Fuorigioco','El Shaarawy');
Insert into ANDREA.VISTA_EVENTI (IDPARTITA,MINUTO,SQUADRA,EVENTO,GIOCATORE) values ('5','39','Juventus','Goal','Cuadrado');
Insert into ANDREA.VISTA_EVENTI (IDPARTITA,MINUTO,SQUADRA,EVENTO,GIOCATORE) values ('3','38','Roma','Goal','Nainggolan');
Insert into ANDREA.VISTA_EVENTI (IDPARTITA,MINUTO,SQUADRA,EVENTO,GIOCATORE) values ('12','31','Lazio','Goal','Immobile');
Insert into ANDREA.VISTA_EVENTI (IDPARTITA,MINUTO,SQUADRA,EVENTO,GIOCATORE) values ('10','30','Napoli','Goal','Mertens');
Insert into ANDREA.VISTA_EVENTI (IDPARTITA,MINUTO,SQUADRA,EVENTO,GIOCATORE) values ('5','29','Roma','Goal','Florenzi');
Insert into ANDREA.VISTA_EVENTI (IDPARTITA,MINUTO,SQUADRA,EVENTO,GIOCATORE) values ('2','26','Juventus','Goal','Higuain');
Insert into ANDREA.VISTA_EVENTI (IDPARTITA,MINUTO,SQUADRA,EVENTO,GIOCATORE) values ('1','24','Napoli','Assist','Milik');
Insert into ANDREA.VISTA_EVENTI (IDPARTITA,MINUTO,SQUADRA,EVENTO,GIOCATORE) values ('1','24','Napoli','Goal','Gabbiadini');
Insert into ANDREA.VISTA_EVENTI (IDPARTITA,MINUTO,SQUADRA,EVENTO,GIOCATORE) values ('1','23','Juventus','Goal','Pjanic');
Insert into ANDREA.VISTA_EVENTI (IDPARTITA,MINUTO,SQUADRA,EVENTO,GIOCATORE) values ('5','23','Roma','CartellinoG','Florenzi');
Insert into ANDREA.VISTA_EVENTI (IDPARTITA,MINUTO,SQUADRA,EVENTO,GIOCATORE) values ('6','23','Roma','Goal','El Shaarawy');
Insert into ANDREA.VISTA_EVENTI (IDPARTITA,MINUTO,SQUADRA,EVENTO,GIOCATORE) values ('4','21','Napoli','Goal','Mertens');
Insert into ANDREA.VISTA_EVENTI (IDPARTITA,MINUTO,SQUADRA,EVENTO,GIOCATORE) values ('9','21','Napoli','Goal','Zielinski');
Insert into ANDREA.VISTA_EVENTI (IDPARTITA,MINUTO,SQUADRA,EVENTO,GIOCATORE) values ('8','21','Roma','CartellinoG','El Shaarawy');
Insert into ANDREA.VISTA_EVENTI (IDPARTITA,MINUTO,SQUADRA,EVENTO,GIOCATORE) values ('10','21','Napoli','Goal','Mertens');
Insert into ANDREA.VISTA_EVENTI (IDPARTITA,MINUTO,SQUADRA,EVENTO,GIOCATORE) values ('10','16','Napoli','Goal','Mertens');
Insert into ANDREA.VISTA_EVENTI (IDPARTITA,MINUTO,SQUADRA,EVENTO,GIOCATORE) values ('2','13','Juventus','Assist','Cuadrado');
Insert into ANDREA.VISTA_EVENTI (IDPARTITA,MINUTO,SQUADRA,EVENTO,GIOCATORE) values ('2','13','Juventus','Goal','Pjanic');
Insert into ANDREA.VISTA_EVENTI (IDPARTITA,MINUTO,SQUADRA,EVENTO,GIOCATORE) values ('4','12','Napoli','Goal','Mertens');
Insert into ANDREA.VISTA_EVENTI (IDPARTITA,MINUTO,SQUADRA,EVENTO,GIOCATORE) values ('3','12','Roma','Goal','Totti');
Insert into ANDREA.VISTA_EVENTI (IDPARTITA,MINUTO,SQUADRA,EVENTO,GIOCATORE) values ('1','2','Napoli','Goal','Jorginho');
Insert into ANDREA.VISTA_EVENTI (IDPARTITA,MINUTO,SQUADRA,EVENTO,GIOCATORE) values ('13','1','Napoli','Goal','Mertens');
Insert into ANDREA.VISTA_EVENTI (IDPARTITA,MINUTO,SQUADRA,EVENTO,GIOCATORE) values ('11','1','Lazio','Goal','Milinkovic-Savic');
REM INSERTING into ANDREA.VISTA_MARCATORI
SET DEFINE OFF;
Insert into ANDREA.VISTA_MARCATORI (IDTORNEO,GIOCATORE,SQUADRA,GOAL) values ('1','Gabbiadini','Napoli','1');
Insert into ANDREA.VISTA_MARCATORI (IDTORNEO,GIOCATORE,SQUADRA,GOAL) values ('1','Nainggolan','Roma','1');
Insert into ANDREA.VISTA_MARCATORI (IDTORNEO,GIOCATORE,SQUADRA,GOAL) values ('1','Hamsik','Napoli','1');
Insert into ANDREA.VISTA_MARCATORI (IDTORNEO,GIOCATORE,SQUADRA,GOAL) values ('1','Milinkovic-Savic','Lazio','1');
Insert into ANDREA.VISTA_MARCATORI (IDTORNEO,GIOCATORE,SQUADRA,GOAL) values ('1','Jorginho','Napoli','1');
Insert into ANDREA.VISTA_MARCATORI (IDTORNEO,GIOCATORE,SQUADRA,GOAL) values ('1','Perotti','Roma','1');
Insert into ANDREA.VISTA_MARCATORI (IDTORNEO,GIOCATORE,SQUADRA,GOAL) values ('1','Gonzalez','Lazio','1');
Insert into ANDREA.VISTA_MARCATORI (IDTORNEO,GIOCATORE,SQUADRA,GOAL) values ('1','Wallace','Lazio','1');
Insert into ANDREA.VISTA_MARCATORI (IDTORNEO,GIOCATORE,SQUADRA,GOAL) values ('1','Cuadrado','Juventus','1');
Insert into ANDREA.VISTA_MARCATORI (IDTORNEO,GIOCATORE,SQUADRA,GOAL) values ('1','Immobile','Lazio','1');
Insert into ANDREA.VISTA_MARCATORI (IDTORNEO,GIOCATORE,SQUADRA,GOAL) values ('1','Totti','Roma','1');
Insert into ANDREA.VISTA_MARCATORI (IDTORNEO,GIOCATORE,SQUADRA,GOAL) values ('1','Zielinski','Napoli','1');
Insert into ANDREA.VISTA_MARCATORI (IDTORNEO,GIOCATORE,SQUADRA,GOAL) values ('1','Milik','Napoli','3');
Insert into ANDREA.VISTA_MARCATORI (IDTORNEO,GIOCATORE,SQUADRA,GOAL) values ('1','Higuain','Juventus','2');
Insert into ANDREA.VISTA_MARCATORI (IDTORNEO,GIOCATORE,SQUADRA,GOAL) values ('1','Florenzi','Roma','2');
Insert into ANDREA.VISTA_MARCATORI (IDTORNEO,GIOCATORE,SQUADRA,GOAL) values ('2','Mertens','Napoli','1');
Insert into ANDREA.VISTA_MARCATORI (IDTORNEO,GIOCATORE,SQUADRA,GOAL) values ('1','Pjanic','Juventus','2');
Insert into ANDREA.VISTA_MARCATORI (IDTORNEO,GIOCATORE,SQUADRA,GOAL) values ('1','Mertens','Napoli','10');
Insert into ANDREA.VISTA_MARCATORI (IDTORNEO,GIOCATORE,SQUADRA,GOAL) values ('1','Chiellini','Juventus','2');
Insert into ANDREA.VISTA_MARCATORI (IDTORNEO,GIOCATORE,SQUADRA,GOAL) values ('1','El Shaarawy','Roma','3');
REM INSERTING into ANDREA.VISTA_RIS_PARTITE
SET DEFINE OFF;
Insert into ANDREA.VISTA_RIS_PARTITE (IDPARTITA,IDSQ1,SQUADRA1,GOL1,GOL2,SQUADRA2,IDSQ2,"PG.IDTORNEOG","PE.IDTORNEOE") values ('7','4','Lazio','0','1','Roma','3','1',null);
Insert into ANDREA.VISTA_RIS_PARTITE (IDPARTITA,IDSQ1,SQUADRA1,GOL1,GOL2,SQUADRA2,IDSQ2,"PG.IDTORNEOG","PE.IDTORNEOE") values ('6','3','Roma','1','0','Lazio','4','1',null);
Insert into ANDREA.VISTA_RIS_PARTITE (IDPARTITA,IDSQ1,SQUADRA1,GOL1,GOL2,SQUADRA2,IDSQ2,"PG.IDTORNEOG","PE.IDTORNEOE") values ('8','3','Roma','0','0','Juventus','2','1',null);
Insert into ANDREA.VISTA_RIS_PARTITE (IDPARTITA,IDSQ1,SQUADRA1,GOL1,GOL2,SQUADRA2,IDSQ2,"PG.IDTORNEOG","PE.IDTORNEOE") values ('2','2','Juventus','2','3','Napoli','1','1',null);
Insert into ANDREA.VISTA_RIS_PARTITE (IDPARTITA,IDSQ1,SQUADRA1,GOL1,GOL2,SQUADRA2,IDSQ2,"PG.IDTORNEOG","PE.IDTORNEOE") values ('4','1','Napoli','2','3','Roma','3','1',null);
Insert into ANDREA.VISTA_RIS_PARTITE (IDPARTITA,IDSQ1,SQUADRA1,GOL1,GOL2,SQUADRA2,IDSQ2,"PG.IDTORNEOG","PE.IDTORNEOE") values ('13','1','Napoli','1','0','Juventus','2','2',null);
Insert into ANDREA.VISTA_RIS_PARTITE (IDPARTITA,IDSQ1,SQUADRA1,GOL1,GOL2,SQUADRA2,IDSQ2,"PG.IDTORNEOG","PE.IDTORNEOE") values ('12','4','Lazio','2','0','Juventus','2','1',null);
Insert into ANDREA.VISTA_RIS_PARTITE (IDPARTITA,IDSQ1,SQUADRA1,GOL1,GOL2,SQUADRA2,IDSQ2,"PG.IDTORNEOG","PE.IDTORNEOE") values ('10','4','Lazio','0','3','Napoli','1','1',null);
Insert into ANDREA.VISTA_RIS_PARTITE (IDPARTITA,IDSQ1,SQUADRA1,GOL1,GOL2,SQUADRA2,IDSQ2,"PG.IDTORNEOG","PE.IDTORNEOE") values ('11','2','Juventus','1','1','Lazio','4','1',null);
Insert into ANDREA.VISTA_RIS_PARTITE (IDPARTITA,IDSQ1,SQUADRA1,GOL1,GOL2,SQUADRA2,IDSQ2,"PG.IDTORNEOG","PE.IDTORNEOE") values ('5','2','Juventus','2','1','Roma','3','1',null);
Insert into ANDREA.VISTA_RIS_PARTITE (IDPARTITA,IDSQ1,SQUADRA1,GOL1,GOL2,SQUADRA2,IDSQ2,"PG.IDTORNEOG","PE.IDTORNEOE") values ('1','1','Napoli','3','2','Juventus','2','1',null);
Insert into ANDREA.VISTA_RIS_PARTITE (IDPARTITA,IDSQ1,SQUADRA1,GOL1,GOL2,SQUADRA2,IDSQ2,"PG.IDTORNEOG","PE.IDTORNEOE") values ('3','3','Roma','2','4','Napoli','1','1',null);
Insert into ANDREA.VISTA_RIS_PARTITE (IDPARTITA,IDSQ1,SQUADRA1,GOL1,GOL2,SQUADRA2,IDSQ2,"PG.IDTORNEOG","PE.IDTORNEOE") values ('9','1','Napoli','2','1','Lazio','4','1',null);
REM INSERTING into ANDREA.VISTA_STAFF
SET DEFINE OFF;
--------------------------------------------------------
--  Constraints for Table EVENTI
--------------------------------------------------------

  ALTER TABLE "ANDREA"."EVENTI" ADD PRIMARY KEY ("IDEVENTO")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM"  ENABLE;
  ALTER TABLE "ANDREA"."EVENTI" ADD CHECK (Evento IN ('Goal', 'Tiri', 'CartellinoG', 'CartellinoR', 'Fuorigioco', 'Assist', 'TiroInPorta')) ENABLE;
  ALTER TABLE "ANDREA"."EVENTI" MODIFY ("EVENTO" NOT NULL ENABLE);
  ALTER TABLE "ANDREA"."EVENTI" MODIFY ("MINUTO" NOT NULL ENABLE);
  ALTER TABLE "ANDREA"."EVENTI" MODIFY ("IDGIOCATORE" NOT NULL ENABLE);
  ALTER TABLE "ANDREA"."EVENTI" MODIFY ("IDPARTITA" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table GIOCATORE
--------------------------------------------------------

  ALTER TABLE "ANDREA"."GIOCATORE" ADD PRIMARY KEY ("IDGIOCATORE")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM"  ENABLE;
  ALTER TABLE "ANDREA"."GIOCATORE" ADD CHECK (Ruolo IN ('portiere', 'difensore', 'centrocampista', 'attaccante')) ENABLE;
  ALTER TABLE "ANDREA"."GIOCATORE" MODIFY ("RUOLO" NOT NULL ENABLE);
  ALTER TABLE "ANDREA"."GIOCATORE" MODIFY ("COGNOME" NOT NULL ENABLE);
  ALTER TABLE "ANDREA"."GIOCATORE" MODIFY ("NOME" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table INCONTRI
--------------------------------------------------------

  ALTER TABLE "ANDREA"."INCONTRI" MODIFY ("IDSQ1" NOT NULL ENABLE);
  ALTER TABLE "ANDREA"."INCONTRI" MODIFY ("IDPARTITA" NOT NULL ENABLE);
  ALTER TABLE "ANDREA"."INCONTRI" MODIFY ("IDSQ2" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table PARTECIPANTI_ELIMINAZIONE
--------------------------------------------------------

  ALTER TABLE "ANDREA"."PARTECIPANTI_ELIMINAZIONE" MODIFY ("IDSQUADRA" NOT NULL ENABLE);
  ALTER TABLE "ANDREA"."PARTECIPANTI_ELIMINAZIONE" MODIFY ("IDTORNEOE" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table PARTECIPANTI_GIRONI
--------------------------------------------------------

  ALTER TABLE "ANDREA"."PARTECIPANTI_GIRONI" MODIFY ("IDSQUADRA" NOT NULL ENABLE);
  ALTER TABLE "ANDREA"."PARTECIPANTI_GIRONI" MODIFY ("IDTORNEOG" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table PARTITA
--------------------------------------------------------

  ALTER TABLE "ANDREA"."PARTITA" ADD PRIMARY KEY ("IDPARTITA")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM"  ENABLE;
  ALTER TABLE "ANDREA"."PARTITA" MODIFY ("DATA" NOT NULL ENABLE);
  ALTER TABLE "ANDREA"."PARTITA" MODIFY ("STADIO" NOT NULL ENABLE);
  ALTER TABLE "ANDREA"."PARTITA" MODIFY ("IDSQ2" NOT NULL ENABLE);
  ALTER TABLE "ANDREA"."PARTITA" MODIFY ("IDSQ1" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table SQUADRA
--------------------------------------------------------

  ALTER TABLE "ANDREA"."SQUADRA" ADD PRIMARY KEY ("IDSQUADRA")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM"  ENABLE;
  ALTER TABLE "ANDREA"."SQUADRA" ADD CHECK (Tipo IN ('club', 'nazionale')) ENABLE;
  ALTER TABLE "ANDREA"."SQUADRA" MODIFY ("TIPO" NOT NULL ENABLE);
  ALTER TABLE "ANDREA"."SQUADRA" MODIFY ("NOME" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table SQUADRA_GIOCATORI
--------------------------------------------------------

  ALTER TABLE "ANDREA"."SQUADRA_GIOCATORI" MODIFY ("IDGIOCATORE" NOT NULL ENABLE);
  ALTER TABLE "ANDREA"."SQUADRA_GIOCATORI" MODIFY ("IDSQUADRA" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table STAFF
--------------------------------------------------------

  ALTER TABLE "ANDREA"."STAFF" ADD PRIMARY KEY ("IDSTAFF")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM"  ENABLE;
  ALTER TABLE "ANDREA"."STAFF" ADD CHECK (Professione IN ('allenatore', 'dirigente', 'presidente')) ENABLE;
  ALTER TABLE "ANDREA"."STAFF" MODIFY ("PROFESSIONE" NOT NULL ENABLE);
  ALTER TABLE "ANDREA"."STAFF" MODIFY ("DATANASCITA" NOT NULL ENABLE);
  ALTER TABLE "ANDREA"."STAFF" MODIFY ("LUOGONASCITA" NOT NULL ENABLE);
  ALTER TABLE "ANDREA"."STAFF" MODIFY ("COGNOME" NOT NULL ENABLE);
  ALTER TABLE "ANDREA"."STAFF" MODIFY ("NOME" NOT NULL ENABLE);
  ALTER TABLE "ANDREA"."STAFF" MODIFY ("IDSQUADRA" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table TORNEO_ELIMINAZIONE
--------------------------------------------------------

  ALTER TABLE "ANDREA"."TORNEO_ELIMINAZIONE" ADD PRIMARY KEY ("IDTORNEOE")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM"  ENABLE;
  ALTER TABLE "ANDREA"."TORNEO_ELIMINAZIONE" MODIFY ("NOMETORNEOE" NOT NULL ENABLE);
  ALTER TABLE "ANDREA"."TORNEO_ELIMINAZIONE" MODIFY ("STAGIONEE" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table TORNEO_GIRONI
--------------------------------------------------------

  ALTER TABLE "ANDREA"."TORNEO_GIRONI" ADD PRIMARY KEY ("IDTORNEOG")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM"  ENABLE;
  ALTER TABLE "ANDREA"."TORNEO_GIRONI" MODIFY ("NOMETORNEOG" NOT NULL ENABLE);
  ALTER TABLE "ANDREA"."TORNEO_GIRONI" MODIFY ("STAGIONEG" NOT NULL ENABLE);
