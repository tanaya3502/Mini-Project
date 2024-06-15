

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class GetRequestInfo
 */
@WebServlet("/GetRequestInfo")
public class GetRequestInfo extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetRequestInfo() {
        super();
        // TODO Auto-generated constructor stub
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "Tanaya@3502");
            PreparedStatement ps = con.prepareStatement("SELECT * FROM requests");
            ResultSet rs = ps.executeQuery();

            request.setAttribute("resultSet", rs);

            RequestDispatcher rd = request.getRequestDispatcher("request_acx.jsp");
            rd.forward(request, response);

            rs.close();
            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            // Handle exceptions appropriately
        }
    }

}
