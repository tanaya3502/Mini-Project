<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <%@page import="java.sql.ResultSet"%>
			<%@page import="java.sql.Statement"%>
			<%@page import="java.sql.Connection"%>
			<%@page import="java.sql.DriverManager"%>
			<%@ page import="java.sql.*" %>
		

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Display Requests</title>
</head>
<body>
    <h1>Requests Information</h1>

            <% 
            ResultSet resultSet = (ResultSet)request.getAttribute("resultSet");
            if (resultSet != null) {
                while (resultSet.next()) {
                    String username = resultSet.getString("username");
                    String email = resultSet.getString("email");
                    String Contact = resultSet.getString("contact");
                    String VehicleNo = resultSet.getString("vehicle_no");
                    String VehicleType = resultSet.getString("vehicle_type");
                    String ServiceType = resultSet.getString("service_type");
                    String Date = resultSet.getString("request_date");
                    String Address = resultSet.getString("address");
                    String Status = resultSet.getString("status");

                    
                    // Retrieve other columns as needed

                    // Display data in table rows
            %>
                    
                        Username:<%= username %><br>
                        Email:<%= email %><br>
                        Contact:<%= Contact %><br>
            			VehicleNo:<%= VehicleNo %><br>
            			VehicleType:<%= VehicleType %><br>
            			ServiceType:<%= ServiceType %><br>
            			Date:<%= Date %><br>
            			Address:<%= Address %><br>
            			Status <%= Status %><br>
            			<form action ="request" method= "post">
            			<input type="hidden" name="username" value= "<%=username%>">
            			<input type="submit" name="accept" value="Accept">
            			<input type="submit" name="reject" value="Reject">
            			
            			</form>

                    
            <%
                }
                resultSet.close();
            } else {
                out.println("No data available.");
            }
            %>
        </tbody>
    </table>
</body>
</html>
