/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dbproject;

import java.awt.Component;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.swing.JOptionPane;
import oracle.jdbc.pool.OracleDataSource;

/**
 *
 * @author Andrea
 */
public class DBproject {

    
    //Stringa contentente l'username per il login
    static public String userName = "";
    //Stringa contenente la password per il login
    static public String passWord = "";
    //Stringa contenente la parte iniziale (rappresentante il tipo di libreria) dell'url
    static public String url = "jdbc:oracle:thin:@//";
    //Datasource necessario per la connessione
    static private OracleDataSource ods;
    //Connessione di default
    static Connection defaultConn;
    private static Component thrower;
    
    
    //Metodo che ritorna la connessione di default
    static public Connection getDefaultConn() throws SQLException {
        //Se la connessione non è stata stabilita o è stata chiusa, assegna a defaultConn la nuova connessione
        if (defaultConn == null || defaultConn.isClosed()) {
            defaultConn = newConn();
        }

      return defaultConn;
   }
    
    // Assegna una connessione come connessione di default
    static public void setDefaultConn(Connection conn){
        defaultConn = conn;
    }
    
    //Crea una nuova connessione
    static public Connection newConn() throws SQLException{
        ods = new OracleDataSource();
        //Assegnazione dell'url al datasource
        ods.setURL(url + "localhost:1521/xe");
        //Assegnazione dell'username
        ods.setUser(userName);
        //Assegnazione della password
        ods.setPassword(passWord);
        return ods.getConnection();
    }
    
    static public void showError(java.awt.Component thrower,SQLException e){
        String message;
        message = e.getMessage();
        message += "SQLSTATE" + e.getSQLState() + "\n";
        
        JOptionPane.showMessageDialog(thrower, message, "Errore" + e.getErrorCode(), JOptionPane.ERROR_MESSAGE);
    }
    
    static Statement insert;
    static String up;
    static int a;

    static void insert(String tab, String col, String val) throws SQLException {
        up="INSERT INTO " + tab + " " + col + " VALUES " + val;
        System.out.println(up);
        insert=defaultConn.createStatement();
        insert.executeUpdate(up);
        JOptionPane.showMessageDialog(thrower, "Inserimento Eseguito");
    }
    
    
        //VISTE
        //CALCOLO DEGLI ID
        static Statement calcMax;
        static String calc;
        static int calcMax (String tab, String col) throws SQLException{
            calc="SELECT MAX(" + col + ") FROM " + tab;
            calcMax=defaultConn.createStatement();
            ResultSet result = calcMax.executeQuery(calc);
        int id = 0;
        while (result.next()) {
            id = result.getInt(1);
        }
        return id;
        }
        
        //VISTA PER LA RICERCA DEL GIOCATORE
        static Statement ricGioc;
        static String ricercaGiocatore;
        static ResultSet ricGioc (java.awt.Component thrower, String gioc) throws SQLException{
            ricercaGiocatore="SELECT Nome, Cognome, Squadra, Goal, Tiri, Falli, Ammonizioni, Espulsioni, Fuorigioco, Assist FROM STAT_INDIVIDUALI WHERE LOWER(cognome) = LOWER('" + gioc +"')";
            ricGioc=defaultConn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ResultSet result = ricGioc.executeQuery(ricercaGiocatore);
            System.out.println(ricercaGiocatore);
            return result;
        }
        
        //VISTA PER LA RICERCA DI UNA SQUADRA
        static Statement ricSq;
        static String ricercaSquadra;
        static ResultSet ricSq (java.awt.Component thrower, String sq) throws SQLException{
            ricercaSquadra="SELECT Squadra, Nome, Cognome, Goal, Assist, Ammonizioni, Espulsioni FROM STAT_INDIVIDUALI WHERE LOWER(squadra) = LOWER('" + sq +"')";
            ricSq=defaultConn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ResultSet result = ricSq.executeQuery(ricercaSquadra);
            System.out.println(ricercaSquadra);
            return result;
        }
        
        //VISTA PER LA RICERCA DELLE SQUADRE PER TIPO
        static Statement ricSqT;
        static String ricercaSquadraTipo;
        static ResultSet ricSqT (java.awt.Component thrower, String tipo) throws SQLException{
            ricercaSquadraTipo="SELECT IDsquadra, Nome, Tipo FROM SQUADRA WHERE LOWER(tipo) = LOWER('" + tipo +"')";
            ricSqT=defaultConn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ResultSet result = ricSqT.executeQuery(ricercaSquadraTipo);
            System.out.println(ricercaSquadraTipo);
            return result;
        }
        
