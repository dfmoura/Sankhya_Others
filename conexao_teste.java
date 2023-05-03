import java.sql.*;

public class OracleConnection {
   public static void main(String[] args) {
      try {
         // registrando JDBC driver
         Class.forName("oracle.jdbc.driver.OracleDriver");

         // Open a connection --teste
         Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@192.168.1.240:1521:ORCL", "sankhya", "12jcr23");

         // Do something with the connection --teste

         // Close the connection --teste
         conn.close();
      } catch (SQLException e) {
         e.printStackTrace();
      }
   }
}