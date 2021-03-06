/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dbproject;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JOptionPane;

/**
 *
 * @author Andrtea
 */
public class InsTornei extends javax.swing.JFrame {

    public String colonne;
    public String valori;
    public String tabella;
    public String col;
    public String val;
    public String tab;

    /**
     * Creates new form InsTornei
     */
    public InsTornei() {
        //CLASSE PER LA CREAZIONE DEI TORNEI
        initComponents();
        setLocationRelativeTo(null);
        jLabel1.setText("Inserire gli ID relativi alle squadre che parteciperanno al torneo");
        
        String tipo=(String) jComboBox1.getSelectedItem();
        try {
            ResultSet rs;
            rs=DBproject.ricSqT(this, tipo);
            jTable1.setModel (new VistaTabelle(rs));
            pack();

        } catch(SQLException ex) {
            DBproject.showError(this, ex);
        }
        jTable1.setShowGrid(false);
       
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jTextField1 = new javax.swing.JTextField();
        jTextField2 = new javax.swing.JTextField();
        jTextField3 = new javax.swing.JTextField();
        jTextField4 = new javax.swing.JTextField();
        jTextField5 = new javax.swing.JTextField();
        jTextField6 = new javax.swing.JTextField();
        jTextField7 = new javax.swing.JTextField();
        jTextField8 = new javax.swing.JTextField();
        jTextField9 = new javax.swing.JTextField();
        jTextField10 = new javax.swing.JTextField();
        jTextField11 = new javax.swing.JTextField();
        jTextField12 = new javax.swing.JTextField();
        jTextField13 = new javax.swing.JTextField();
        jTextField14 = new javax.swing.JTextField();
        jTextField15 = new javax.swing.JTextField();
        jTextField16 = new javax.swing.JTextField();
        jButton1 = new javax.swing.JButton();
        jButton2 = new javax.swing.JButton();
        jLabel1 = new javax.swing.JLabel();
        jPanel2 = new javax.swing.JPanel();
        jScrollPane1 = new javax.swing.JScrollPane();
        jTable1 = new javax.swing.JTable();
        jComboBox1 = new javax.swing.JComboBox<>();

        setDefaultCloseOperation(javax.swing.WindowConstants.DISPOSE_ON_CLOSE);

        jTextField1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jTextField1ActionPerformed(evt);
            }
        });

        jTextField13.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jTextField13ActionPerformed(evt);
            }
        });

        jButton1.setText("Inserisci");
        jButton1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButton1ActionPerformed(evt);
            }
        });

        jButton2.setText("Fine/Annulla");
        jButton2.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButton2ActionPerformed(evt);
            }
        });

        jLabel1.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);

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

        javax.swing.GroupLayout jPanel2Layout = new javax.swing.GroupLayout(jPanel2);
        jPanel2.setLayout(jPanel2Layout);
        jPanel2Layout.setHorizontalGroup(
            jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel2Layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 296, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(15, Short.MAX_VALUE))
        );
        jPanel2Layout.setVerticalGroup(
            jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel2Layout.createSequentialGroup()
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 207, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap())
        );

        jComboBox1.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "Club", "Nazionale" }));
        jComboBox1.setBorder(javax.swing.BorderFactory.createTitledBorder("Tipo "));
        jComboBox1.addItemListener(new java.awt.event.ItemListener() {
            public void itemStateChanged(java.awt.event.ItemEvent evt) {
                jComboBox1ItemStateChanged(evt);
            }
        });

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(layout.createSequentialGroup()
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING, false)
                            .addComponent(jTextField13)
                            .addComponent(jTextField9)
                            .addComponent(jTextField5)
                            .addComponent(jTextField1)
                            .addComponent(jButton2, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                        .addGap(18, 18, 18)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                            .addComponent(jTextField2)
                            .addComponent(jTextField6)
                            .addComponent(jTextField10)
                            .addComponent(jTextField14, javax.swing.GroupLayout.PREFERRED_SIZE, 71, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addGap(18, 18, 18)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                            .addComponent(jTextField3)
                            .addComponent(jTextField7)
                            .addComponent(jTextField11)
                            .addComponent(jTextField15, javax.swing.GroupLayout.PREFERRED_SIZE, 71, javax.swing.GroupLayout.PREFERRED_SIZE)))
                    .addComponent(jLabel1, javax.swing.GroupLayout.PREFERRED_SIZE, 249, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(18, 18, 18)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                    .addComponent(jButton1, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addComponent(jTextField4)
                    .addComponent(jTextField8)
                    .addComponent(jTextField12)
                    .addComponent(jTextField16)
                    .addComponent(jComboBox1, 0, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                .addGap(18, 18, 18)
                .addComponent(jPanel2, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jPanel2, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addGroup(layout.createSequentialGroup()
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(jLabel1, javax.swing.GroupLayout.PREFERRED_SIZE, 39, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addGroup(layout.createSequentialGroup()
                                .addGap(8, 8, 8)
                                .addComponent(jComboBox1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)))
                        .addGap(18, 18, 18)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(jTextField1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(jTextField2, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(jTextField3, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(jTextField4, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addGap(18, 18, 18)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(jTextField5, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(jTextField6, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(jTextField7, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(jTextField8, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addGap(18, 18, 18)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(jTextField9, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(jTextField10, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(jTextField11, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(jTextField12, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addGap(18, 18, 18)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(jTextField13, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(jTextField14, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(jTextField15, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(jTextField16, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addGap(18, 18, 18)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(jButton1)
                            .addComponent(jButton2))
                        .addGap(0, 0, Short.MAX_VALUE)))
                .addContainerGap())
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void jTextField1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jTextField1ActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_jTextField1ActionPerformed

    private void jButton2ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButton2ActionPerformed
        dispose();
    }//GEN-LAST:event_jButton2ActionPerformed
    
    //LA FUNZIONE SI OCCUPA DI VERFIFICARE CHE IL NUMERO DI PARTECIPANTI IN UN TORNEO AD ELIMINAIZONE DIRETTA
    //SIA UNA POTENZA DI 2
    private Boolean isPower (){
        Integer index=0;
            if (!"".equals(jTextField1.getText())){
                index=index+1;
            }
        
            if (!"".equals(jTextField2.getText())){
                index=index+1; 
            }
            if (!"".equals(jTextField3.getText())){
                index=index+1; 
            }
            if (!"".equals(jTextField4.getText())){
                index=index+1; 
            }
            if (!"".equals(jTextField5.getText())){
                index=index+1;
            }
            if (!"".equals(jTextField6.getText())){
                index=index+1;
            }
            if (!"".equals(jTextField7.getText())){
                index=index+1;
            }
            if (!"".equals(jTextField8.getText())){
                index=index+1;
            }
            if (!"".equals(jTextField9.getText())){
                index=index+1;
            }
            if (!"".equals(jTextField10.getText())){
                index=index+1;
            }
            if (!"".equals(jTextField11.getText())){
                index=index+1;
            }
            if (!"".equals(jTextField12.getText())){
                index=index+1;
            }
            if (!"".equals(jTextField13.getText())){
                index=index+1;
            }
            if (!"".equals(jTextField14.getText())){
                index=index+1;
            }
            if (!"".equals(jTextField15.getText())){
                index=index+1;
            }
            if (!"".equals(jTextField16.getText())){
                index=index+1;
            }
            
            Boolean ris;
            if ((index & -index) == index){
                ris=true;
            }else{
                ris=false;
            }
            return ris;
    }
    
    //CREAZIONE DELLE ASSOCIAZIONI PER I PARTECIPANTI AI TORNEI A GIRONI O AD ELIMINAZIOINE
    //
    private void createParticipants (){
        String vaule;
        try {
            //viene creato il torneo
            DBproject.insert(tab,col,val);
            //vengono inserite le squadre in PARTECIPANTI_GIRONI o in PARTECIPANTI_ELIMINAZIONE
            if (!"".equals(jTextField1.getText())){
                vaule=valori;
                vaule+="'" + jTextField1.getText() + "')";
                DBproject.insert(tabella, colonne, vaule);
            }
            if (!"".equals(jTextField2.getText())){
                vaule=valori;
                vaule+="'" + jTextField2.getText() + "')";
                DBproject.insert(tabella, colonne, vaule);
            }
            if (!"".equals(jTextField3.getText())){
                vaule=valori;
                vaule+="'" + jTextField3.getText() + "')";
                DBproject.insert(tabella, colonne, vaule);
            }
            if (!"".equals(jTextField4.getText())){
                vaule=valori;
                vaule+="'" + jTextField4.getText() + "')";
                DBproject.insert(tabella, colonne, vaule);
            }
            if (!"".equals(jTextField5.getText())){
                vaule=valori;
                vaule+="'" + jTextField5.getText() + "')";
                DBproject.insert(tabella, colonne, vaule);
            }
            if (!"".equals(jTextField6.getText())){
                vaule=valori;
                vaule+="'" + jTextField6.getText() + "')";
                DBproject.insert(tabella, colonne, vaule);
            }
            if (!"".equals(jTextField7.getText())){
                vaule=valori;
                vaule+="'" + jTextField7.getText() + "')";
                DBproject.insert(tabella, colonne, vaule);
            }
            if (!"".equals(jTextField8.getText())){
                vaule=valori;
                vaule+="'" + jTextField8.getText() + "')";
                DBproject.insert(tabella, colonne, vaule);
            }
            if (!"".equals(jTextField9.getText())){
                vaule=valori;
                vaule+="'" + jTextField9.getText() + "')";
                DBproject.insert(tabella, colonne, vaule);
            }
            if (!"".equals(jTextField10.getText())){
                vaule=valori;
                vaule+="'" + jTextField10.getText() + "')";
                DBproject.insert(tabella, colonne, vaule);
            }
            if (!"".equals(jTextField11.getText())){
                vaule=valori;
                vaule+="'" + jTextField11.getText() + "')";
                DBproject.insert(tabella, colonne, vaule);
            }
            if (!"".equals(jTextField12.getText())){
                vaule=valori;
                vaule+="'" + jTextField12.getText() + "')";
                DBproject.insert(tabella, colonne, vaule);
            }
            if (!"".equals(jTextField13.getText())){
                vaule=valori;
                vaule+="'" + jTextField13.getText() + "')";
                DBproject.insert(tabella, colonne, vaule);
            }
            if (!"".equals(jTextField14.getText())){
                vaule=valori;
                vaule+="'" + jTextField14.getText() + "')";
                DBproject.insert(tabella, colonne, vaule);
            }
            if (!"".equals(jTextField15.getText())){
                vaule=valori;
                vaule+="'" + jTextField15.getText() + "')";
                DBproject.insert(tabella, colonne, vaule);
            }
            if (!"".equals(jTextField16.getText())){
                vaule=valori;
                vaule+="'" + jTextField16.getText() + "')";
                DBproject.insert(tabella, colonne, vaule);
            }
            JOptionPane.showMessageDialog(null, "Torneo Inserito");
            dispose();
        } catch (SQLException ex) {
            DBproject.showError(this, ex);
        }
    }
    private void jButton1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButton1ActionPerformed
        //NEL CASO DEI TORNEI AD ELIMINAZIONE VIENE VERIFICATO CHE IL NUMERO DI PARTECIPANTI SIA UNA POTENZA DI 2
        //ALTRIMENTI INSERISCE IL TORNEO A GIRONI
        if ("PARTECIPANTI_ELIMINAZIONE".equals(tabella)){
            Boolean ris=isPower();
            if (ris){
                createParticipants();
            }else{
                JOptionPane.showMessageDialog(null, "Il numero dei partecipanti deve essere una potenza di 2 per un torneo ad eliminazione diretta!", "ERRORE", JOptionPane.ERROR_MESSAGE);
            }
        }else{
            createParticipants();
        }
    }//GEN-LAST:event_jButton1ActionPerformed

    private void jTextField13ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jTextField13ActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_jTextField13ActionPerformed

    private void jComboBox1ItemStateChanged(java.awt.event.ItemEvent evt) {//GEN-FIRST:event_jComboBox1ItemStateChanged
        //CAMBIA LA VISUALIZZAZIONE NELLA TABELLA A SECONDA SE SI VOGLIONO
        //INSERIRE SQUADRE DI CLUB O DI NAZIONALI
        ResultSet rs;
        String tipo=(String) jComboBox1.getSelectedItem();
        try {
            rs=DBproject.ricSqT(this, tipo);
            jTable1.setModel (new VistaTabelle(rs));
            pack();
            
        } catch(SQLException ex) {
            DBproject.showError(this, ex);
        }
    }//GEN-LAST:event_jComboBox1ItemStateChanged

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
            java.util.logging.Logger.getLogger(InsTornei.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(InsTornei.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(InsTornei.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(InsTornei.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new InsTornei().setVisible(true);
            }
        });
    }
    
    

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton jButton1;
    private javax.swing.JButton jButton2;
    private javax.swing.JComboBox<String> jComboBox1;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JPanel jPanel2;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JTable jTable1;
    private javax.swing.JTextField jTextField1;
    private javax.swing.JTextField jTextField10;
    private javax.swing.JTextField jTextField11;
    private javax.swing.JTextField jTextField12;
    private javax.swing.JTextField jTextField13;
    private javax.swing.JTextField jTextField14;
    private javax.swing.JTextField jTextField15;
    private javax.swing.JTextField jTextField16;
    private javax.swing.JTextField jTextField2;
    private javax.swing.JTextField jTextField3;
    private javax.swing.JTextField jTextField4;
    private javax.swing.JTextField jTextField5;
    private javax.swing.JTextField jTextField6;
    private javax.swing.JTextField jTextField7;
    private javax.swing.JTextField jTextField8;
    private javax.swing.JTextField jTextField9;
    // End of variables declaration//GEN-END:variables
}
