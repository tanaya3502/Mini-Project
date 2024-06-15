<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Profile Servlet</title>
</head>
<body>
<style>
* {
    padding: 0;
    margin: 0;
    box-sizing: border-box;
    color: aliceblue;
}

html {
    scroll-behavior: smooth;
    overflow-y: hidden;
}

body {
    font-family: "Lato", sans-serif;
    background-color: #111;
}

/* Nav Section Starts */



.sidenav {
    height: 100%;
    width: 331px;
    position: fixed;
    z-index: 1;
    top: 0;
    left: 0;
    background-color: #1d1919;
    overflow-y: hidden;
    padding-top: 10px;
}


.img {
    color: white;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    height: 250px;
}

.img img {
    border-radius: 50%;
}


.img-name {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    gap: 14px;
}

.img-name h2 {
    padding-top: 11px;
    font-size: 26px;
    font-weight: 100;
    color: white;


    /* for linear-gradient */
    /* background: -webkit-linear-gradient(#ee7752, #e73c7e, #23a6d5, #23d5ab);
    animation: 2s ease infinite;
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent; */
}


.img-name h3 {
    font-size: 18px;
    font-weight: 100;
    color: deeppink;
}

.sidenav ul {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    height: 42vh;
    gap: 23px;
    padding-left: 0px;
    margin: 8px;
    padding-right: 33px;
}

.sidenav a {
    padding: 6px 6px 6px 32px;
    text-decoration: none;
    font-size: 25px;
    color: #818181;
    display: block;
}

.sidenav a:hover {
    color: deeppink;
    text-decoration: underline;
}



/* Nav Section Ends */


/* Main Section Starts */


section.main {
    margin-left: 410px;
    margin-top: 50px;
    font-weight: initial;
    margin-right: 200px;
}

.update-btn
{
    padding: 8px 15px;
    margin-right: 5px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    border-radius: 4px;
    cursor: pointer;
    background-color: #4CAF50;
    color: white;
}

/* profile Section Starts */

#profile {
    background-size: cover;
    padding-top: 70px;
    padding-bottom: 260px;
    margin-left: 570px;
    margin-top: 200px;
    font-size: 30px;
}

/* profile Section Ends */

        
 .update-btn
{
    padding: 10px 14px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    border-radius: 4px;
    cursor: pointer;
    background-color: #4CAF50;
    color: white;
    font-size:14px;
    margin-left: 190px;
}       
</style>
<body>
<%
    String username = (String) session.getAttribute("username");
%>

 <!-- Navbar starts-->
    <section>
        <div class="sidenav">
            <div class="img">
                <div class="img-name">
                    <h1><%= username %></h1>
                </div>
            </div>
            <ul><a href="MechanicProfile.jsp">Profile</a>
                <a href="MechanicRequests.jsp">Requests</a>
                <a href="UserRequestStatus.html">Payment Status</a>
                <a href="MechanicLogout.jsp">Logout</a>
            </ul>
        </div>
    </section>
    <div id="profile">
    <%
        // Retrieve form parameters
        String userName = request.getParameter("username");
        String password = request.getParameter("password");
        String contact = request.getParameter("contact");
        String qualification = request.getParameter("qualification");
        String address = request.getParameter("address");

        Connection con = null;
        PreparedStatement ps = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "Tanaya@3502");
            
            // Update query excluding email field
            String updateQuery = "UPDATE mechanic SET password=?, contact=?, qualification=?, address=? WHERE username=?";
            ps = con.prepareStatement(updateQuery);

            // Set parameters for update query
            ps.setString(1, password);
            ps.setString(2, contact);
            ps.setString(3, qualification);
            ps.setString(4, address);
            ps.setString(5, username);

            // Execute update query
            int updatedRows = ps.executeUpdate();

            if (updatedRows > 0) {
    %>
                <h3>Profile Updated Successfully!</h3><br>
                <a href="MechanicProfile.jsp" class="update-btn">Back To Profile</a><br><br>
                <%-- response.sendRedirect("success.jsp"); --%>
    <%
            } else {
    %>
                <h3>Failed to update profile.</h3><br>
                <a href="MechanicProfileUpdate.jsp" class="update-btn">Back To Profile</a><br><br>
    <%
            }
        } catch (ClassNotFoundException | SQLException e) {
    %>
            <h3>Error: <%= e.getMessage() %></h3>
    <%
        } 
    %>
   </div>
</body>
</html>