        //VISTA PER LA RICERCA DELLO STAFF
        static Statement ricStaff;
        static String ricercaStaff;
        static ResultSet ricStaff (java.awt.Component thrower, String prof, String cognome) throws SQLException{
            ricercaStaff="SELECT Nome, Cognome, Nazionalita, DataNascita, Squadra FROM VISTA_STAFF WHERE LOWER(PROFESSIONE) = LOWER('" + prof +"') AND LOWER(COGNOME) = LOWER ('" + cognome + "')";
            ricStaff=defaultConn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ResultSet result = ricStaff.executeQuery(ricercaStaff);
            System.out.println(ricercaStaff);
            return result;
        }
        
        //VISTA RISULTATO PARTITE
        static Statement risPart;
        static String risultatoPartite;
        static ResultSet risPart (java.awt.Component thrower) throws SQLException{
            risultatoPartite="SELECT IDpartita, Squadra1, Gol1, Gol2, Squadra2 FROM VISTA_RIS_PARTITE ORDER BY IDPARTITA DESC";
            risPart=defaultConn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ResultSet result = risPart.executeQuery(risultatoPartite);
            System.out.println(risultatoPartite);
            return result;
        }

        //VISTA RISULTATO PARTITE
        static Statement ricAllGioc;
        static String tuttiGiocatori;
        static ResultSet ricAllGioc (java.awt.Component thrower, String order) throws SQLException{
            tuttiGiocatori="SELECT IDgiocatore, Cognome, Squadra, Goal, Ammonizioni, Espulsioni, Assist FROM STAT_INDIVIDUALI ORDER BY " + order + " DESC";
            ricAllGioc=defaultConn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ResultSet result = ricAllGioc.executeQuery(tuttiGiocatori);
            System.out.println(tuttiGiocatori);
            return result;
        }
        
        //SELECT PER ELENCO TORNEI
        static Statement elTG;
        static String elencoTorneiG;
        static ResultSet elTG (java.awt.Component thrower) throws SQLException{
            elencoTorneiG="SELECT IDTORNEOG, NOMETORNEOG, STAGIONEG FROM TORNEO_GIRONI ORDER BY IDTORNEOG DESC";
            elTG=defaultConn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ResultSet result = elTG.executeQuery(elencoTorneiG);
            System.out.println(elencoTorneiG);
            return result;
        }
        
        //VISTA DETTAGLI EVENTI PER PARTITA
        static Statement dettEv;
        static String dettagliEventi;
        static ResultSet dettEv (java.awt.Component thrower, Integer idpartita) throws SQLException{
            dettagliEventi="SELECT MINUTO, SQUADRA, EVENTO, GIOCATORE, IDPARTITA  FROM VISTA_EVENTI WHERE IDPARTITA = " + idpartita + " ORDER BY MINUTO DESC";
            dettEv=defaultConn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ResultSet result = dettEv.executeQuery(dettagliEventi);
            System.out.println(dettagliEventi);
            return result;
        }
        
        //RISULTATO SINGOLA PARTITA
        static Statement risSPart;
        static String risultatoSingolaPartita;
        static String risultatoSingolo (java.awt.Component thrower, Integer idpartita) throws SQLException{
            risultatoSingolaPartita="SELECT SQUADRA1, SQUADRA2, GOL1, GOL2 FROM VISTA_RIS_PARTITE WHERE IDPARTITA = " + idpartita;
            risSPart=defaultConn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ResultSet result = risSPart.executeQuery(risultatoSingolaPartita);
            System.out.println(risultatoSingolaPartita);
            String ris=null;
            while (result.next()){
                ris = result.getString("SQUADRA1");
                ris += " ";
                ris += result.getInt("GOL1");
                ris += " - ";
                ris += result.getInt("GOL2");
                ris += " ";
                ris += result.getString("SQUADRA2");
            }
            System.out.println(ris);
            return ris;
        }
        
        //VISTA PER CLASSIFICA MARCATORI 
        static Statement classMarc;
        static String classificaMarcatori;
        static ResultSet classMarc (java.awt.Component thrower, Integer torneo) throws SQLException{
            classificaMarcatori="SELECT GIOCATORE, SQUADRA, GOAL FROM VISTA_MARCATORI WHERE IDTORNEO = " + torneo + " ORDER BY GOAL DESC";
            classMarc=defaultConn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ResultSet result = classMarc.executeQuery(classificaMarcatori);
            System.out.println(classificaMarcatori);
            return result;
        }
        
