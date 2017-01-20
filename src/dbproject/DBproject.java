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
    static private Connection defaultConn;
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
        static ResultSet risPart (java.awt.Component thrower/*, String prof, String cognome*/) throws SQLException{
            risultatoPartite="SELECT IDpartita, IDsq1, Squadra1, Gol1, Gol2, Squadra2, IDsq2 FROM VISTA_RIS_PARTITE ORDER BY IDPARTITA DESC";
            risPart=defaultConn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ResultSet result = risPart.executeQuery(risultatoPartite);
            System.out.println(risultatoPartite);
            return result;
        }
        
}


