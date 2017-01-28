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
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Andrtea
 */
public class Nazionali extends javax.swing.JFrame {

    /**
     * Creates new form Nazionali
     */
    public Nazionali() throws SQLException {
        initComponents();
        //AGGIUNTA DEI LISTNER PER I COMBOBOX    
        selTab.addItemListener(new ItemListener(){
            public void itemStateChanged(ItemEvent e){
                if(e.getStateChange()==ItemEvent.SELECTED){
                    try {
                        selTabElements();
                    } catch (SQLException ex) {
                        Logger.getLogger(Nazionali.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }
            }
        });
        box.addItemListener(new ItemListener(){
            public void itemStateChanged(ItemEvent e){
                if(e.getStateChange()==ItemEvent.SELECTED){
                    try {
                        boxElements();
                    } catch (SQLException ex) {
                        Logger.getLogger(Nazionali.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }
            }
        });
        ResultSet rs;
        jTable2.setShowGrid(false);
        jTable1.setShowGrid(false);
        boxItem();
        box.setVisible(false);
        jText1.setBorder(javax.swing.BorderFactory.createTitledBorder("IDgiocatore"));
        jText2.setBorder(javax.swing.BorderFactory.createTitledBorder("Nome"));
        jText3.setBorder(javax.swing.BorderFactory.createTitledBorder("Cognome"));
        jText6.setBorder(javax.swing.BorderFactory.createTitledBorder("ID squadra di riferimento"));
        try {
            rs=DBproject.modGiocN(this);
            jTable1.setModel (new VistaTabelle(rs));
            pack();
        } catch(SQLException ex) {
            DBproject.showError(this, ex);
        }
        try {
            rs=DBproject.ricSqT(this, "nazionale");
            jTable2.setModel (new VistaTabelle(rs));
            pack();
        } catch(SQLException ex) {
            DBproject.showError(this, ex);
        }
    }

    private void boxItem () throws SQLException{
        Statement boxItem;
        boxItem=DBproject.defaultConn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
        ResultSet result = boxItem.executeQuery("SELECT NOME, IDSQUADRA FROM SQUADRA WHERE TIPO = 'nazionale'");
        while (result.next()){
            String ris = result.getString("NOME");
            ris += ", ";
            ris += result.getString("IDSQUADRA");
            System.out.println(ris);
            box.addItem(ris);
        }
        System.out.println("creato il bo per NAZIONALI");
    }
    private void boxElements() throws SQLException{
        ResultSet rs;
        String str = (String) box.getSelectedItem();
        str = str.replaceAll("[^0-9]+", "");
        Integer index = Integer.parseInt(str);
        rs=DBproject.ricSqI(this, index);
        jTable1.setModel (new VistaTabelle(rs));
        pack();
        
        str = (String) box.getSelectedItem();
        str = str.replaceAll("[^0-9]+", "");
        index = Integer.parseInt(str);
        jText6.setText(index.toString());
    }
    private void selTabElements() throws SQLException{
        jText1.setEditable(false);
        jText2.setEditable(false);
        jText3.setEditable(false);
        jText6.setEditable(false);
        jText1.setText("");
        jText2.setText("");
        jText3.setText("");
        jText6.setText("");
        ResultSet rs;
        switch(selTab.getSelectedIndex()){
            case 0:
                try {
                    rs=DBproject.modGiocN(this);
                    jTable1.setModel (new VistaTabelle(rs));
                    pack();
                } catch(SQLException ex) {
                    DBproject.showError(this, ex);
                }
                jButton1.setText("Registra");
                box.setVisible(false);
                break;
            case 1:
                box.setVisible(true);
                try {
                    rs=DBproject.ricSqT(this, "nazionale");
                    jTable2.setModel (new VistaTabelle(rs));
                    pack();
                } catch(SQLException ex) {
                    DBproject.showError(this, ex);
                }
                jButton1.setText("Elimina da Nazionale");
                boxElements();
                break;
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

        jScrollPane1 = new javax.swing.JScrollPane();
        jTable1 = new javax.swing.JTable();
        jPanel1 = new javax.swing.JPanel();
        selTab = new javax.swing.JComboBox<>();
        jText2 = new javax.swing.JTextField();
        jText6 = new javax.swing.JTextField();
        jText1 = new javax.swing.JTextField();
        jText3 = new javax.swing.JTextField();
        box = new javax.swing.JComboBox<>();
        jButton1 = new javax.swing.JButton();
        jScrollPane2 = new javax.swing.JScrollPane();
        jTable2 = new javax.swing.JTable();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);

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

        selTab.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "Registra in Nazionale", "rimuovi da Nazionale" }));
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

        jText1.setHorizontalAlignment(javax.swing.JTextField.LEFT);
        jText1.setBorder(javax.swing.BorderFactory.createTitledBorder("Nome"));
        jText1.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                jText1MouseClicked(evt);
            }
        });

        jText3.setHorizontalAlignment(javax.swing.JTextField.LEFT);
        jText3.setBorder(javax.swing.BorderFactory.createTitledBorder("Data nascita (gg/mm/aaaa)"));
        jText3.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                jText3MouseClicked(evt);
            }
        });

        box.setBorder(javax.swing.BorderFactory.createTitledBorder("Scegli Nazionale"));

        jButton1.setText("Registra");
        jButton1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButton1ActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout jPanel1Layout = new javax.swing.GroupLayout(jPanel1);
        jPanel1.setLayout(jPanel1Layout);
        jPanel1Layout.setHorizontalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel1Layout.createSequentialGroup()
                        .addComponent(jText3, javax.swing.GroupLayout.PREFERRED_SIZE, 210, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 11, Short.MAX_VALUE)
                        .addComponent(jText6, javax.swing.GroupLayout.PREFERRED_SIZE, 209, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel1Layout.createSequentialGroup()
                        .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(jText1, javax.swing.GroupLayout.PREFERRED_SIZE, 210, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(selTab, javax.swing.GroupLayout.PREFERRED_SIZE, 201, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                            .addComponent(box, 0, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                            .addComponent(jText2, javax.swing.GroupLayout.DEFAULT_SIZE, 210, Short.MAX_VALUE)))
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel1Layout.createSequentialGroup()
                        .addGap(0, 0, Short.MAX_VALUE)
                        .addComponent(jButton1, javax.swing.GroupLayout.PREFERRED_SIZE, 127, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addContainerGap())
        );
        jPanel1Layout.setVerticalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                    .addComponent(selTab)
                    .addComponent(box))
                .addGap(18, 18, 18)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jText2, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jText1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(18, 18, 18)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jText6, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jText3, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addComponent(jButton1)
                .addContainerGap())
        );

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

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jPanel1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(18, 18, 18)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jScrollPane1, javax.swing.GroupLayout.DEFAULT_SIZE, 476, Short.MAX_VALUE)
                    .addComponent(jScrollPane2))
                .addContainerGap())
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(jPanel1, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addContainerGap())
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 173, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 29, Short.MAX_VALUE)
                        .addComponent(jScrollPane2, javax.swing.GroupLayout.PREFERRED_SIZE, 151, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(26, 26, 26))))
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void jTable1MouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_jTable1MouseClicked
        Integer row;
        Integer column;
        switch(selTab.getSelectedIndex()){
            case 0:
                row = jTable1.getSelectedRow();
                column = 0;
                jText1.setText(jTable1.getValueAt(row, column).toString());
                column++;
                jText2.setText(jTable1.getValueAt(row, column).toString());
                column++;
                jText3.setText(jTable1.getValueAt(row, column).toString());
                break;
            case 1:
                row = jTable1.getSelectedRow();
                column = 0;
                jText1.setText(jTable1.getValueAt(row, column).toString());
                column++;
                jText2.setText(jTable1.getValueAt(row, column).toString());
                column++;
                jText3.setText(jTable1.getValueAt(row, column).toString());
                break;
        }
    }//GEN-LAST:event_jTable1MouseClicked

    private void selTabItemStateChanged(java.awt.event.ItemEvent evt) {//GEN-FIRST:event_selTabItemStateChanged

    }//GEN-LAST:event_selTabItemStateChanged

    private void selTabActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_selTabActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_selTabActionPerformed

    private void jText2MouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_jText2MouseClicked
    }//GEN-LAST:event_jText2MouseClicked

    private void jText2ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jText2ActionPerformed
    }//GEN-LAST:event_jText2ActionPerformed

    private void jText6MouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_jText6MouseClicked
    }//GEN-LAST:event_jText6MouseClicked

    private void jText6ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jText6ActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_jText6ActionPerformed

    private void jText1MouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_jText1MouseClicked
    }//GEN-LAST:event_jText1MouseClicked

    private void jText3MouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_jText3MouseClicked
    }//GEN-LAST:event_jText3MouseClicked

    private void jTable2MouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_jTable2MouseClicked
        Integer row;
        switch(selTab.getSelectedIndex()){
            case 0:
                row = jTable2.getSelectedRow();
                jText6.setText(jTable2.getValueAt(row, 0).toString());
        }
    }//GEN-LAST:event_jTable2MouseClicked

    private void jButton1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButton1ActionPerformed
        String tab;
        String col;
        String val;
        switch(selTab.getSelectedIndex()){
            case 0:
                tab="SQUADRA_GIOCATORI";
                col="(IDSQUADRA, IDGIOCATORE)";
                val="('" + jText6.getText() + "', '" + jText1.getText() + "')";
                try {
                    DBproject.insert(tab, col, val);
                    selTabElements();
                } catch (SQLException ex) {
                    Logger.getLogger(Nazionali.class.getName()).log(Level.SEVERE, null, ex);
                }
                
                break;
            case 1:
                tab="SQUADRA_GIOCATORI";
                val="IDGIOCATORE = " + jText1.getText() + " AND IDSQUADRA = ";
                try {
                    DBproject.del(this,tab,val,jText6.getText());
                    boxElements();
                } catch (SQLException ex) {
                    Logger.getLogger(Nazionali.class.getName()).log(Level.SEVERE, null, ex);
                }
        }
    }//GEN-LAST:event_jButton1ActionPerformed

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
            java.util.logging.Logger.getLogger(Nazionali.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(Nazionali.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(Nazionali.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(Nazionali.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                try {
                    new Nazionali().setVisible(true);
                } catch (SQLException ex) {
                    Logger.getLogger(Nazionali.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JComboBox<String> box;
    private javax.swing.JButton jButton1;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JScrollPane jScrollPane2;
    private javax.swing.JTable jTable1;
    private javax.swing.JTable jTable2;
    private javax.swing.JTextField jText1;
    private javax.swing.JTextField jText2;
    private javax.swing.JTextField jText3;
    private javax.swing.JTextField jText6;
    private javax.swing.JComboBox<String> selTab;
    // End of variables declaration//GEN-END:variables
}
