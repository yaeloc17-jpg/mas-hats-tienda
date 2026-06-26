import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "RegistrarUsuarioServlet", urlPatterns = {"/RegistrarUsuarioServlet"})
public class RegistrarUsuariosServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        String txtCorreo = request.getParameter("txtCorreo");
        String txtPassword = request.getParameter("txtPassword");
        
        Connection con = null;
        PreparedStatement ps = null;
        
        try {
            con = ConexionBD.getConnection(); 
            
            String query = "INSERT INTO chicos (correo, contra) VALUES (?, ?)";
            ps = con.prepareStatement(query);
            ps.setString(1, txtCorreo);
            ps.setString(2, txtPassword);
            
            int resultado = ps.executeUpdate();
            
            out.println("<html>");
            out.println("<head><title>Resultado de Registro</title></head>");
            out.println("<body style='font-family:Arial; text-align:center; padding-top:50px;'>");
            if(resultado > 0) {
                out.println("<h2 style='color: green;'>¡Registro exitoso en Azure!</h2>");
                out.println("<p>El usuario se guardó correctamente.</p>");
                out.println("<br><a href='login.jsp'>Ir a iniciar sesión</a>");
            } else {
                out.println("<h2 style='color: red;'>No se pudo completar el registro.</h2>");
            }
            out.println("</body>");
            out.println("</html>");
            
        } catch (Exception e) {
            out.println("<html><body>");
            out.println("<h3 style='color:red;'>Error en Azure: " + e.getMessage() + "</h3>");
            out.println("<a href='registro.jsp'>Volver a intentar</a>");
            out.println("</body></html>");
        } finally {
            try { if(ps != null) ps.close(); if(con != null) con.close(); } catch(Exception ex){}
        }
    }
}