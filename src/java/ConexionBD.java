
import java.sql.Connection;
import java.sql.DriverManager;

public class ConexionBD {

    // Usamos el formato de URL para MySQL en Azure con tus datos reales de la foto
    private static final String URL = "jdbc:mysql://myserver2026.mysql.database.azure.com:3306/gorras?useSSL=true&requireSSL=true";
    private static final String USER = "yayoserver";
    private static final String PASSWORD = "#Miaplicacion8";

    public static Connection getConnection() {
        Connection con = null;
        try {
            // El driver correcto para MySQL
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("¡Conexión exitosa a Azure MySQL!");
        } catch (Exception e) {
            System.out.println("===== ERROR COMPLETO =====");
            e.printStackTrace();
        }
        return con;
    }

    public static void main(String[] args) {
        System.out.println("Iniciando prueba de conexión a Azure MySQL...");
        Connection testCon = getConnection();
        if (testCon != null) {
            System.out.println("¡Felicidades! El puente funciona perfecto.");
            try {
                testCon.close();
            } catch (Exception e) {
            }
        } else {
            System.out.println("El puente está roto. Revisa el mensaje de error de arriba.");
        }
    }
}