        //VISTA PER CLASSIFICA ASSIST
        static Statement classAss;
        static String classificaAssist;
        static ResultSet classAss (java.awt.Component thrower, Integer torneo) throws SQLException{
            classificaAssist="SELECT GIOCATORE, SQUADRA, ASSIST FROM VISTA_ASSIST WHERE IDTORNEO = " + torneo + " ORDER BY ASSIST DESC";
            classAss=defaultConn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ResultSet result = classAss.executeQuery(classificaAssist);
            System.out.println(classificaAssist);
            return result;
        }
        
        //QUERY PER LA RICERCA E CREAZIONE DEL NUMERO TURNO TORNEO
        static Statement numT;
        static String numeroTurno;
        static Integer numT (java.awt.Component thrower, Integer torneo) throws SQLException{
        //RICERCA DELL'ULTIMO NUMERO TURNO UTILIZZATO PER QUEL TORNEO
            numeroTurno="SELECT NUMERO_TURNO_TORNEO FROM PARTITA WHERE IDTORNEOE = " + torneo + " ORDER BY NUMERO_TURNO_TORNEO ASC";
            numT=defaultConn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ResultSet result = numT.executeQuery(numeroTurno);
            System.out.println(numeroTurno);
            Integer num=null;
            while (result.next()){
                num = result.getInt("NUMERO_TURNO_TORNEO");
            }
            
            System.out.println("stampo num=" + num);
            
            
        //RICERCA DEL NUMERO DEI PARTECIPANTI AL TORNEO
            numeroTurno="SELECT COUNT(IDSQUADRA) AS IDSQUADRA FROM PARTECIPANTI_ELIMINAZIONE WHERE IDTORNEOE = " + torneo;
            numT=defaultConn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            result = numT.executeQuery(numeroTurno);
            System.out.println(numeroTurno);
            Integer numPartecipanti=null;
            while (result.next()){
                numPartecipanti = result.getInt("IDSQUADRA");
            }  
           
            System.out.println("stampo numP=" + numPartecipanti);
            
        //CALCOLO DEGLI UTILIZZI DELLO STESSO NUMERO TURNO
            numeroTurno="SELECT COUNT(NUMERO_TURNO_TORNEO) AS NUMERO_TURNO_TORNEO FROM PARTITA WHERE IDTORNEOE = " + torneo + " AND NUMERO_TURNO_TORNEO = " + num;
            numT=defaultConn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            result = numT.executeQuery(numeroTurno);
            System.out.println(numeroTurno);
            Integer quantoNum=null;
            while (result.next()){
                quantoNum = result.getInt("NUMERO_TURNO_TORNEO");
            }
            System.out.println("stampo quantoNum=" + quantoNum);
      
        //CALCOLO DELLE VOLTE IN CUI È STATO UTILIZZATO IL NUMERO TURNO (num) 
            //PER UTILIZZARE LO STESSO NUMERO TURNO DEVE ESSERE quantoNum<(numPartecipanti/2)
            //QUESTO PERCHÉ IL NUMERO DI PARTECIPANTI DEVE ESSERE UNA POTENZA DI 2 
            //E LE PARTITE DEL PRIMO TURNO SONO ESATTAMENTE IL NUMERO DEI PARTECIPANTI /2.
            //I PARTECIPANTI VENGONO DIMEZZATI AD OGNI TURNO, QUINDI PER OGNI MAGGIORAZIONE DI 1 IN NUMERO TURNO
            //PER SAPERE QUANTE PARTITE AVRANNO LO STESSO NUMERO TURNO, SI DEVE FARE numPartecipanti/2^num
            //QUINDI PER I TURNI SUCCESSIVI AL PRIMO, SI POTRÀ UTILIZZARE LO STESSO NUMERO TURNO
            //ESATTAMENTE numPartecipanti/2^num.
            //POSSIAMO QUINDI DIRE CHE CON num!=0 IL CALCOLO DEL NUMERO TURNO DA ASSEGNARE È 
            Integer ris=null;
            if(num==null){
                ris=1;
                System.out.println("viene restituito 1\n");
            }else {
                if(quantoNum<=numPartecipanti/(2^num)){
                    ris=num;
                    System.out.println("num va bene\n");
                }else{
                    ris=num+1;
                    System.out.println("num viene incrementato\n");
                }
            }
            
            return ris;
        }
}


