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
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JFrame;
import javax.swing.JOptionPane;

/**
 *
 * @author Andrtea
 */
public class Insert extends javax.swing.JFrame {

    /**
     * Creates new form Inserimento
     */
    public Insert() {
        //LA CLASSE SI OCCUPA DI TUTTI GLI INSERIMENTI DI NUOVI ELEMENTI NEL DATABASE
        initComponents();
        setLocationRelativeTo(null);
        //AGGIUNTA DEI LISTNER PER I COMBOBOX    
        selTab.addItemListener((ItemEvent e) -> {
            if(e.getStateChange()==ItemEvent.SELECTED){
                selTabElements();
            }
        });
        box.addItemListener((ItemEvent e) -> {
            if(e.getStateChange()==ItemEvent.SELECTED){
                boxElements();
            }
        });
        jComboBoxTipo.addItemListener((ItemEvent e) -> {
            if(e.getStateChange()==ItemEvent.SELECTED){
                tipoElements();
            }
        });
        jTable2.setShowGrid(false);
        jTable1.setShowGrid(false);
        selTabElements();
    }
    
    
    //IL SEGUENTE METODO VIENE UTILIZZATO PER LA CREAZIONE DELLA STRINGA COLONNE, LA QUALE VERRÀ INVIATA 
    //NELLA FUNZIONE insert CONTENUTA NELLA CLASSE DBproject.java PER IL POPOLAMENTO DEL DATABASE
    String colonne;
    private void selTabElements(){
        ResultSet rs;
        Integer ID = null;
        colonne="(";
        jText1.setText("");
        jLabel2.setVisible(false);
        jText1.setEditable(true);
        jText2.setText("");
        jText3.setText("");
        jText4.setText("");
        jComboBoxTipo.setVisible(false);
        jText5.setText("");
        jText6.setText("");
        switch(selTab.getSelectedIndex()){
            case 0:
                jText1.setVisible(false);
                jText2.setVisible(false);
                jText3.setVisible(false);
                jText4.setVisible(false);
                jText5.setVisible(false);
                jText6.setVisible(false);
                box.setVisible(false);
                jButton3.setVisible(false);
                break;
            case 1:
                //eventi
                try {
                    rs=DBproject.risPart(this);
                    jTable1.setModel (new VistaTabelle(rs));
                    pack();
                } catch(SQLException ex) {
                    DBproject.showError(this, ex);
                }
                try {
                    rs=DBproject.ricSqT(this, "club");
                    jTable2.setModel (new VistaTabelle(rs));
                    pack();
                } catch(SQLException ex) {
                    DBproject.showError(this, ex);
                }
                
                jText1.setVisible(true);
                jText1.setBorder(javax.swing.BorderFactory.createTitledBorder("IDevento"));
                colonne+="IDEVENTO, ";
                try {
                        ID = DBproject.calcMax("EVENTI", "IDEVENTO");
                    } catch (SQLException ex) {
                        DBproject.showError(this, ex);
                    }
                if(!"".equals(jText1.getText())){
                    if (ID < Integer.parseInt(jText1.getText())){
                        jText1.setText(Integer.toString(ID));
                    }else{
                        jText1.setText(Integer.toString(ID+1));
                    }
                }else{
                    jText1.setText(Integer.toString(ID+1));
                }

                jText1.setEditable(false);
                jText2.setVisible(true);
                jText2.setBorder(javax.swing.BorderFactory.createTitledBorder("IDpartita"));
                jText2.setEditable(false);
                colonne+="IDPARTITA, ";                
                jText3.setVisible(true);
                jText3.setBorder(javax.swing.BorderFactory.createTitledBorder("Minuto"));
                jText3.setEditable(true);
                colonne+="MINUTO, ";
                jText4.setVisible(true);
                jText4.setBorder(javax.swing.BorderFactory.createTitledBorder("IDgiocatore"));
                jText4.setEditable(false);
                colonne+="IDGIOCATORE, ";
                jText5.setVisible(false);
                jText6.setVisible(false);
                box.setVisible(true);
                box.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "", "Goal", "Tiri", "CartellinoG", "CartellinoR", "Fuorigioco", "Assist", "TiroInPorta" }));
                box.setBorder(javax.swing.BorderFactory.createTitledBorder("Evento"));
                colonne+="EVENTO";
                jButton3.setVisible(true);
                break;
            case 2:
                //Squadra
                try {
                    rs=DBproject.ricSqT(this, "club");
                    jTable1.setModel (new VistaTabelle(rs));
                    pack();
                } catch(SQLException ex) {
                    DBproject.showError(this, ex);
                }
                try {
                    rs=DBproject.ricAllGioc(this, "GOAL");
                    jTable2.setModel (new VistaTabelle(rs));
                    pack();
                } catch(SQLException ex) {
                    DBproject.showError(this, ex);
                }
                jText1.setVisible(true);
                jText1.setBorder(javax.swing.BorderFactory.createTitledBorder("IDsquadra"));
                colonne+="IDSQUADRA, ";
                try {
                        ID = DBproject.calcMax("SQUADRA", "IDSQUADRA") + 1;
                } catch (SQLException ex) {
                    DBproject.showError(this, ex);
                }
                jText1.setText(Integer.toString(ID));
                jText1.setEditable(false);
                jText2.setVisible(true);
                jText2.setBorder(javax.swing.BorderFactory.createTitledBorder("Nome"));
                jText2.setEditable(true);
                colonne+="NOME, ";
                jText3.setVisible(false);
                jText4.setVisible(false);
                jText5.setVisible(false);
                jText6.setVisible(false);
                box.setVisible(true);
                box.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "", "club", "nazionale"}));
                colonne+="TIPO";
                box.setBorder(javax.swing.BorderFactory.createTitledBorder("Tipo Squadra"));
                jButton3.setVisible(false);
                break;
            case 3:
                //Giocatore
                jComboBoxTipo.setVisible(true);
                String tipo=(String) jComboBoxTipo.getSelectedItem();
                try {
                    rs=DBproject.ricSqT(this, tipo);
                    jTable1.setModel (new VistaTabelle(rs));
                    pack();
                } catch(SQLException ex) {
                    DBproject.showError(this, ex);
                }
                try {
                    rs=DBproject.ricAllGioc(this, "GOAL");
                    jTable2.setModel (new VistaTabelle(rs));
                    pack();
                } catch(SQLException ex) {
                    DBproject.showError(this, ex);
                }
                
                jText1.setVisible(true);
                jText1.setBorder(javax.swing.BorderFactory.createTitledBorder("IDgiocatore"));
                colonne+="IDGIOCATORE, ";
                try {
                        ID = DBproject.calcMax("GIOCATORE", "IDGIOCATORE") + 1;
                    } catch (SQLException ex) {
                        DBproject.showError(this, ex);
                    }
                jText1.setText(Integer.toString(ID));
                jText1.setEditable(false);
                jText2.setVisible(true);
                jText2.setEditable(true);
                jText2.setBorder(javax.swing.BorderFactory.createTitledBorder("Nome"));
                colonne+="NOME, ";
                jText3.setVisible(true);
                jText3.setEditable(true);
                jText3.setBorder(javax.swing.BorderFactory.createTitledBorder("Cognome"));
                colonne+="COGNOME, ";
                jText6.setVisible(true);
                jText6.setEditable(true);
                jText6.setBorder(javax.swing.BorderFactory.createTitledBorder("ID squadra di riferimento"));
                jText6.setEditable(false);
                box.setVisible(true);
                box.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "", "portiere", "difensore", "centrocampista", "attaccante"}));
                box.setBorder(javax.swing.BorderFactory.createTitledBorder("Ruolo"));
                colonne+="RUOLO";
                jButton3.setVisible(false);
                break;
            case 4:
                //staff                
                jComboBoxTipo.setVisible(true);
                tipo=(String) jComboBoxTipo.getSelectedItem();
                try {
                    rs=DBproject.ricSqT(this, tipo);
                    jTable1.setModel (new VistaTabelle(rs));
                    pack();
                } catch(SQLException ex) {
                    DBproject.showError(this, ex);
                }
                try {
                    rs=DBproject.modStaff(this);
                    jTable2.setModel (new VistaTabelle(rs));
                    pack();
                } catch(SQLException ex) {
                    DBproject.showError(this, ex);
                }
                jText1.setVisible(true);
                jText1.setBorder(javax.swing.BorderFactory.createTitledBorder("IDstaff"));
                colonne+="IDSTAFF, ";
                try {
                        ID = DBproject.calcMax("STAFF", "IDSTAFF") + 1;
                    } catch (SQLException ex) {
                        DBproject.showError(this, ex);
                    }
                jText1.setText(Integer.toString(ID));
                jText1.setEditable(false);
                jText2.setVisible(true);
                jText2.setBorder(javax.swing.BorderFactory.createTitledBorder("Nome"));
                jText2.setEditable(true);
                colonne+="NOME, ";
                jText3.setVisible(true);
                jText3.setBorder(javax.swing.BorderFactory.createTitledBorder("Cognome"));
                jText3.setEditable(true);
                colonne+="COGNOME, ";
                jText4.setVisible(true);
                jText4.setBorder(javax.swing.BorderFactory.createTitledBorder("Luogo di Nascita"));
                jText4.setEditable(true);
                colonne+="LUOGO_NASCITA, ";
                jText5.setVisible(true);
                jText5.setBorder(javax.swing.BorderFactory.createTitledBorder("Data di Nascita (aaaa-mm-gg)"));
                jText5.setEditable(true);
                colonne+="DATANASCITA, ";
                jText6.setVisible(true);
                jText6.setBorder(javax.swing.BorderFactory.createTitledBorder("IDsquadra"));
                jText6.setEditable(false);
                colonne+="IDSQUADRA, ";
                box.setVisible(true);
                box.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "", "allenatore", "dirigente", "presidente"}));
                box.setBorder(javax.swing.BorderFactory.createTitledBorder("Professione"));
                colonne+="PROFESSIONE";
                jButton3.setVisible(false);
                break;
            case 5:
                //partite
                try {
                    rs=DBproject.elTg(this);
                    jTable1.setModel (new VistaTabelle(rs));
                    pack();
                } catch(SQLException ex) {
                    DBproject.showError(this, ex);
                }
                jComboBoxTipo.setVisible(true);
                tipo=(String) jComboBoxTipo.getSelectedItem();
                try {
                    rs=DBproject.ricSqT(this, tipo);
                    jTable2.setModel (new VistaTabelle(rs));
                    pack();
                } catch(SQLException ex) {
                    DBproject.showError(this, ex);
                }
                jText1.setVisible(true);
                jText1.setBorder(javax.swing.BorderFactory.createTitledBorder("IDpartita"));
                colonne+="IDPARTITA, ";
                try {
                        ID = DBproject.calcMax("PARTITA", "IDPARTITA") + 1;
                    } catch (SQLException ex) {
                        DBproject.showError(this, ex);
                    }
                jText1.setText(Integer.toString(ID));
                jText1.setEditable(false);
                jText2.setVisible(true);
                jText2.setBorder(javax.swing.BorderFactory.createTitledBorder("Stadio"));
                jText2.setEditable(true);
                colonne+="STADIO, ";
                jText3.setVisible(true);
                jText3.setBorder(javax.swing.BorderFactory.createTitledBorder("IDsquadra 1"));
                jText3.setEditable(false);
                colonne+="IDSQ1, ";
                jText4.setVisible(true);
                jText4.setBorder(javax.swing.BorderFactory.createTitledBorder("IDsquadra 2"));
                jText4.setEditable(false);
                colonne+="IDSQ2, ";
                jText5.setVisible(true);
                jText5.setBorder(javax.swing.BorderFactory.createTitledBorder("Data (aaaa-mm-gg)"));
                jText5.setEditable(true);
                colonne+="DATA";
                jText6.setVisible(true);
                jText6.setEditable(false);
                jText6.setBorder(javax.swing.BorderFactory.createTitledBorder("ID del torneo"));
                box.setVisible(true);
                box.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "Amichevole", "Torneo a Gironi", "Torneo ad Eliminazione"}));
                box.setBorder(javax.swing.BorderFactory.createTitledBorder("Tipo di Torneo"));
                jButton3.setVisible(false);
                break;
            case 6:
                //torneo gironi
                try {
                    rs=DBproject.ricSqT(this, "club");
                    jTable2.setModel (new VistaTabelle(rs));
                    pack();
                } catch(SQLException ex) {
                    DBproject.showError(this, ex);
                }
                try {
                    rs=DBproject.modTg(this);
                    jTable1.setModel (new VistaTabelle(rs));
                    pack();
                } catch(SQLException ex) {
                    DBproject.showError(this, ex);
                }
                try {
                    ID = DBproject.calcMax("TORNEO_GIRONI", "IDTORNEOG") + 1;
                } catch (SQLException ex) {
                    DBproject.showError(this, ex);
                }
                jText1.setText(ID.toString());
                jText1.setVisible(true);
                jText1.setEditable(false);
                jText1.setBorder(javax.swing.BorderFactory.createTitledBorder("IDtorneo girone"));
                colonne+="IDTORNEOG, ";
                jText2.setVisible(true);
                jText2.setBorder(javax.swing.BorderFactory.createTitledBorder("Stagione"));
                jText2.setEditable(true);
                colonne+="STAGIONEG, ";
                jText3.setVisible(true);
                jText3.setBorder(javax.swing.BorderFactory.createTitledBorder("Nome Torneo"));
                jText3.setEditable(true);
                colonne+="NOMETORNEOG";
                jText4.setVisible(false);
                jText5.setVisible(false);
                jText6.setVisible(false);
                box.setVisible(false);
                jButton3.setVisible(false);
                break;
            case 7:
                //torneo ad eliminaizone
                try {
                    rs=DBproject.ricSqT(this, "club");
                    jTable2.setModel (new VistaTabelle(rs));
                    pack();
                } catch(SQLException ex) {
                    DBproject.showError(this, ex);
                }
                try {
                    rs=DBproject.modTe(this);
                    jTable1.setModel (new VistaTabelle(rs));
                    pack();
                } catch(SQLException ex) {
                    DBproject.showError(this, ex);
                }
                try {
                        ID = DBproject.calcMax("TORNEO_ELIMINAZIONE", "IDTORNEOE") + 1;
                } catch (SQLException ex) {
                    DBproject.showError(this, ex);
                }
                jText1.setText(ID.toString());
                jText1.setEditable(false);
                jText1.setVisible(true);
                jText1.setBorder(javax.swing.BorderFactory.createTitledBorder("IDtorneo eliminazione"));
                colonne+="IDTORNEOE, ";
                jText2.setVisible(true);
                jText2.setBorder(javax.swing.BorderFactory.createTitledBorder("Stagione"));
                jText2.setEditable(true);
                colonne+="STAGIONEE, ";
                jText3.setVisible(true);
                jText3.setBorder(javax.swing.BorderFactory.createTitledBorder("Nome Torneo"));
                jText3.setEditable(true);
                colonne+="NOMETORNEOE";
                jText4.setVisible(false);
                jText5.setVisible(false);
                jText6.setVisible(false);
                box.setVisible(false);
                jButton3.setVisible(false);
                break;                
        }
    }
    
    private void boxElements(){
        if("PARTITA".equals((String)selTab.getSelectedItem())){
            ResultSet rs;
            switch (box.getSelectedIndex()){
                case 0:
                    jComboBoxTipo.setVisible(true);
                    jText6.setText("");
                    break;
                case 1:
                    jComboBoxTipo.setVisible(false);
                    try {
                        rs=DBproject.elTg(this);
                        jTable1.setModel (new VistaTabelle(rs));
                        pack();
                    } catch(SQLException ex) {
                        DBproject.showError(this, ex);
                    }
                    break;
                case 2:
                    jComboBoxTipo.setVisible(false);
                    try {
                        rs=DBproject.elTe(this);
                        jTable1.setModel (new VistaTabelle(rs));
                        pack();
                    } catch(SQLException ex) {
                        DBproject.showError(this, ex);
                    }
                    break;
            }
        }else if ("SQUADRA".equals((String)selTab.getSelectedItem())){
            ResultSet rs;
            switch (box.getSelectedIndex()){
                case 1:
                    try {
                        rs=DBproject.ricSqT(this, "club");
                        jTable1.setModel (new VistaTabelle(rs));
                        pack();
                    } catch(SQLException ex) {
                        DBproject.showError(this, ex);
                    }
                    break;
                case 2:
                    try {
                        rs=DBproject.ricSqT(this, "nazionale");
                        jTable1.setModel (new VistaTabelle(rs));
                        pack();
                    } catch(SQLException ex) {
                        DBproject.showError(this, ex);
                    }
                    break;

            }
        }
    }
    
    private void tipoElements(){
        ResultSet rs;
        String tipo= (String) jComboBoxTipo.getSelectedItem();
        try {
            if (selTab.getSelectedIndex()==5){
                rs=DBproject.ricSqT(this, tipo);
                jTable2.setModel (new VistaTabelle(rs));
                pack();
            }else {
                rs=DBproject.ricSqT(this, tipo);
                jTable1.setModel (new VistaTabelle(rs));
                pack();
            }
            
        } catch(SQLException ex) {
            DBproject.showError(this, ex);
        }
    }
    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jButton1 = new javax.swing.JButton();
        jLabel1 = new javax.swing.JLabel();
        jButton2 = new javax.swing.JButton();
        jScrollPane2 = new javax.swing.JScrollPane();
        jTable2 = new javax.swing.JTable();
        jScrollPane1 = new javax.swing.JScrollPane();
        jTable1 = new javax.swing.JTable();
        jPanel1 = new javax.swing.JPanel();
        jText5 = new javax.swing.JTextField();
        box = new javax.swing.JComboBox<>();
        selTab = new javax.swing.JComboBox<>();
        jText3 = new javax.swing.JTextField();
        jText2 = new javax.swing.JTextField();
        jText6 = new javax.swing.JTextField();
        jLabel2 = new javax.swing.JLabel();
        jText4 = new javax.swing.JTextField();
        jText1 = new javax.swing.JTextField();
        jComboBoxTipo = new javax.swing.JComboBox<>();
        jButton3 = new javax.swing.JButton();

        setDefaultCloseOperation(javax.swing.WindowConstants.DISPOSE_ON_CLOSE);

        jButton1.setText("Inserisci");
        jButton1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButton1ActionPerformed(evt);
            }
        });

        jLabel1.setFont(new java.awt.Font("Tahoma", 3, 18)); // NOI18N
        jLabel1.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        jLabel1.setText("Inserimento");

        jButton2.setText("Annulla/Fine");
        jButton2.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButton2ActionPerformed(evt);
            }
        });

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
        jTable2.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                jTable2MouseClicked(evt);
            }
        });
        jScrollPane2.setViewportView(jTable2);

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

        jText5.setHorizontalAlignment(javax.swing.JTextField.LEFT);
        jText5.setBorder(javax.swing.BorderFactory.createTitledBorder("Nazionalità"));

        box.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "", "'allenatore'", "'dirigente'", "'presidente'" }));
        box.setBorder(javax.swing.BorderFactory.createTitledBorder("Professione"));
        box.addItemListener(new java.awt.event.ItemListener() {
            public void itemStateChanged(java.awt.event.ItemEvent evt) {
                boxItemStateChanged(evt);
            }
        });

        selTab.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "", "EVENTO", "SQUADRA", "GIOCATORE", "MEMBRO STAFF", "PARTITA", "TORNEO GIRONI", "TORNEO ELIMINAZIONE" }));
        selTab.setSelectedIndex(1);
        selTab.setBorder(javax.swing.BorderFactory.createTitledBorder("Scegliere cosa Inserire"));
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

        jText2.setHorizontalAlignment(javax.swing.JTextField.RIGHT);
        jText2.setBorder(javax.swing.BorderFactory.createTitledBorder("Cognome"));
        jText2.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jText2ActionPerformed(evt);
            }
        });

        jText6.setBorder(javax.swing.BorderFactory.createTitledBorder("IDsquadra"));
        jText6.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jText6ActionPerformed(evt);
            }
        });

        jLabel2.setFont(new java.awt.Font("Tahoma", 0, 16)); // NOI18N
        jLabel2.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        jLabel2.setText("jLabel2");

        jText4.setHorizontalAlignment(javax.swing.JTextField.RIGHT);
        jText4.setBorder(javax.swing.BorderFactory.createTitledBorder("Luogo di nascita"));

        jText1.setHorizontalAlignment(javax.swing.JTextField.LEFT);
        jText1.setBorder(javax.swing.BorderFactory.createTitledBorder("Nome"));

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
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addComponent(selTab, javax.swing.GroupLayout.PREFERRED_SIZE, 201, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(jText6, javax.swing.GroupLayout.PREFERRED_SIZE, 211, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(jText4, javax.swing.GroupLayout.PREFERRED_SIZE, 211, javax.swing.GroupLayout.PREFERRED_SIZE)))
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addComponent(jText5, javax.swing.GroupLayout.PREFERRED_SIZE, 201, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(box, javax.swing.GroupLayout.PREFERRED_SIZE, 210, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(jComboBoxTipo, javax.swing.GroupLayout.PREFERRED_SIZE, 210, javax.swing.GroupLayout.PREFERRED_SIZE)))
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addComponent(jText1, javax.swing.GroupLayout.PREFERRED_SIZE, 201, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(jText2, javax.swing.GroupLayout.PREFERRED_SIZE, 210, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addComponent(jText3, javax.swing.GroupLayout.PREFERRED_SIZE, 201, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jLabel2, javax.swing.GroupLayout.PREFERRED_SIZE, 418, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addContainerGap())
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
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addComponent(jLabel2, javax.swing.GroupLayout.PREFERRED_SIZE, 41, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap())
        );

        jButton3.setText("Riepilogo Partita");
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
                    .addComponent(jLabel1, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                            .addGroup(layout.createSequentialGroup()
                                .addComponent(jButton2)
                                .addGap(72, 72, 72)
                                .addComponent(jButton3)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                .addComponent(jButton1))
                            .addComponent(jPanel1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                            .addComponent(jScrollPane2, javax.swing.GroupLayout.DEFAULT_SIZE, 475, Short.MAX_VALUE)
                            .addComponent(jScrollPane1))))
                .addContainerGap())
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jLabel1, javax.swing.GroupLayout.PREFERRED_SIZE, 31, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 145, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(18, 18, 18)
                        .addComponent(jScrollPane2, javax.swing.GroupLayout.PREFERRED_SIZE, 187, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addComponent(jPanel1, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                .addGap(18, 18, 18)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jButton1)
                    .addComponent(jButton2)
                    .addComponent(jButton3))
                .addContainerGap())
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents
    
    private void jButton1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButton1ActionPerformed
        //seclta della tabella  e delle colonne
            String tab=searchTab();
            String col=colonne;
            //verifica se è una partita di un torneo o un'amichevole
            if("PARTITA".equals((String)selTab.getSelectedItem())){
                Integer index = box.getSelectedIndex();
                if (index == 1){
                    col+=", IDTORNEOG";
                }
                if (index == 2){
                    col+=", IDTORNEOE";
                    col+=", NUMERO_TURNO_TORNEO";
                }       
            }
            col+=")";
            String val;
            //ricerca dei valori
            val=createValues();
            try {
                //in caso di creazione tornei si entra nella classe InsTornei.java
                if("TORNEO GIRONI".equals((String)selTab.getSelectedItem())){
                    InsTornei tg = new InsTornei ();
                    tg.colonne="(IDTORNEOG, IDSQUADRA)";
                    tg.valori="('" + jText1.getText() + "', ";
                    tg.tabella="PARTECIPANTI_GIRONI";
                    tg.tab=tab;
                    tg.col=col;
                    tg.val=val;
                    tg.setVisible(true);
                    Integer index = Integer.parseInt(jText1.getText()) +1;
                    jText1.setText(index.toString());
                }else if("TORNEO ELIMINAZIONE".equals((String)selTab.getSelectedItem())){
                    InsTornei tg = new InsTornei ();
                    tg.colonne="(IDTORNEOE, IDSQUADRA)";
                    tg.valori="('" + jText1.getText() + "', ";
                    tg.tabella="PARTECIPANTI_ELIMINAZIONE";
                    tg.tab=tab;
                    tg.col=col;
                    tg.val=val;
                    tg.setVisible(true);
                    Integer index = Integer.parseInt(jText1.getText()) +1;
                    jText1.setText(index.toString());
                }else{
                    if ("PARTITA".equals((String)selTab.getSelectedItem())){
                        if(jText3.getText().equals(jText4.getText())){
                            JOptionPane.showMessageDialog(null, "ATTENZIONE!\nGli ID delle Squadre devono essere diversi");
                        }else {
                            DBproject.insert(tab, col, val);
                        }
                    }else{
                        DBproject.insert(tab, col, val);
                        //popolamento dell'associazione SQUADRA_GIOCATORI
                        if ("GIOCATORE".equals((String)selTab.getSelectedItem())){
                            tab="SQUADRA_GIOCATORI";
                            col="(IDSQUADRA, IDGIOCATORE)";
                            Integer ID = DBproject.calcMax("GIOCATORE", "IDGIOCATORE");
                            val="('" + jText6.getText() + "', '" + ID + "')";
                            DBproject.insert(tab, col, val);
                        }
                    }
                    //INCREMENTO DELL'ID PER IL SUCCESSIVO INSERIMENTO
                        Integer index = Integer.parseInt(jText1.getText()) +1;
                        jText1.setText(index.toString());
                    JOptionPane.showMessageDialog(null, "Inserimento Eseguito");
                }
            }catch (SQLException ex) {
                DBproject.showError(this, ex);
            }
            
            //AGGIORNAMENTO IN TEMPO REALE DEGLI EVENTI E DELLE STATISTICHE
            if("EVENTO".equals((String)selTab.getSelectedItem())){
                ResultSet rs;
                try {
                    rs=DBproject.risPart(this);
                    jTable1.setModel (new VistaTabelle(rs));
                    pack();
                } catch(SQLException ex) {
                    DBproject.showError(this, ex);
                }
            }
    }//GEN-LAST:event_jButton1ActionPerformed
    
    //Funzione responsabile del prelievo delle informazioni dai campi di testo
    private String createValues(){
        String values="(";
        if(jText1.isVisible())
            values+="'" + jText1.getText() + "'";
        if(jText2.isVisible())
            values+=", '" + jText2.getText() + "'";
        if(jText3.isVisible())
            values+=", '" + jText3.getText() + "'";
        if(jText4.isVisible())
            values+=", '" + jText4.getText() + "'";
        if(jText5.isVisible()){
            if (selTab.getSelectedIndex()>2 && selTab.getSelectedIndex()<6){
                values+=", DATE '" + jText5.getText() + "'";
            }
        }
        if(jText6.isVisible()){
            if(!"GIOCATORE".equals((String)selTab.getSelectedItem()) && !"".equals(jText6.getText())){
                values+=", '" + jText6.getText() + "'";
            }
        }
        if (box.isVisible() && !"".equals((String)box.getSelectedItem())){
            if(!"PARTITA".equals((String)selTab.getSelectedItem())){
                values+=", '" + (String)box.getSelectedItem() + "'";
            }
        }
        if (box.getSelectedIndex() == 2){
            //GENERAZIONE DEL NUMERO TURNO
            if (!"".equals(jText6.getText()) && "PARTITA".equals((String)selTab.getSelectedItem())){
                Integer num=null;
                try {
                    num=DBproject.numT(this, Integer.parseInt(jText6.getText()));
                } catch (SQLException ex) {
                    Logger.getLogger(Insert.class.getName()).log(Level.SEVERE, null, ex);
                }
                values+=", '" + num + "'";
            }
        }
        values+=")";
        return values;        
    }
    
    //Funzione che si occupa della ricerca della tabella da riempire
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
    
    private void selTabActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_selTabActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_selTabActionPerformed

    
    private void selTabItemStateChanged(java.awt.event.ItemEvent evt) {//GEN-FIRST:event_selTabItemStateChanged
        
    }//GEN-LAST:event_selTabItemStateChanged

    private void jButton2ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButton2ActionPerformed
        dispose();
    }//GEN-LAST:event_jButton2ActionPerformed

    private void boxItemStateChanged(java.awt.event.ItemEvent evt) {//GEN-FIRST:event_boxItemStateChanged
        
    }//GEN-LAST:event_boxItemStateChanged

    private void jText6ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jText6ActionPerformed
        
    }//GEN-LAST:event_jText6ActionPerformed

    private void jComboBoxTipoItemStateChanged(java.awt.event.ItemEvent evt) {//GEN-FIRST:event_jComboBoxTipoItemStateChanged
        
    }//GEN-LAST:event_jComboBoxTipoItemStateChanged

    private void jText2ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jText2ActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_jText2ActionPerformed

    private void jTable1MouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_jTable1MouseClicked
        Integer row;
        Integer column;
        ResultSet rs;
        try {
            switch(selTab.getSelectedIndex()){
                case 1:
                    row = jTable1.getSelectedRow();
                    rs = DBproject.partPart(Integer.parseInt(jTable1.getValueAt(row, 5).toString()),Integer.parseInt(jTable1.getValueAt(row, 6).toString()));
                    jTable2.setModel (new VistaTabelle(rs));
                    pack();
                    jText2.setText(jTable1.getValueAt(row, 0).toString());
                    break;
                case 3:
                    row = jTable1.getSelectedRow();
                    column = 0;
                    jText6.setText(jTable1.getValueAt(row, column).toString());
                    break;
                case 4:
                    row = jTable1.getSelectedRow();
                    column = 0;
                    jText6.setText(jTable1.getValueAt(row, column).toString());
                    break;
                case 5:
                    row = jTable1.getSelectedRow();
                    column = 0;
                    if (box.getSelectedIndex()==1){
                        rs=DBproject.partTornei(true, Integer.parseInt(jTable1.getValueAt(row, column).toString()));
                        jTable2.setModel (new VistaTabelle(rs));
                        pack();
                        jText6.setText(jTable1.getValueAt(row, column).toString());
                    }else if (box.getSelectedIndex()==2){
                        rs=DBproject.partTornei(false, Integer.parseInt(jTable1.getValueAt(row, column).toString()));
                        jTable2.setModel (new VistaTabelle(rs));
                        pack();                    
                        jText6.setText(jTable1.getValueAt(row, column).toString());
                    }
                    break;
            }
        }catch(SQLException ex) {
            DBproject.showError(this, ex);
        }
    }//GEN-LAST:event_jTable1MouseClicked
    
    Boolean jump=false;
    private void jTable2MouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_jTable2MouseClicked
        Integer row;
        ResultSet rs;
            switch(selTab.getSelectedIndex()){
                case 1:
                    row = jTable2.getSelectedRow();
                    jText4.setText(jTable2.getValueAt(row, 1).toString());
                    break;
                case 5:
                    row = jTable2.getSelectedRow();
                    if ("".equals(jText3.getText())){
                        jText3.setText(jTable2.getValueAt(row, 0).toString());
                    }else if ("".equals(jText4.getText())){
                        jText4.setText(jTable2.getValueAt(row, 0).toString());
                    }else if(!"".equals(jText3.getText()) && jump == false){
                        jText3.setText(jTable2.getValueAt(row, 0).toString());
                        jump=true;
                    }else /*if(!"".equals(jText3.getText()) && jump == true)*/{
                        jText4.setText(jTable2.getValueAt(row, 0).toString());
                        jump=false;
                    }
                    break;
            }
    }//GEN-LAST:event_jTable2MouseClicked

    private void jButton3ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButton3ActionPerformed
        if(selTab.getSelectedIndex() == 1 && !"".equals(jText2.getText())){
            DettEventi de = new DettEventi ();
            ResultSet rs;
            try {
                Integer idpartita= Integer.parseInt(jText2.getText());
                rs=DBproject.dettEv(this, idpartita);
                de.jTable2.setModel (new VistaTabelle(rs));
                pack();
                String ris = DBproject.risultatoSingolo(this, idpartita);
                de.jLabel2.setText(ris);
                de.setVisible(true);
            } catch (SQLException ex) {
                Logger.getLogger(Insert.class.getName()).log(Level.SEVERE, null, ex);
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
                if ("Windows".equals(info.getName())) {
                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (ClassNotFoundException ex) {
            java.util.logging.Logger.getLogger(Insert.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(Insert.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(Insert.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(Insert.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(() -> {
            new Insert().setVisible(true);
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JComboBox<String> box;
    private javax.swing.JButton jButton1;
    private javax.swing.JButton jButton2;
    private javax.swing.JButton jButton3;
    private javax.swing.JComboBox<String> jComboBoxTipo;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel2;
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
