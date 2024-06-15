<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

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
    padding-top: 50px;
    padding-bottom: 260px;
    margin-left: 450px;
    font-size: 20px;
}

/* profile Section Ends */

form input[type="text"],
			input[type="email"],input[type="password"]{
			color:gray;
            width: 60%;
            font-size: 12px;
            padding: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: white;
        }
        
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
            <%@page import="java.sql.ResultSet"%>
			<%@page import="java.sql.Statement"%>
			<%@page import="java.sql.Connection"%>
			<%@page import="java.sql.DriverManager"%>
			<%@ page import="java.sql.*" %>
    <%
        
        
        // Fetching data from the database for the selected mechanic
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "Tanaya@3502");
            PreparedStatement ps = con.prepareStatement("SELECT * FROM mechanic WHERE username = ?");
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String Email = rs.getString("email");
                String Password = rs.getString("password");
                String Contact = rs.getString("contact");
                String Qualification = rs.getString("qualification");
                String Address = rs.getString("address");
    %>

    <h2>Update <%= username %>'s Profile</h2><br>

    <form action="MechanicUpdateSuccessfully.jsp" >
        <!-- Display username (non-editable) -->
        <label for="username">Username (non-editable):</label><br>
        <input type="text" id="username" name="username" value="<%= username %>" disabled readonly><br><br>


        <!-- Allow updating password, contact, qualification, and address -->
        <label for="password">Password:</label><br>
        <input type="password" id="password" name="password" value="<%= Password %>" required ><br><br>

        <label for="contact">Contact:</label><br>
        <input type="text" id="contact" name="contact" value="<%= Contact %>" required><br><br>

        <label for="qualification">Qualification:</label><br>
        <input type="text" id="qualification" name="qualification" value="<%= Qualification %>" required><br><br>

        <label for="address">Address:</label><br>
        <input type="text" id="address" name="address" value="<%= Address %>" required><br><br>

        <!-- Submit button to update profile -->
        <input type="submit" value="Update Profile" class="update-btn">
        <a href="MechanicProfile.jsp" class="update-btn">Back To Profile</a><br><br>
    </form>
</div>
    <%
                }
            rs.close();
            ps.close();
            con.close();
        } catch (Exception e) {
            out.println(e);
            e.printStackTrace();
        }
    %>
</body>
</html>
