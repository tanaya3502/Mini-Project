<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import="javax.servlet.*"%>
<%@ page import="javax.servlet.http.*"%>

<%
    // Database connection details
    String url = "jdbc:mysql://localhost:3306/project";
    String username = "root";
    String password = "Tanaya@3502";

    Connection connection = null;
    Statement statement = null;
    ResultSet resultSet = null;

    try {
        // Load the JDBC driver
        Class.forName("com.mysql.jdbc.Driver");

        // Establish the database connection
        connection = DriverManager.getConnection(url, username, password);

        // Create a statement
        statement = connection.createStatement();

        // Execute a query to retrieve users with status = 0
        String sqlQuery = "SELECT username FROM requests WHERE status = 0";
        resultSet = statement.executeQuery(sqlQuery);

        // Display messages for accepted requests
        out.println("<html>");
        out.println("<head>");
        out.println("<title>Accepted Requests</title>");
        out.println("</head>");
        out.println("<body>");

        while (resultSet.next()) {
            String user = resultSet.getString("username");
            out.println("<p><font size = '20'>Dear " + user + ", your request has been accepted.Thank you!</p>");
        }

        out.println("</body>");
        out.println("</html>");

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // Close the resources
        try {
            if (resultSet != null) resultSet.close();
            if (statement != null) statement.close();
            if (connection != null) connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
