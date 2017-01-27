/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dbproject;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Andrtea
 */
public class infoTornei extends javax.swing.JFrame {

    /**
     * Creates new form infoTornei
     */
    public infoTornei() throws SQLException {
        initComponents();
        jTable2.setShowGrid(false);
        jTable1.setShowGrid(false);
        jTable3.setShowGrid(false);
        setLocationRelativeTo(null);
    //Funzioni per tornei a gironi
        boxItemG();
        String cond;
        String str;
        Integer index;
        ResultSet rs;
        
        //RICERCA DELL'IDTORNEO DELLA PRIMA SELEZIONE
        str = (String) jComboBox1.getSelectedItem();
        str = str.replaceAll("[^0-9]+", "");
        index = Integer.parseInt(str);
        //CLASSIFICA PER TORNEI
        try {
            rs=DBproject.classTg(this, index);
            System.out.println("creata la prima classifica");
            jTable1.setModel (new VistaTabelle(rs));
            pack();
        } catch(SQLException ex) {
            DBproject.showError(this, ex);
        }
        //CLASSIFICA MARCATORI TORNEO A GIRONI
        try {
            cond = "IDTORNEOG = " + Integer.parseInt(str);
            rs=DBproject.classMarc(this, cond);
            jTable2.setModel (new VistaTabelle(rs));
            System.out.println("creata la classifica marcatori g");
            pack();
        } catch(SQLException ex) {
            DBproject.showError(this, ex);
        }
        
        
    //Funzioni per tornei ad eliminaizone
        boxItemE();
        str = (String) jComboBox5.getSelectedItem();
        str = str.replaceAll("[^0-9]+", "");
        index = Integer.parseInt(str);
        createScheme(index);
        try {
            cond = "IDTORNEOE = " + Integer.parseInt(str);
            rs=DBproject.classMarc(this, cond);
            jTable3.setModel (new VistaTabelle(rs));
            System.out.println("classifica marcatori e");
            pack();
        } catch(SQLException ex) {
            DBproject.showError(this, ex);
        }
        
    }
    
    private void createScheme(Integer index) throws SQLException{
        Statement createScheme;        
        String query;
        query= "SELECT IDTORNEOE, SQUADRA1, GOL1, GOL2, SQUADRA2, NUMERO_TURNO FROM VISTA_RIS_PARTITE WHERE IDTORNEOE = " + index;
        createScheme = DBproject.defaultConn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
        ResultSet result = createScheme.executeQuery(query);
        String vit1 = null;
        String vit2 = null;
        while (result.next()){
            index = result.getInt("NUMERO_TURNO"); 
            String sq1 = result.getString("SQUADRA1") + " " + result.getString("GOL1");
            vit1 = result.getString("SQUADRA1");
            String sq2 = result.getString("SQUADRA2") + " " + result.getString("GOL2");
            vit2 = result.getString("SQUADRA2");
            System.out.println(sq1 + " " + sq2 + " " + index + "\n");
            if (index == 1){
                //SQUADRE PER IL PRIMO TURNO
                //INSERIMENTO SQUADRE DI CASA
                if("".equals(jLabel10.getText()) && jLabel10.isVisible()){
                    jLabel10.setText(sq1);
                }else if("".equals(jLabel8.getText()) && jLabel8.isVisible()){
                    jLabel8.setText(sq1);
                }else if ("".equals(jLabel16.getText())){
                    jLabel16.setText(sq1);
                    System.out.println("metto l'ultima squadra");
                }
                
                //INSERIMENTO SQUADRE OSPITI
                if("".equals(jLabel12.getText()) && jLabel12.isVisible()){
                    jLabel12.setText(sq2);
                    System.out.println("ora metto gli ospiti " + sq2);
                }else if("".equals(jLabel7.getText()) && jLabel7.isVisible()){
                    jLabel7.setText(sq2);
                }else if ("".equals(jLabel15.getText())){
                    jLabel15.setText(sq2);
                }
            }else {
                //INSERIMENTO SQUADRA DI CASA
                if ("".equals(jLabel16.getText())){
                    jLabel16.setText(sq1);
                }
                //INSERIMENTO SQUADRA OSPITE
                if ("".equals(jLabel15.getText())){
                    jLabel15.setText(sq2);
                }
            }
        System.out.println("calcolo dei turni");
        }
        
        //CALCOLO DEL VINCITORE
        if (!"".equals(jLabel16.getText())){
            Integer gol1=0;
            Integer gol2=0;
            String str = jLabel16.getText();
            str = str.replaceAll("[^0-9]+", "");
            gol1 = Integer.parseInt(str);
            str = jLabel15.getText();
            str = str.replaceAll("[^0-9]+", "");
            gol2 = Integer.parseInt(str);

            if (gol1>gol2){
                jLabel13.setText(vit1);
            }else {
                jLabel13.setText(vit2);
            }
        System.out.println("vincitore calcolato");}

    }
    
    
    private void boxItemG () throws SQLException{
        Statement boxItem;
        boxItem=DBproject.defaultConn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
        ResultSet result = boxItem.executeQuery("SELECT NOMETORNEOG, IDTORNEOG FROM TORNEO_GIRONI ORDER BY IDTORNEOG DESC");
        while (result.next()){
            String ris = result.getString("NOMETORNEOG");
            ris += ", ";
            ris += result.getString("IDTORNEOG");
            System.out.println(ris);
            jComboBox1.addItem(ris);
        }
        System.out.println("creato il bo per tornei g");
    }

