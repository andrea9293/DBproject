/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dbproject;

import java.sql.ResultSet;
import java.sql.SQLException;
import javax.swing.table.AbstractTableModel;
import java.sql.*;


public class VistaTabelle extends AbstractTableModel {

   private ResultSet rs; // Resultset su cui si basa il modello

   public VistaTabelle() {
      super();
   }

   public VistaTabelle(ResultSet r) {
      super();
      rs = r;
   }

   public void setRS(ResultSet r) {
      rs = r;
      fireTableStructureChanged();
   }

   @Override
   public String getColumnName(int col) {
      col++;
      if (rs == null) {
         return "";
      }
      try {
         return rs.getMetaData().getColumnName(col);
      } catch (SQLException e) {
         DBproject.showError(null, e);
         System.err.println("errore in getColumnName");
         return "";
      }
   }

   @Override
   public int getRowCount() {
      if (rs == null) {
         return 0;
      }
      try {
         int currentPosition, last;
         currentPosition = rs.getRow();
         rs.last();
         last = rs.getRow();
         if (currentPosition == 0) rs.first();
         else rs.absolute(currentPosition);
         return last;
      } catch (SQLException e) {
         DBproject.showError(null, e);
         System.err.println("errore in getRowCount");
         return 0;
      }
   }

   @Override
   public int getColumnCount() {
      if (rs == null) {
         return 0;
      }
      try {
         return rs.getMetaData().getColumnCount();
      } catch (SQLException e) {
         DBproject.showError(null, e);
         System.err.println("errore in getColumnCount");
         return 0;
      }
   }

   @Override
   public Object getValueAt(int row, int col) {
      int currentPosition;
      Object ob;
      row++;
      col++;
      try {
         currentPosition = rs.getRow();
         rs.absolute(row);
         ob = rs.getObject(col);
         rs.absolute(currentPosition);
         return ob;
      } catch (SQLException e) {
         DBproject.showError(null, e);
         System.err.println("errore in getValueAt");
         return null;
      }
   }

   @Override
   public boolean isCellEditable(int row, int col) {
      return false;
   }

   @Override
   public void setValueAt(Object value, int row, int col) {
   }
}

