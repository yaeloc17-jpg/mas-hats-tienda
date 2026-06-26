import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ValidarLoginServlet", urlPatterns = {"/ValidarLoginServlet"})
public class ValidarLoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        String txtCorreo = request.getParameter("txtCorreo");
        String txtPassword = request.getParameter("txtPassword");
        
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            con = ConexionBD.getConnection();
            
            String query = "SELECT * FROM chicos WHERE correo = ? AND contra = ?";
            ps = con.prepareStatement(query);
            ps.setString(1, txtCorreo);
            ps.setString(2, txtPassword);
            
            rs = ps.executeQuery();
            
            if (rs.next()) {
                response.sendRedirect("catalogo.jsp");
            } else {
                out.println("<html><body style='font-family:Arial; text-align:center; padding-top:50px;'>");
                out.println("<h2 style='color: red;'>Correo o contraseña incorrectos.</h2>");
                out.println("<p>Por favor, verifica tus datos o crea una cuenta nueva.</p><br>");
                out.println("<a href='login.jsp' style='padding:10px 20px; background-color:#3483fa; color:white; text-decoration:none; border-radius:5px; margin-right:10px;'>Volver a intentar</a>");
                out.println("<a href='registro.jsp' style='padding:10px 20px; background-color:#6c757d; color:white; text-decoration:none; border-radius:5px;'>Crear cuenta</a>");
                out.println("</body></html>");
            }
            
        } catch (Exception e) {
            out.println("<h3>Error en el Login: " + e.getMessage() + "</h3>");
        } finally {
            try { if(rs != null) rs.close(); if(ps != null) ps.close(); if(con != null) con.close(); } catch(Exception ex){}
        }
    }
}

