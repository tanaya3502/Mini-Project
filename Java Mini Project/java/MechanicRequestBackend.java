

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class MechanicRequestBackend
 */
@WebServlet("/request")
public class MechanicRequestBackend extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MechanicRequestBackend() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
        String url = "jdbc:mysql://localhost:3306/project";
        String username = "root";
        String password = "Tanaya@3502";

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        Statement statement = null;

        try {
            // Load the JDBC driver
            Class.forName("com.mysql.jdbc.Driver");

            // Establish the database connection
            connection = DriverManager.getConnection(url, username, password);

            String usernameParam = request.getParameter("username");

            // Check which button was clicked (Accept or Reject)
            if (request.getParameter("accept") != null) {
                // Update the status to 0 for Accept
                String updateQuery = "UPDATE requests SET status = 0 WHERE username = ?";
                preparedStatement = connection.prepareStatement(updateQuery);
                preparedStatement.setString(1, usernameParam);
                preparedStatement.executeUpdate();

                // Send a message to the user with the username
                response.getWriter().println("Status for user " + usernameParam + " set to 0. Message sent.");
            } else if (request.getParameter("reject") != null) {
                // Update the status to 1 for Reject
                String updateQuery = "UPDATE requests SET status = 1 WHERE username = ?";
                preparedStatement = connection.prepareStatement(updateQuery);
                preparedStatement.setString(1, usernameParam);
                preparedStatement.executeUpdate();

                // Delete the request row for status 1
                String deleteQuery = "DELETE FROM requests WHERE username = ? AND status = 1";
                preparedStatement = connection.prepareStatement(deleteQuery);
                preparedStatement.setString(1, usernameParam);
                preparedStatement.executeUpdate();

                response.getWriter().println("Status for user " + usernameParam + " set to 1. Request deleted.");
            }

            response.sendRedirect("MechanicRequests.jsp");

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Close the resources
            try {
                if (preparedStatement != null)
                    preparedStatement.close();
                if (statement != null)
                    statement.close();
                if (connection != null)
                    connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

}