    private void boxItemE () throws SQLException{
        Statement boxItem;
        boxItem=DBproject.defaultConn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
        ResultSet result = boxItem.executeQuery("SELECT NOMETORNEOE, IDTORNEOE FROM TORNEO_ELIMINAZIONE");
        while (result.next()){
            String ris = result.getString("NOMETORNEOE");
            ris += ", ";
            System.out.println(ris);
            ris += result.getString("IDTORNEOE");
            System.out.println(ris);
            jComboBox5.addItem(ris);
        }
        System.out.println("creato il bo per tornei e");
    }
    
    
    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jInternalFrame1 = new javax.swing.JInternalFrame();
        jLabel1 = new javax.swing.JLabel();
        jTabbedPane1 = new javax.swing.JTabbedPane();
        jPanel1 = new javax.swing.JPanel();
        jComboBox1 = new javax.swing.JComboBox<>();
        jScrollPane1 = new javax.swing.JScrollPane();
        jTable1 = new javax.swing.JTable();
        jScrollPane2 = new javax.swing.JScrollPane();
        jTable2 = new javax.swing.JTable();
        jLabel2 = new javax.swing.JLabel();
        jComboBox3 = new javax.swing.JComboBox<>();
        jButton1 = new javax.swing.JButton();
        jPanel2 = new javax.swing.JPanel();
        jButton2 = new javax.swing.JButton();
        jLabel7 = new javax.swing.JLabel();
        jLabel8 = new javax.swing.JLabel();
        jLabel9 = new javax.swing.JLabel();
        jLabel10 = new javax.swing.JLabel();
        jLabel11 = new javax.swing.JLabel();
        jLabel12 = new javax.swing.JLabel();
        jLabel13 = new javax.swing.JLabel();
        jLabel14 = new javax.swing.JLabel();
        jLabel15 = new javax.swing.JLabel();
        jLabel16 = new javax.swing.JLabel();
        jScrollPane3 = new javax.swing.JScrollPane();
        jTable3 = new javax.swing.JTable();
        jComboBox4 = new javax.swing.JComboBox<>();
        jComboBox5 = new javax.swing.JComboBox<>();

        jInternalFrame1.setVisible(true);

