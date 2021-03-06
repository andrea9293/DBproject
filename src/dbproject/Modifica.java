/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dbproject;

import java.awt.event.ItemEvent;
import java.awt.event.ItemListener;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.swing.JOptionPane;

/**
 *
 * @author Andrtea
 */
public class Modifica extends javax.swing.JFrame {

    /**
     * Creates new form Modifica
     */
    public Modifica() {
        initComponents();
        setLocationRelativeTo(null);
        //AGGIUNTA DEI LISTNER PER I COMBOBOX    
        selTab.addItemListener(new ItemListener(){
            public void itemStateChanged(ItemEvent e){
                if(e.getStateChange()==ItemEvent.SELECTED){
                    
                    selTabElements();
                }
            }
        });
        jComboBoxTipo.addItemListener(new ItemListener(){
            public void itemStateChanged(ItemEvent e){
                if(e.getStateChange()==ItemEvent.SELECTED){
                    tipoElements();
                }
            }
        });
        selTabElements();
        jTable2.setShowGrid(false);
        jTable1.setShowGrid(false);
        box.setVisible(false);
        jComboBoxTipo.setVisible(false);
    }
    
    //Il metodo si occupa dei vambiamenti da apportare al'interfaccia a seconda dell'elemento da modificare
    private void selTabElements(){
        jText1.setEditable(false);
        jText2.setEditable(false);
        jText3.setEditable(false);
        jText4.setEditable(false);
        jText5.setEditable(false);
        jText6.setEditable(false);
        jText1.setText("");
        jText2.setText("");
        jText3.setText("");
        jText4.setText("");
        jText5.setText("");
        jText6.setText("");
        jComboBoxTipo.setVisible(false);
        switch(selTab.getSelectedIndex()){
            case 0:
                //EVENTO
                try {
                    ResultSet rs;
                    rs=DBproject.modEv(this);
                    jTable1.setModel (new VistaTabelle(rs));
                    pack();
                } catch(SQLException ex) {
                    DBproject.showError(this, ex);
                }
                try {
                    ResultSet rs;
                    rs=DBproject.modGioc(this);
                    jTable2.setModel (new VistaTabelle(rs));
                    pack();
                } catch(SQLException ex) {
                    DBproject.showError(this, ex);
                }
                jText1.setVisible(true);
                jText1.setBorder(javax.swing.BorderFactory.createTitledBorder("IDevento"));
                jText1.setEditable(false);
                jText2.setVisible(true);
                jText2.setBorder(javax.swing.BorderFactory.createTitledBorder("IDpartita"));
                jText3.setVisible(true);
                jText3.setBorder(javax.swing.BorderFactory.createTitledBorder("Minuto"));
                jText4.setVisible(true);
                jText4.setBorder(javax.swing.BorderFactory.createTitledBorder("IDgiocatore"));
                jText5.setVisible(false);
                jText6.setVisible(false);
                box.setVisible(true);
                box.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "", "Goal", "Tiri", "CartellinoG", "CartellinoR", "Fuorigioco", "Assist", "TiroInPorta" }));
                box.setBorder(javax.swing.BorderFactory.createTitledBorder("Evento"));
                break;
            case 1:
                //SQUADRA
                try {
                    ResultSet rs;
                    rs=DBproject.modSq(this);
                    jTable1.setModel (new VistaTabelle(rs));
                    pack();
                } catch(SQLException ex) {
                    DBproject.showError(this, ex);
                }
                try {
                    ResultSet rs;
                    rs=DBproject.modGioc(this);
                    jTable2.setModel (new VistaTabelle(rs));
                    pack();
                } catch(SQLException ex) {
                    DBproject.showError(this, ex);
                }
                jText1.setVisible(true);
                jText1.setBorder(javax.swing.BorderFactory.createTitledBorder("IDsquadra"));
                jText2.setVisible(true);
                jText2.setBorder(javax.swing.BorderFactory.createTitledBorder("Nome"));
                jText3.setVisible(false);
                jText4.setVisible(false);
                jText5.setVisible(false);
                jText6.setVisible(false);
                box.setVisible(false);
                box.setVisible(true);
                box.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "", "club", "nazionale"}));
                box.setBorder(javax.swing.BorderFactory.createTitledBorder("Tipo Squadra"));
                break;
            case 2:
                //GIOCATORE
                try {
                    ResultSet rs;
                    rs=DBproject.modGioc(this);
                    jTable1.setModel (new VistaTabelle(rs));
                    pack();
                } catch(SQLException ex) {
                    DBproject.showError(this, ex);
                }
                try {
                    ResultSet rs;
                    rs=DBproject.modSq(this);
                    jTable2.setModel (new VistaTabelle(rs));
                    pack();
                } catch(SQLException ex) {
                    DBproject.showError(this, ex);
                }
                jComboBoxTipo.setVisible(false);
                jText1.setVisible(true);
                jText1.setBorder(javax.swing.BorderFactory.createTitledBorder("IDgiocatore"));
                jText2.setVisible(true);
                jText2.setBorder(javax.swing.BorderFactory.createTitledBorder("Nome"));
                jText3.setVisible(true);
                jText3.setBorder(javax.swing.BorderFactory.createTitledBorder("Cognome"));
                jText6.setVisible(true);
                jText6.setBorder(javax.swing.BorderFactory.createTitledBorder("ID squadra di riferimento"));
                jText4.setVisible(false);
                jText5.setVisible(false);
                box.setVisible(true);
                box.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "", "portiere", "difensore", "centrocampista", "attaccante"}));
                box.setBorder(javax.swing.BorderFactory.createTitledBorder("Ruolo"));
                break;
            case 3:
                //STAFF
                try {
                    ResultSet rs;
                    rs=DBproject.modStaff(this);
                    jTable1.setModel (new VistaTabelle(rs));
                    pack();
                } catch(SQLException ex) {
                    DBproject.showError(this, ex);
                }
                try {
                    ResultSet rs;
                    rs=DBproject.modSq(this);
                    jTable2.setModel (new VistaTabelle(rs));
                    pack();
                } catch(SQLException ex) {
                    DBproject.showError(this, ex);
                }
                jComboBoxTipo.setVisible(false);
                jText1.setVisible(true);
                jText1.setBorder(javax.swing.BorderFactory.createTitledBorder("IDstaff"));
                jText1.setEditable(false);
                jText2.setVisible(true);
                jText2.setBorder(javax.swing.BorderFactory.createTitledBorder("Nome"));
                jText3.setVisible(true);
                jText3.setBorder(javax.swing.BorderFactory.createTitledBorder("Cognome"));
                jText4.setVisible(true);
                jText4.setBorder(javax.swing.BorderFactory.createTitledBorder("Luogo di Nascita"));
                jText5.setVisible(true);
                jText5.setBorder(javax.swing.BorderFactory.createTitledBorder("Data di Nascita (aaaa-mm-gg)"));
                jText6.setVisible(true);
                jText6.setEditable(true);
                jText6.setBorder(javax.swing.BorderFactory.createTitledBorder("IDsquadra"));
                box.setVisible(true);
                box.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "", "allenatore", "dirigente", "presidente"}));
                box.setBorder(javax.swing.BorderFactory.createTitledBorder("Professione"));
                break;
            case 4:
                //partite
                try {
                    ResultSet rs;
                    rs=DBproject.modPar(this);
                    jTable1.setModel (new VistaTabelle(rs));
                    pack();
                } catch(SQLException ex) {
                    DBproject.showError(this, ex);
                }
                try {
                    ResultSet rs;
                    rs=DBproject.modSq(this);
                    jTable2.setModel (new VistaTabelle(rs));
                    pack();
                } catch(SQLException ex) {
                    DBproject.showError(this, ex);
                }
                jComboBoxTipo.setVisible(false);
                jText1.setVisible(true);
                jText1.setBorder(javax.swing.BorderFactory.createTitledBorder("IDpartita"));
                jText1.setEditable(false);
                jText2.setVisible(true);
                jText2.setBorder(javax.swing.BorderFactory.createTitledBorder("Stadio"));
                jText3.setVisible(true);
                jText3.setBorder(javax.swing.BorderFactory.createTitledBorder("IDsquadra 1"));
                jText4.setVisible(true);
                jText4.setBorder(javax.swing.BorderFactory.createTitledBorder("IDsquadra 2"));
                jText5.setVisible(true);
                jText5.setBorder(javax.swing.BorderFactory.createTitledBorder("Data (aaaa-mm-gg)"));
                jText6.setVisible(true);
                jText6.setBorder(javax.swing.BorderFactory.createTitledBorder("ID del torneo"));
                box.setVisible(true);
                jComboBoxTipo.setVisible(false);
                box.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "", "Torneo a Gironi", "Torneo ad Eliminazione"}));
                box.setBorder(javax.swing.BorderFactory.createTitledBorder("Tipo di Torneo"));
                break;
            case 5:
                //torneo gironi
                try {
                    ResultSet rs;
                    rs=DBproject.modTg(this);
                    jTable1.setModel (new VistaTabelle(rs));
                    pack();
                } catch(SQLException ex) {
                    DBproject.showError(this, ex);
                }
                try {
                    ResultSet rs;
                    rs=DBproject.modSq(this);
                    jTable2.setModel (new VistaTabelle(rs));
                    pack();
                } catch(SQLException ex) {
                    DBproject.showError(this, ex);
                }
                jText1.setVisible(true);
                jText1.setBorder(javax.swing.BorderFactory.createTitledBorder("IDtorneo girone"));
                jText2.setVisible(true);
                jText2.setBorder(javax.swing.BorderFactory.createTitledBorder("Stagione"));
                jText3.setVisible(true);
                jText3.setBorder(javax.swing.BorderFactory.createTitledBorder("Nome Torneo"));
                jText4.setVisible(false);
                jText5.setVisible(false);
                jText6.setVisible(false);
                box.setVisible(false);
                jComboBoxTipo.setVisible(false);
                break;
            case 6:
                //torneo eliminazione
                try {
                    ResultSet rs;
                    rs=DBproject.modTe(this);
                    jTable1.setModel (new VistaTabelle(rs));
                    pack();
                } catch(SQLException ex) {
                    DBproject.showError(this, ex);
                }
                try {
                    ResultSet rs;
                    rs=DBproject.modSq(this);
                    jTable2.setModel (new VistaTabelle(rs));
                    pack();
                } catch(SQLException ex) {
                    DBproject.showError(this, ex);
                }
                jText1.setVisible(true);
                jText1.setBorder(javax.swing.BorderFactory.createTitledBorder("IDtorneo eliminazione"));
                jText2.setVisible(true);
                jText2.setBorder(javax.swing.BorderFactory.createTitledBorder("Stagione"));
                jText3.setVisible(true);
                jText3.setBorder(javax.swing.BorderFactory.createTitledBorder("Nome Torneo"));
                jText4.setVisible(false);
                jText5.setVisible(false);
                jText6.setVisible(false);
                jComboBoxTipo.setVisible(false);
                box.setVisible(false);
                break;
        }
    }
    //Il metodo è responsabile della visualizzazione delle squadre di club o di nazionale
    //a seconda delle necessità dell'utente
    private void tipoElements(){
        
        ResultSet rs;
        String tipo= (String) jComboBoxTipo.getSelectedItem();
        try {
            rs=DBproject.ricSqT(this, tipo);
            jTable1.setModel (new VistaTabelle(rs));
            pack();
        } catch(SQLException ex) {
            DBproject.showError(this, ex);
        }
    }
    
    
    //Funzione per la ricerca della tabella da modificare
    private String searchTab(){
        String tab="";
        if ("EVENTO".equals((String)selTab.getSelectedItem())){
            tab="EVENTI";
        }else if ("SQUADRA".equals((String)selTab.getSelectedItem())){
            tab="SQUADRA";
        }else if ("GIOCATORE".equals((String)selTab.getSelectedItem())){
            tab="GIOCATORE";
        }else if ("MEMBRO STAFF".equals((String)selTab.getSelectedItem())){
            tab="STAFF";
        }else if ("TORNEO GIRONI".equals((String)selTab.getSelectedItem())){
            tab="TORNEO_GIRONI";
        }else if ("TORNEO ELIMINAZIONE".equals((String)selTab.getSelectedItem())){
            tab="TORNEO_ELIMINAZIONE";
        }else if ("PARTITA".equals((String)selTab.getSelectedItem())){
            tab="PARTITA";
        }
        return tab;
    }
    
    //La funzione si occupa della ricerca della condizione necessaria da associare alla chiave primaria
    //per la ricerca del preciso elemento da modificare, selezionato dall'utente
    private String searchCond(){
        String cond="";
        if ("EVENTO".equals((String)selTab.getSelectedItem())){
            cond="IDEVENTO = ";
        }else if ("SQUADRA".equals((String)selTab.getSelectedItem())){
            cond="IDSQUADRA = ";
        }else if ("GIOCATORE".equals((String)selTab.getSelectedItem())){
            System.out.println("sono dentro");
            cond="IDGIOCATORE = ";
        }else if ("MEMBRO STAFF".equals((String)selTab.getSelectedItem())){
            cond="STAFF = ";
        }else if ("TORNEO GIRONI".equals((String)selTab.getSelectedItem())){
            cond="IDTORNEOG = ";
        }else if ("TORNEO ELIMINAZIONE".equals((String)selTab.getSelectedItem())){
            cond="IDTORNEOE = ";
        }else if ("PARTITA".equals((String)selTab.getSelectedItem())){
            cond="IDPARTITA = ";
        }
        return cond;
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jPanel1 = new javax.swing.JPanel();
        jText5 = new javax.swing.JTextField();
        box = new javax.swing.JComboBox<>();
        selTab = new javax.swing.JComboBox<>();
        jText3 = new javax.swing.JTextField();
        jText2 = new javax.swing.JTextField();
        jText6 = new javax.swing.JTextField();
        jText4 = new javax.swing.JTextField();
        jText1 = new javax.swing.JTextField();
        jComboBoxTipo = new javax.swing.JComboBox<>();
        jScrollPane1 = new javax.swing.JScrollPane();
        jTable1 = new javax.swing.JTable();
        jScrollPane2 = new javax.swing.JScrollPane();
        jTable2 = new javax.swing.JTable();
        jButton1 = new javax.swing.JButton();
        jLabel1 = new javax.swing.JLabel();
        jButton2 = new javax.swing.JButton();
        jButton3 = new javax.swing.JButton();

        setDefaultCloseOperation(javax.swing.WindowConstants.DISPOSE_ON_CLOSE);

        jText5.setHorizontalAlignment(javax.swing.JTextField.LEFT);
        jText5.setBorder(javax.swing.BorderFactory.createTitledBorder("Nazionalità"));
        jText5.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                jText5MouseClicked(evt);
            }
        });

        box.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "", "'allenatore'", "'dirigente'", "'presidente'" }));
        box.setBorder(javax.swing.BorderFactory.createTitledBorder("Professione"));
        box.addItemListener(new java.awt.event.ItemListener() {
            public void itemStateChanged(java.awt.event.ItemEvent evt) {
                boxItemStateChanged(evt);
            }
        });

        selTab.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "EVENTO", "SQUADRA", "GIOCATORE", "MEMBRO STAFF", "PARTITA", "TORNEO GIRONI", "TORNEO ELIMINAZIONE" }));
        selTab.setBorder(javax.swing.BorderFactory.createTitledBorder("Scegliere cosa modificare/eliminare"));
        selTab.addItemListener(new java.awt.event.ItemListener() {
            public void itemStateChanged(java.awt.event.ItemEvent evt) {
                selTabItemStateChanged(evt);
            }
        });
        selTab.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                selTabActionPerformed(evt);
            }
        });

        jText3.setHorizontalAlignment(javax.swing.JTextField.LEFT);
        jText3.setBorder(javax.swing.BorderFactory.createTitledBorder("Data nascita (gg/mm/aaaa)"));
        jText3.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                jText3MouseClicked(evt);
            }
        });

        jText2.setHorizontalAlignment(javax.swing.JTextField.RIGHT);
        jText2.setBorder(javax.swing.BorderFactory.createTitledBorder("Cognome"));
        jText2.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                jText2MouseClicked(evt);
            }
        });
        jText2.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jText2ActionPerformed(evt);
            }
        });

        jText6.setBorder(javax.swing.BorderFactory.createTitledBorder("IDsquadra"));
        jText6.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                jText6MouseClicked(evt);
            }
        });
        jText6.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jText6ActionPerformed(evt);
            }
        });

        jText4.setHorizontalAlignment(javax.swing.JTextField.RIGHT);
        jText4.setBorder(javax.swing.BorderFactory.createTitledBorder("Luogo di nascita"));
        jText4.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                jText4MouseClicked(evt);
            }
        });

        jText1.setHorizontalAlignment(javax.swing.JTextField.LEFT);
        jText1.setBorder(javax.swing.BorderFactory.createTitledBorder("Nome"));
        jText1.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                jText1MouseClicked(evt);
            }
        });

        jComboBoxTipo.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "Club", "Nazionale" }));
        jComboBoxTipo.setBorder(javax.swing.BorderFactory.createTitledBorder("Tipo "));
        jComboBoxTipo.addItemListener(new java.awt.event.ItemListener() {
            public void itemStateChanged(java.awt.event.ItemEvent evt) {
                jComboBoxTipoItemStateChanged(evt);
            }
        });

        javax.swing.GroupLayout jPanel1Layout = new javax.swing.GroupLayout(jPanel1);
        jPanel1.setLayout(jPanel1Layout);
        jPanel1Layout.setHorizontalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                            .addGroup(jPanel1Layout.createSequentialGroup()
                                .addComponent(selTab, 0, 201, Short.MAX_VALUE)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED))
                            .addGroup(jPanel1Layout.createSequentialGroup()
                                .addComponent(jText3)
                                .addGap(6, 6, 6)))
                        .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addGroup(jPanel1Layout.createSequentialGroup()
                                .addComponent(jText4, javax.swing.GroupLayout.PREFERRED_SIZE, 201, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addGap(0, 0, Short.MAX_VALUE))
                            .addComponent(jText6)))
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addComponent(jText1, javax.swing.GroupLayout.PREFERRED_SIZE, 201, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(jText2, javax.swing.GroupLayout.PREFERRED_SIZE, 201, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addComponent(jText5, javax.swing.GroupLayout.PREFERRED_SIZE, 201, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                            .addComponent(jComboBoxTipo, 0, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                            .addComponent(box, 0, 201, Short.MAX_VALUE))))
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );
        jPanel1Layout.setVerticalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jText6, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(selTab, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(18, 18, 18)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jText2, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jText1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(18, 18, 18)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jText3, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jText4, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(18, 18, 18)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(box, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jText5, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(18, 18, 18)
                .addComponent(jComboBoxTipo, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );

        jTable1.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {
                {null, null, null, null},
                {null, null, null, null},
                {null, null, null, null},
                {null, null, null, null}
            },
            new String [] {
                "Title 1", "Title 2", "Title 3", "Title 4"
            }
        ));
        jTable1.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                jTable1MouseClicked(evt);
            }
        });
        jScrollPane1.setViewportView(jTable1);

        jTable2.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {
                {null, null, null, null},
                {null, null, null, null},
                {null, null, null, null},
                {null, null, null, null}
            },
            new String [] {
                "Title 1", "Title 2", "Title 3", "Title 4"
            }
        ));
        jScrollPane2.setViewportView(jTable2);

        jButton1.setText("Fine");
        jButton1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButton1ActionPerformed(evt);
            }
        });

        jLabel1.setFont(new java.awt.Font("Tahoma", 3, 18)); // NOI18N
        jLabel1.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        jLabel1.setText("Modifica");

        jButton2.setText("Conferma Modifiche");
        jButton2.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButton2ActionPerformed(evt);
            }
        });

        jButton3.setText("Elimina selezione");
        jButton3.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButton3ActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jLabel1, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addGroup(layout.createSequentialGroup()
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                            .addGroup(layout.createSequentialGroup()
                                .addGap(10, 10, 10)
                                .addComponent(jButton1, javax.swing.GroupLayout.PREFERRED_SIZE, 80, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                .addComponent(jButton3)
                                .addGap(46, 46, 46)
                                .addComponent(jButton2))
                            .addComponent(jPanel1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addGap(18, 21, Short.MAX_VALUE)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                            .addComponent(jScrollPane1, javax.swing.GroupLayout.DEFAULT_SIZE, 486, Short.MAX_VALUE)
                            .addComponent(jScrollPane2))))
                .addContainerGap())
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jLabel1)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(layout.createSequentialGroup()
                        .addGap(0, 11, Short.MAX_VALUE)
                        .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 173, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addComponent(jScrollPane2, javax.swing.GroupLayout.PREFERRED_SIZE, 145, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addComponent(jPanel1, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jButton1)
                    .addComponent(jButton2)
                    .addComponent(jButton3))
                .addContainerGap())
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void boxItemStateChanged(java.awt.event.ItemEvent evt) {//GEN-FIRST:event_boxItemStateChanged
        
    }//GEN-LAST:event_boxItemStateChanged

    private void selTabItemStateChanged(java.awt.event.ItemEvent evt) {//GEN-FIRST:event_selTabItemStateChanged
        
    }//GEN-LAST:event_selTabItemStateChanged

    private void selTabActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_selTabActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_selTabActionPerformed

    private void jText2ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jText2ActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_jText2ActionPerformed

    private void jText6ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jText6ActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_jText6ActionPerformed

    private void jComboBoxTipoItemStateChanged(java.awt.event.ItemEvent evt) {//GEN-FIRST:event_jComboBoxTipoItemStateChanged
       
    }//GEN-LAST:event_jComboBoxTipoItemStateChanged

    private void jText6MouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_jText6MouseClicked
        jText6.setEditable(true);
    }//GEN-LAST:event_jText6MouseClicked

    
    //A SECONDA DELLE ESIGENZE DELL'UTENTE, CLICCANDO SULLA TABELLA VENGONO RIEMPITI GLI APPOSITI 
    //CAMPI DI TESTO
    private void jTable1MouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_jTable1MouseClicked
        Integer row;
        Integer column;
        switch(selTab.getSelectedIndex()){
            case 1:
                row = jTable1.getSelectedRow();
                column = 0;
                jText1.setText(jTable1.getValueAt(row, column).toString());
                column++;
                jText2.setText(jTable1.getValueAt(row, column).toString());
                column++;
                if("club".equals(jTable1.getValueAt(row, column).toString())){
                    box.setSelectedIndex(1);
                }else if("nazionale".equals(jTable1.getValueAt(row, column).toString())){
                    box.setSelectedIndex(2);
                } 
                break;
            case 0:
                row = jTable1.getSelectedRow();
                column = 0;
                jText1.setText(jTable1.getValueAt(row, column).toString());
                column++;
                jText2.setText(jTable1.getValueAt(row, column).toString());
                column++;
                jText3.setText(jTable1.getValueAt(row, column).toString());
                column++;
                jText4.setText(jTable1.getValueAt(row, column).toString());
                column++;
                if("Goal".equals(jTable1.getValueAt(row, column).toString())){
                    box.setSelectedIndex(1);
                }else if("Tiri".equals(jTable1.getValueAt(row, column).toString())){
                    box.setSelectedIndex(2);
                }else if ("CartellinoG".equals(jTable1.getValueAt(row, column).toString())){
                    box.setSelectedIndex(3);
                }else if ("CartellinoR".equals(jTable1.getValueAt(row, column).toString())){
                    box.setSelectedIndex(4);
                }else if("CartellinoR".equals(jTable1.getValueAt(row, column).toString())){
                    box.setSelectedIndex(5);
                }else if("Assist".equals(jTable1.getValueAt(row, column).toString())){
                    box.setSelectedIndex(6);
                }else if ("TiroInPorta".equals(jTable1.getValueAt(row, column).toString())){
                    box.setSelectedIndex(7);
                }
                break;
            case 2:
                row = jTable1.getSelectedRow();
                column = 0;
                jText1.setText(jTable1.getValueAt(row, column).toString());
                column++;
                jText2.setText(jTable1.getValueAt(row, column).toString());
                column++;
                jText3.setText(jTable1.getValueAt(row, column).toString());
                column++;
                jText6.setText(jTable1.getValueAt(row, column).toString());
                column++;
                if("portiere".equals(jTable1.getValueAt(row, column).toString())){
                    box.setSelectedIndex(1);
                }else if("difensore".equals(jTable1.getValueAt(row, column).toString())){
                    box.setSelectedIndex(2);
                }else if ("centrocampista".equals(jTable1.getValueAt(row, column).toString())){
                    box.setSelectedIndex(3);
                }else if ("attaccante".equals(jTable1.getValueAt(row, column).toString())){
                    box.setSelectedIndex(4);
                }
                break;
            case 3:
                row = jTable1.getSelectedRow();
                column = 0;
                jText1.setText(jTable1.getValueAt(row, column).toString());
                column++;
                jText2.setText(jTable1.getValueAt(row, column).toString());
                column++;
                jText3.setText(jTable1.getValueAt(row, column).toString());
                column++;
                jText4.setText(jTable1.getValueAt(row, column).toString());
                column++;
                jText5.setText(jTable1.getValueAt(row, column).toString());
                column++;
                jText6.setText(jTable1.getValueAt(row, column).toString());
                column=7;
                if("allenatore".equals(jTable1.getValueAt(row, column).toString())){
                    box.setSelectedIndex(1);
                }else if("dirigente".equals(jTable1.getValueAt(row, column).toString())){
                    box.setSelectedIndex(2);
                }else if ("presidente".equals(jTable1.getValueAt(row, column).toString())){
                    box.setSelectedIndex(3);
                }
                break;
            case 4:
                row = jTable1.getSelectedRow();
                column = 0;
                jText1.setText(jTable1.getValueAt(row, column).toString());
                column++;
                jText2.setText(jTable1.getValueAt(row, column).toString());
                column++;
                jText3.setText(jTable1.getValueAt(row, column).toString());
                column++;
                jText4.setText(jTable1.getValueAt(row, column).toString());
                column++;
                jText5.setText(jTable1.getValueAt(row, column).toString());
                column++;
                if(jTable1.getValueAt(row, column)!=null){
                    jText6.setText(jTable1.getValueAt(row, column).toString());
                    box.setSelectedIndex(1);
                }else{
                    column++;
                    if(jTable1.getValueAt(row, column)!=null){
                        jText6.setText(jTable1.getValueAt(row, column).toString());
                        box.setSelectedIndex(2);
                    }
                }
                break;
            case 5:
                row = jTable1.getSelectedRow();
                column = 0;
                jText1.setText(jTable1.getValueAt(row, column).toString());
                column++;
                jText2.setText(jTable1.getValueAt(row, column).toString());
                column++;
                jText3.setText(jTable1.getValueAt(row, column).toString());
                break;
            case 6:
                row = jTable1.getSelectedRow();
                column = 0;
                jText1.setText(jTable1.getValueAt(row, column).toString());
                column++;
                jText2.setText(jTable1.getValueAt(row, column).toString());
                column++;
                jText3.setText(jTable1.getValueAt(row, column).toString());
        }
    }//GEN-LAST:event_jTable1MouseClicked

    private void jText1MouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_jText1MouseClicked
        //jText1.setEditable(true);
    }//GEN-LAST:event_jText1MouseClicked

    private void jText2MouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_jText2MouseClicked
        jText2.setEditable(true);
    }//GEN-LAST:event_jText2MouseClicked

    private void jText3MouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_jText3MouseClicked
        jText3.setEditable(true);
    }//GEN-LAST:event_jText3MouseClicked

    private void jText4MouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_jText4MouseClicked
        jText4.setEditable(true);
    }//GEN-LAST:event_jText4MouseClicked

    private void jText5MouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_jText5MouseClicked
        jText5.setEditable(true);
    }//GEN-LAST:event_jText5MouseClicked

    private void jButton1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButton1ActionPerformed
        dispose();
    }//GEN-LAST:event_jButton1ActionPerformed

    //SI PROCEDE ALL'AGGIORNAMENTO VERO E PROPRIO
    private void jButton2ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButton2ActionPerformed
        String tab=searchTab();
        String col;
        String val;
        String index;
        String id;
        //Per la selezione degli aggiornamenti da effettuare, si procede con la verifica 
        //di quali campi sono modificabili. Se sono modificabili allora vengono presi 
        //in considerazione dall'algoritmo
        try {
            switch (selTab.getSelectedIndex()){
                case 0:
                    //modifica degli eventi
                    index = "IDEVENTO";
                    id = jText1.getText();
                    if (jText2.isEditable()){
                        col = "IDPARTITA";
                        val = jText2.getText();
                        DBproject.upd(tab, col, val, index, id);
                    }
                    if (jText3.isEditable()){
                        col = "MINUTO";
                        val = jText3.getText();
                        DBproject.upd(tab, col, val, index, id);                    
                    }
                    if (jText4.isEditable()){
                        col = "IDGIOCATORE";
                        val = jText4.getText();
                        DBproject.upd(tab, col, val, index, id);                    
                    }
                    if(box.getSelectedItem().toString() != jTable1.getValueAt(jTable1.getSelectedRow(), 4).toString()){
                        col = "EVENTO";
                        val = "'" + box.getSelectedItem().toString() + "'";
                        DBproject.upd(tab, col, val, index, id);
                    }
                    try {
                        ResultSet rs;
                        rs=DBproject.modEv(this);
                        jTable1.setModel (new VistaTabelle(rs));
                        pack();
                    } catch(SQLException ex) {
                        DBproject.showError(this, ex);
                    }
                    try {
                        ResultSet rs;
                        rs=DBproject.modGioc(this);
                        jTable2.setModel (new VistaTabelle(rs));
                        pack();
                    } catch(SQLException ex) {
                        DBproject.showError(this, ex);
                    }
                    break;
                case 1:
                    //modifica delle squadre
                    index = "IDSQUADRA";
                    id = jText1.getText();
                    if (jText2.isEditable()){
                        col = "NOME";
                        val = "'" + jText2.getText() + "'";
                        DBproject.upd(tab, col, val, index, id);
                    }
                    if(box.getSelectedItem().toString() != jTable1.getValueAt(jTable1.getSelectedRow(), 2).toString()){
                        col = "TIPO";
                        val = "'" + box.getSelectedItem().toString() + "'";
                        DBproject.upd(tab, col, val, index, id);
                    }
                    try {
                        ResultSet rs;
                        rs=DBproject.modSq(this);
                        jTable1.setModel (new VistaTabelle(rs));
                        pack();
                    } catch(SQLException ex) {
                        DBproject.showError(this, ex);
                    }
                    try {
                        ResultSet rs;
                        rs=DBproject.modGioc(this);
                        jTable2.setModel (new VistaTabelle(rs));
                        pack();
                    } catch(SQLException ex) {
                        DBproject.showError(this, ex);
                    }
                    break;
                case 2:
                    //modifica dei giocatori
                    index = "IDGIOCATORE";
                    id = jText1.getText();
                    if (jText2.isEditable()){
                        col = "NOME";
                        val = "'" + jText2.getText() + "'";
                        DBproject.upd(tab, col, val, index, id);
                    }
                    if (jText3.isEditable()){
                        col = "COGNOME";
                        val = "'" + jText3.getText() + "'";
                        DBproject.upd(tab, col, val, index, id);                    
                    }
                    if(jText6.isEditable()){
                        String assTab = "SQUADRA_GIOCATORI";
                        col = "IDSQUADRA";
                        val = jText6.getText();
                        Integer row = jTable1.getSelectedRow();
                        String assId = id + " AND IDSQUADRA = " + jTable1.getValueAt(row, 3).toString();
                        DBproject.upd(assTab, col, val, index, assId);
                    }
                    if(box.getSelectedItem().toString() != jTable1.getValueAt(jTable1.getSelectedRow(), 4).toString()){
                        col = "RUOLO";
                        val = "'" + box.getSelectedItem().toString() + "'";
                        DBproject.upd(tab, col, val, index, id);
                    }
                    try {
                        ResultSet rs;
                        rs=DBproject.modGioc(this);
                        jTable1.setModel (new VistaTabelle(rs));
                        pack();
                    } catch(SQLException ex) {
                        DBproject.showError(this, ex);
                    }
                    try {
                        ResultSet rs;
                        rs=DBproject.modSq(this);
                        jTable2.setModel (new VistaTabelle(rs));
                        pack();
                    } catch(SQLException ex) {
                        DBproject.showError(this, ex);
                    }  
                    break;
                case 3:
                    //modifica dello staff
                    index = "IDSTAFF";
                    id = jText1.getText();
                    if (jText2.isEditable()){
                        col = "NOME";
                        val ="'" + jText2.getText() + "'";
                        DBproject.upd(tab, col, val, index, id);
                    }
                    if (jText3.isEditable()){
                        col = "COGNOME";
                        val = "'" + jText3.getText() + "'";
                        DBproject.upd(tab, col, val, index, id);                    
                    }
                    if (jText4.isEditable()){
                        col = "`NAZIONALITA";
                        val ="'" + jText4.getText() + "'";
                        DBproject.upd(tab, col, val, index, id);                    
                    }
                    if (jText5.isEditable()){
                        col = "DATANASCITA";
                        val = "DATE '" + jText5.getText() + "'";
                        DBproject.upd(tab, col, val, index, id);                    
                    }
                    if(jText6.isEditable()){
                        col = "IDSQUADRA";
                        val = jText6.getText();
                        DBproject.upd(tab, col, val, index, id);
                    }
                    if(box.getSelectedItem().toString() != jTable1.getValueAt(jTable1.getSelectedRow(), 7).toString()){
                        col = "PROFESSIONE";
                        val = "'" + box.getSelectedItem().toString() + "'";
                        DBproject.upd(tab, col, val, index, id);
                    }
                    try {
                        ResultSet rs;
                        rs=DBproject.modStaff(this);
                        jTable1.setModel (new VistaTabelle(rs));
                        pack();
                    } catch(SQLException ex) {
                        DBproject.showError(this, ex);
                    }
                    try {
                        ResultSet rs;
                        rs=DBproject.modSq(this);
                        jTable2.setModel (new VistaTabelle(rs));
                        pack();
                    } catch(SQLException ex) {
                        DBproject.showError(this, ex);
                    }
                    break;
                case 4:
                    //modifica delle partite
                    index = "IDPARTITA";
                    id = jText1.getText();
                    if (jText2.isEditable()){
                        col = "STADIO";
                        val = "'" + jText2.getText() + "'";
                        DBproject.upd(tab, col, val, index, id);
                    }
                    if (jText3.isEditable()){
                        col = "IDSQ1";
                        val = jText3.getText();
                        DBproject.upd(tab, col, val, index, id);
                    //MODIFICA ASSOCIAZIONE INCONTRI
                        String assT="INCONTRI";                        
                        col="IDSQUADRA";
                        val = jText4.getText();
                        String assContr= jText1.getText() + " AND IDSQUADRA = " + jTable1.getValueAt(jTable1.getSelectedRow(), 2).toString();
                        DBproject.upd(assT, col, val, index, assContr);
                    }
                    if (jText4.isEditable()){
                        col = "IDSQ2";
                        val = jText4.getText();
                        DBproject.upd(tab, col, val, index, id);
                    //MODIFICA ASSOCIAZIONE INCONTRI
                        String assT="INCONTRI";                        
                        col="IDSQUADRA";
                        val = jText4.getText();
                        String assContr= jText1.getText() + " AND IDSQUADRA = " + jTable1.getValueAt(jTable1.getSelectedRow(), 3).toString();
                        DBproject.upd(assT, col, val, index, assContr);
                    }
                    if (jText5.isEditable()){
                        col = "DATA";
                        val = "DATE '" + jText5.getText() + "'";
                        DBproject.upd(tab, col, val, index, id);                    
                    }
                    if(box.getSelectedItem().toString() == "Torneo ad Eliminazione" && jText6.isEditable()){
                        col = "IDTORNEOE";
                        val = jText6.getText();
                        DBproject.upd(tab, col, val, index, id);
                    }else if(box.getSelectedItem().toString() == "Torneo a Gironi" && jText6.isEditable()){
                        col = "IDTORNEOG";
                        val = jText6.getText();
                        DBproject.upd(tab, col, val, index, id);
                    }
                    try {
                        ResultSet rs;
                        rs=DBproject.modPar(this);
                        jTable1.setModel (new VistaTabelle(rs));
                        pack();
                    } catch(SQLException ex) {
                        DBproject.showError(this, ex);
                    }
                    try {
                        ResultSet rs;
                        rs=DBproject.modSq(this);
                        jTable2.setModel (new VistaTabelle(rs));
                        pack();
                    } catch(SQLException ex) {
                        DBproject.showError(this, ex);
                    }
                    break;
                case 5:        
                    //modifica torneo a gironi
                    id = jText1.getText();
                    index = "IDTORNEOG";
                    id = jText1.getText();
                    if (jText2.isEditable()){
                        col = "STAGIONE";
                        val = "'" + jText2.getText() + "'";
                        DBproject.upd(tab, col, val, index, id);
                    }
                    if (jText3.isEditable()){
                        col = "NOME";
                        val = "'" + jText3.getText() + "'";
                        DBproject.upd(tab, col, val, index, id);
                    }
                    try {
                        ResultSet rs;
                        rs=DBproject.modTg(this);
                        jTable1.setModel (new VistaTabelle(rs));
                        pack();
                    } catch(SQLException ex) {
                        DBproject.showError(this, ex);
                    }
                    try {
                        ResultSet rs;
                        rs=DBproject.modSq(this);
                        jTable2.setModel (new VistaTabelle(rs));
                        pack();
                    } catch(SQLException ex) {
                        DBproject.showError(this, ex);
                    }
                    break;
                case 6:     
                    //modifica torneo ad eliminazione
                    id = jText1.getText();
                    index = "IDTORNEOE";
                    id = jText1.getText();
                    if (jText2.isEditable()){
                        col = "STAGIONE";
                        val = "'" + jText2.getText() + "'";
                        DBproject.upd(tab, col, val, index, id);
                    }
                    if (jText3.isEditable()){
                        col = "NOMETORNEOE";
                        val = "'" + jText3.getText() + "'";
                        DBproject.upd(tab, col, val, index, id);
                    }
                    try {
                        ResultSet rs;
                        rs=DBproject.modTe(this);
                        jTable1.setModel (new VistaTabelle(rs));
                        pack();
                    } catch(SQLException ex) {
                        DBproject.showError(this, ex);
                    }
                    try {
                        ResultSet rs;
                        rs=DBproject.modSq(this);
                        jTable2.setModel (new VistaTabelle(rs));
                        pack();
                    } catch(SQLException ex) {
                        DBproject.showError(this, ex);
                    }
                    break;
            }
            JOptionPane.showMessageDialog(null, "Aggiornamento riuscito");
        }   catch (SQLException ex) {
                DBproject.showError(this, ex);
            }
    }//GEN-LAST:event_jButton2ActionPerformed

    //TASTO PER L'ELIMINAZIONE DI UN ELEMENTO
    private void jButton3ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButton3ActionPerformed
        int option = JOptionPane.showConfirmDialog(null, "Sei sicuro di voler eliminare l'elemento?", "Avviso", JOptionPane.YES_NO_OPTION);
        if (option == 0) { 
           String tab = searchTab();
           String cond = searchCond();
           try {
               DBproject.del(this,tab,cond,jText1.getText());
               //ELIMINAZIONE DI EVENTUALI ASSOCIAZIONI
                if ("SQUADRA".equals(tab)){
                    tab="SQUADRA_GIOCATORI";
                    cond="IDSQUADRA = ";
                    DBproject.del(this,tab,cond,jText1.getText());
                }else if ("GIOCATORE".equals(tab)){
                    tab="SQUADRA_GIOCATORI";
                    cond="IDGIOCATORE = ";
                    DBproject.del(this,tab,cond,jText1.getText());
                }else if ("TORNEO GIRONI".equals((String)selTab.getSelectedItem())){
                    tab="PARTECIPANTI_GIRONI";
                    cond="IDTORNEOG = ";
                    DBproject.del(this,tab,cond,jText1.getText());
                }else if ("TORNEO ELIMINAZIONE".equals((String)selTab.getSelectedItem())){
                    tab="PARTECIPANTI_ELIMINAZIONE";
                    cond="IDTORNEOE = ";
                    DBproject.del(this,tab,cond,jText1.getText());
                }
                switch (selTab.getSelectedIndex()){
                    case 0:
                        try {
                            ResultSet rs;
                            rs=DBproject.modEv(this);
                            jTable1.setModel (new VistaTabelle(rs));
                            pack();
                        } catch(SQLException ex) {
                            DBproject.showError(this, ex);
                        }
                        try {
                            ResultSet rs;
                            rs=DBproject.modGioc(this);
                            jTable2.setModel (new VistaTabelle(rs));
                            pack();
                        } catch(SQLException ex) {
                            DBproject.showError(this, ex);
                        }
                        break;
                    case 1:
                        try {
                        ResultSet rs;
                        rs=DBproject.modSq(this);
                        jTable1.setModel (new VistaTabelle(rs));
                        pack();
                        } catch(SQLException ex) {
                            DBproject.showError(this, ex);
                        }
                        try {
                            ResultSet rs;
                            rs=DBproject.modGioc(this);
                            jTable2.setModel (new VistaTabelle(rs));
                            pack();
                        } catch(SQLException ex) {
                            DBproject.showError(this, ex);
                        }
                        break;
                    case 2:
                        try {
                            ResultSet rs;
                            rs=DBproject.modGioc(this);
                            jTable1.setModel (new VistaTabelle(rs));
                            pack();
                        } catch(SQLException ex) {
                            DBproject.showError(this, ex);
                        }
                        try {
                            ResultSet rs;
                            rs=DBproject.modSq(this);
                            jTable2.setModel (new VistaTabelle(rs));
                            pack();
                        } catch(SQLException ex) {
                            DBproject.showError(this, ex);
                        }  
                        break;
                    case 3:
                        try {
                            ResultSet rs;
                            rs=DBproject.modStaff(this);
                            jTable1.setModel (new VistaTabelle(rs));
                            pack();
                        } catch(SQLException ex) {
                            DBproject.showError(this, ex);
                        }
                        try {
                            ResultSet rs;
                            rs=DBproject.modSq(this);
                            jTable2.setModel (new VistaTabelle(rs));
                            pack();
                        } catch(SQLException ex) {
                            DBproject.showError(this, ex);
                        }
                        break;
                    case 4:
                        try {
                            ResultSet rs;
                            rs=DBproject.modPar(this);
                            jTable1.setModel (new VistaTabelle(rs));
                            pack();
                        } catch(SQLException ex) {
                            DBproject.showError(this, ex);
                        }
                        try {
                            ResultSet rs;
                            rs=DBproject.modSq(this);
                            jTable2.setModel (new VistaTabelle(rs));
                            pack();
                        } catch(SQLException ex) {
                            DBproject.showError(this, ex);
                        }
                        break;
                    case 5:                    
                        try {
                            ResultSet rs;
                            rs=DBproject.modTg(this);
                            jTable1.setModel (new VistaTabelle(rs));
                            pack();
                        } catch(SQLException ex) {
                            DBproject.showError(this, ex);
                        }
                        try {
                            ResultSet rs;
                            rs=DBproject.modSq(this);
                            jTable2.setModel (new VistaTabelle(rs));
                            pack();
                        } catch(SQLException ex) {
                            DBproject.showError(this, ex);
                        }
                        break;
                    case 6:                    
                        try {
                            ResultSet rs;
                            rs=DBproject.modTe(this);
                            jTable1.setModel (new VistaTabelle(rs));
                            pack();
                        } catch(SQLException ex) {
                            DBproject.showError(this, ex);
                        }
                        try {
                            ResultSet rs;
                            rs=DBproject.modSq(this);
                            jTable2.setModel (new VistaTabelle(rs));
                            pack();
                        } catch(SQLException ex) {
                            DBproject.showError(this, ex);
                        }
                        break;
                }
           } catch (SQLException ex) {
               DBproject.showError(this, ex);
           }
           
        } 
    }//GEN-LAST:event_jButton3ActionPerformed

    /**
     * @param args the command line arguments
     */
    public static void main(String args[]) {
        /* Set the Nimbus look and feel */
        //<editor-fold defaultstate="collapsed" desc=" Look and feel setting code (optional) ">
        /* If Nimbus (introduced in Java SE 6) is not available, stay with the default look and feel.
         * For details see http://download.oracle.com/javase/tutorial/uiswing/lookandfeel/plaf.html 
         */
        try {
            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {
                if ("Nimbus".equals(info.getName())) {
                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (ClassNotFoundException ex) {
            java.util.logging.Logger.getLogger(Modifica.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(Modifica.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(Modifica.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(Modifica.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new Modifica().setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JComboBox<String> box;
    private javax.swing.JButton jButton1;
    private javax.swing.JButton jButton2;
    private javax.swing.JButton jButton3;
    private javax.swing.JComboBox<String> jComboBoxTipo;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JScrollPane jScrollPane2;
    private javax.swing.JTable jTable1;
    private javax.swing.JTable jTable2;
    private javax.swing.JTextField jText1;
    private javax.swing.JTextField jText2;
    private javax.swing.JTextField jText3;
    private javax.swing.JTextField jText4;
    private javax.swing.JTextField jText5;
    private javax.swing.JTextField jText6;
    private javax.swing.JComboBox<String> selTab;
    // End of variables declaration//GEN-END:variables
}