        javax.swing.GroupLayout jInternalFrame1Layout = new javax.swing.GroupLayout(jInternalFrame1.getContentPane());
        jInternalFrame1.getContentPane().setLayout(jInternalFrame1Layout);
        jInternalFrame1Layout.setHorizontalGroup(
            jInternalFrame1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 0, Short.MAX_VALUE)
        );
        jInternalFrame1Layout.setVerticalGroup(
            jInternalFrame1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 0, Short.MAX_VALUE)
        );

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);

        jLabel1.setFont(new java.awt.Font("Tahoma", 3, 18)); // NOI18N
        jLabel1.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        jLabel1.setText("Informazioni sui tornei");

        jComboBox1.setBorder(javax.swing.BorderFactory.createTitledBorder("Scegli il torneo"));
        jComboBox1.addItemListener(new java.awt.event.ItemListener() {
            public void itemStateChanged(java.awt.event.ItemEvent evt) {
                jComboBox1ItemStateChanged(evt);
            }
        });
        jComboBox1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jComboBox1ActionPerformed(evt);
            }
        });

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

        jLabel2.setFont(new java.awt.Font("Tahoma", 0, 14)); // NOI18N
        jLabel2.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        jLabel2.setText("Classifica Squadre");

        jComboBox3.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "Marcatori", "Assist" }));
        jComboBox3.setBorder(javax.swing.BorderFactory.createTitledBorder("Classifiche per Giocatori"));
        jComboBox3.addItemListener(new java.awt.event.ItemListener() {
            public void itemStateChanged(java.awt.event.ItemEvent evt) {
                jComboBox3ItemStateChanged(evt);
            }
        });

        jButton1.setText("Fine");
        jButton1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButton1ActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout jPanel1Layout = new javax.swing.GroupLayout(jPanel1);
        jPanel1.setLayout(jPanel1Layout);
        jPanel1Layout.setHorizontalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(jLabel2, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jScrollPane2)
                    .addComponent(jComboBox1, javax.swing.GroupLayout.Alignment.TRAILING, 0, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addComponent(jComboBox3, javax.swing.GroupLayout.Alignment.TRAILING, 0, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel1Layout.createSequentialGroup()
                        .addGap(0, 0, Short.MAX_VALUE)
                        .addComponent(jButton1, javax.swing.GroupLayout.PREFERRED_SIZE, 88, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addComponent(jScrollPane1))
                .addContainerGap())
        );
        jPanel1Layout.setVerticalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jComboBox1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(jLabel2)
                .addGap(18, 18, 18)
                .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 177, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(18, 18, 18)
                .addComponent(jComboBox3, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(jScrollPane2, javax.swing.GroupLayout.PREFERRED_SIZE, 178, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addComponent(jButton1)
                .addContainerGap())
        );

        jTabbedPane1.addTab("Tornei a girone", jPanel1);

        jButton2.setText("Fine");
        jButton2.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButton2ActionPerformed(evt);
            }
        });

        jLabel7.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        jLabel7.setBorder(javax.swing.BorderFactory.createEtchedBorder());

        jLabel8.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        jLabel8.setBorder(javax.swing.BorderFactory.createEtchedBorder());

        jLabel9.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        jLabel9.setText("VS");

        jLabel10.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        jLabel10.setBorder(javax.swing.BorderFactory.createEtchedBorder());

        jLabel11.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        jLabel11.setText("VS");

        jLabel12.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        jLabel12.setBorder(javax.swing.BorderFactory.createEtchedBorder());

        jLabel13.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        jLabel13.setBorder(javax.swing.BorderFactory.createEtchedBorder());

        jLabel14.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        jLabel14.setText("VS");

        jLabel15.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        jLabel15.setBorder(javax.swing.BorderFactory.createEtchedBorder());

        jLabel16.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        jLabel16.setBorder(javax.swing.BorderFactory.createEtchedBorder());

        jTable3.setModel(new javax.swing.table.DefaultTableModel(
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
        jScrollPane3.setViewportView(jTable3);

        jComboBox4.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "Marcatori", "Assist" }));
        jComboBox4.setBorder(javax.swing.BorderFactory.createTitledBorder("Classifiche per Giocatori"));
        jComboBox4.addItemListener(new java.awt.event.ItemListener() {
            public void itemStateChanged(java.awt.event.ItemEvent evt) {
                jComboBox4ItemStateChanged(evt);
            }
        });
        jComboBox4.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jComboBox4ActionPerformed(evt);
            }
        });

        jComboBox5.setBorder(javax.swing.BorderFactory.createTitledBorder("Tornei"));
        jComboBox5.addItemListener(new java.awt.event.ItemListener() {
            public void itemStateChanged(java.awt.event.ItemEvent evt) {
                jComboBox5ItemStateChanged(evt);
            }
        });

        javax.swing.GroupLayout jPanel2Layout = new javax.swing.GroupLayout(jPanel2);
        jPanel2.setLayout(jPanel2Layout);
        jPanel2Layout.setHorizontalGroup(
            jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel2Layout.createSequentialGroup()
                .addGap(0, 0, Short.MAX_VALUE)
                .addComponent(jButton2, javax.swing.GroupLayout.PREFERRED_SIZE, 88, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(10, 10, 10))
            .addGroup(jPanel2Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jComboBox4, 0, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addComponent(jScrollPane3, javax.swing.GroupLayout.Alignment.TRAILING))
                .addContainerGap())
            .addGroup(jPanel2Layout.createSequentialGroup()
                .addGap(43, 43, 43)
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel2Layout.createSequentialGroup()
                        .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(jLabel11, javax.swing.GroupLayout.PREFERRED_SIZE, 79, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(jLabel8, javax.swing.GroupLayout.PREFERRED_SIZE, 79, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(jLabel12, javax.swing.GroupLayout.PREFERRED_SIZE, 79, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(jLabel9, javax.swing.GroupLayout.PREFERRED_SIZE, 79, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addGap(71, 71, 71)
                        .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                            .addComponent(jLabel15, javax.swing.GroupLayout.PREFERRED_SIZE, 79, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(jLabel16, javax.swing.GroupLayout.PREFERRED_SIZE, 79, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(jLabel14, javax.swing.GroupLayout.PREFERRED_SIZE, 79, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addGap(54, 54, 54)
                        .addComponent(jLabel13, javax.swing.GroupLayout.PREFERRED_SIZE, 79, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addComponent(jLabel10, javax.swing.GroupLayout.PREFERRED_SIZE, 79, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jLabel7, javax.swing.GroupLayout.PREFERRED_SIZE, 79, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
            .addGroup(jPanel2Layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jComboBox5, 0, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addContainerGap())
        );
        jPanel2Layout.setVerticalGroup(
            jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel2Layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jComboBox5, javax.swing.GroupLayout.PREFERRED_SIZE, 41, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel2Layout.createSequentialGroup()
                        .addComponent(jLabel10, javax.swing.GroupLayout.PREFERRED_SIZE, 39, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addComponent(jLabel11))
                    .addGroup(jPanel2Layout.createSequentialGroup()
                        .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addGroup(jPanel2Layout.createSequentialGroup()
                                .addGap(75, 75, 75)
                                .addComponent(jLabel12, javax.swing.GroupLayout.PREFERRED_SIZE, 39, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addGap(26, 26, 26)
                                .addComponent(jLabel8, javax.swing.GroupLayout.PREFERRED_SIZE, 39, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addGap(18, 18, 18)
                                .addComponent(jLabel9))
                            .addGroup(jPanel2Layout.createSequentialGroup()
                                .addGap(62, 62, 62)
                                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                                    .addGroup(jPanel2Layout.createSequentialGroup()
                                        .addGap(45, 45, 45)
                                        .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                                            .addComponent(jLabel14, javax.swing.GroupLayout.PREFERRED_SIZE, 39, javax.swing.GroupLayout.PREFERRED_SIZE)
                                            .addComponent(jLabel13, javax.swing.GroupLayout.PREFERRED_SIZE, 39, javax.swing.GroupLayout.PREFERRED_SIZE))
                                        .addGap(13, 13, 13)
                                        .addComponent(jLabel15, javax.swing.GroupLayout.PREFERRED_SIZE, 39, javax.swing.GroupLayout.PREFERRED_SIZE))
                                    .addComponent(jLabel16, javax.swing.GroupLayout.PREFERRED_SIZE, 39, javax.swing.GroupLayout.PREFERRED_SIZE))))
                        .addGap(18, 18, 18)
                        .addComponent(jLabel7, javax.swing.GroupLayout.PREFERRED_SIZE, 39, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(jComboBox4, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(jScrollPane3, javax.swing.GroupLayout.PREFERRED_SIZE, 178, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 22, Short.MAX_VALUE)
                .addComponent(jButton2))
        );

        jTabbedPane1.addTab("Tornei ad eliminazione", jPanel2);

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jTabbedPane1)
                    .addComponent(jLabel1, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                .addContainerGap())
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jLabel1)
                .addGap(18, 18, 18)
                .addComponent(jTabbedPane1)
                .addContainerGap())
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void jComboBox1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jComboBox1ActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_jComboBox1ActionPerformed

    private void jComboBox1ItemStateChanged(java.awt.event.ItemEvent evt) {//GEN-FIRST:event_jComboBox1ItemStateChanged
        ResultSet rs;
        String str;
        Integer index;
                System.out.println("RILEVATO IL CAMBIAMENTO");
        if(jComboBox3.getSelectedIndex() == 0){
            System.out.println("TENTO DI CREARE LA CLASSIFICA");
            str = (String) jComboBox1.getSelectedItem();
            str = str.replaceAll("[^0-9]+", "");
            index = Integer.parseInt(str);
            //CLASSIFICA PER TORNEI
            try {
                rs=DBproject.classTg(this, index);
                jTable1.setModel (new VistaTabelle(rs));
                System.out.println("creata la classifica");
                pack();
            } catch(SQLException ex) {
                DBproject.showError(this, ex);
            }
            //CLASSIFICA MARCATORI
            String cond;
            try {
                cond = "IDTORNEOG = " + Integer.parseInt(str);
                rs=DBproject.classMarc(this, cond);
                jTable2.setModel (new VistaTabelle(rs));
                System.out.println("creata la classifica marcatori");
                pack();
            } catch(SQLException ex) {
                DBproject.showError(this, ex);
            }
        }else if (jComboBox3.getSelectedIndex() == 1){
            str = (String) jComboBox1.getSelectedItem();
            str = str.replaceAll("[^0-9]+", "");
            index = Integer.parseInt(str);
            //CLASSIFICA PER TORNEI
            try {
                rs=DBproject.classTg(this, index);
                jTable1.setModel (new VistaTabelle(rs));
                System.out.println("creata la classifica");
                pack();
            } catch(SQLException ex) {
                DBproject.showError(this, ex);
            }
            //CLASSIFICA ASSIST
            String cond;
            try {
                cond = "IDTORNEOG = " + Integer.parseInt(str);
                rs=DBproject.classAss(this, cond);
                jTable3.setModel (new VistaTabelle(rs));
                pack();
                System.out.println("creata la classifica ASSIST");
            } catch(SQLException ex) {
                DBproject.showError(this, ex);
            }
        }
        
        //Aggiungere la classifica da calcolare con gli if come per gli assist e i marcatori, così da evitare
        //lo switch case
    }//GEN-LAST:event_jComboBox1ItemStateChanged

    private void jComboBox3ItemStateChanged(java.awt.event.ItemEvent evt) {//GEN-FIRST:event_jComboBox3ItemStateChanged
        ResultSet rs;
        String str;
        String cond;
        switch(jComboBox3.getSelectedIndex()){
            case 0:
                str = (String) jComboBox1.getSelectedItem();
                str = str.replaceAll("[^0-9]+", "");
                cond = "IDTORNEOG = " + Integer.parseInt(str);
                try {
                    rs=DBproject.classMarc(this, cond);
                    jTable2.setModel (new VistaTabelle(rs));
                    pack();
                } catch(SQLException ex) {
                    DBproject.showError(this, ex);
                }
                break;
            case 1:
                str = (String) jComboBox1.getSelectedItem();
                str = str.replaceAll("[^0-9]+", "");
                cond  = "IDTORNEOG = " + Integer.parseInt(str);
                try {
                    rs=DBproject.classAss(this, cond);
                    jTable2.setModel (new VistaTabelle(rs));
                    pack();
                } catch(SQLException ex) {
                    DBproject.showError(this, ex);
                }
                break;
        }
    }//GEN-LAST:event_jComboBox3ItemStateChanged

    private void jButton1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButton1ActionPerformed
        dispose();
    }//GEN-LAST:event_jButton1ActionPerformed

    private void jButton2ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButton2ActionPerformed
        dispose();
    }//GEN-LAST:event_jButton2ActionPerformed

    private void jComboBox4ItemStateChanged(java.awt.event.ItemEvent evt) {//GEN-FIRST:event_jComboBox4ItemStateChanged
        ResultSet rs;
        String str;
        String cond;
        switch(jComboBox4.getSelectedIndex()){
            case 0:
                str = (String) jComboBox1.getSelectedItem();
                str = str.replaceAll("[^0-9]+", "");
                cond = "IDTORNEOE = " + Integer.parseInt(str);
                try {
                    rs=DBproject.classMarc(this, cond);
                    jTable3.setModel (new VistaTabelle(rs));
                    pack();
                } catch(SQLException ex) {
                    DBproject.showError(this, ex);
                }
                break;
            case 1:
                str = (String) jComboBox1.getSelectedItem();
                str = str.replaceAll("[^0-9]+", "");
                cond  = "IDTORNEOE = " + Integer.parseInt(str);
                try {
                    rs=DBproject.classAss(this, cond);
                    jTable3.setModel (new VistaTabelle(rs));
                    pack();
                } catch(SQLException ex) {
                    DBproject.showError(this, ex);
                }
                break;
        }
    }//GEN-LAST:event_jComboBox4ItemStateChanged

    private void jComboBox4ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jComboBox4ActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_jComboBox4ActionPerformed

    private void jComboBox5ItemStateChanged(java.awt.event.ItemEvent evt) {//GEN-FIRST:event_jComboBox5ItemStateChanged
        String str = (String) jComboBox5.getSelectedItem();
        str = str.replaceAll("[^0-9]+", "");
        Integer index = Integer.parseInt(str);
        try {
            createScheme(index);
        } catch (SQLException ex) {
            Logger.getLogger(infoTornei.class.getName()).log(Level.SEVERE, null, ex);
        }
        ResultSet rs;
        String cond;
        switch(jComboBox4.getSelectedIndex()){
            case 0:
                str = (String) jComboBox1.getSelectedItem();
                str = str.replaceAll("[^0-9]+", "");
                cond = "IDTORNEOE = " + Integer.parseInt(str);
                try {
                    rs=DBproject.classMarc(this, cond);
                    jTable3.setModel (new VistaTabelle(rs));
                    pack();
                } catch(SQLException ex) {
                    DBproject.showError(this, ex);
                }
                break;
            case 1:
                str = (String) jComboBox1.getSelectedItem();
                str = str.replaceAll("[^0-9]+", "");
                cond  = "IDTORNEOE = " + Integer.parseInt(str);
                try {
                    rs=DBproject.classAss(this, cond);
                    jTable3.setModel (new VistaTabelle(rs));
                    pack();
                } catch(SQLException ex) {
                    DBproject.showError(this, ex);
                }
                break;
        }
    }//GEN-LAST:event_jComboBox5ItemStateChanged

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
            java.util.logging.Logger.getLogger(infoTornei.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(infoTornei.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(infoTornei.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(infoTornei.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton jButton1;
    private javax.swing.JButton jButton2;
    private javax.swing.JComboBox<String> jComboBox1;
    private javax.swing.JComboBox<String> jComboBox3;
    private javax.swing.JComboBox<String> jComboBox4;
    private javax.swing.JComboBox<String> jComboBox5;
    private javax.swing.JInternalFrame jInternalFrame1;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel10;
    private javax.swing.JLabel jLabel11;
    private javax.swing.JLabel jLabel12;
    private javax.swing.JLabel jLabel13;
    private javax.swing.JLabel jLabel14;
    private javax.swing.JLabel jLabel15;
    private javax.swing.JLabel jLabel16;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JLabel jLabel7;
    private javax.swing.JLabel jLabel8;
    private javax.swing.JLabel jLabel9;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JPanel jPanel2;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JScrollPane jScrollPane2;
    private javax.swing.JScrollPane jScrollPane3;
    private javax.swing.JTabbedPane jTabbedPane1;
    private javax.swing.JTable jTable1;
    private javax.swing.JTable jTable2;
    private javax.swing.JTable jTable3;
    // End of variables declaration//GEN-END:variables
}
