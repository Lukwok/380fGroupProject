<%-- 
    Document   : logon
    Created on : 2021年4月26日, 上午1:28:15
    Author     : 路過
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Logon</title>
    </head>
    <body>
        <h2>Create New User</h2>
        <form:form method="POST" encrypt="mutipart/form-data"
                   modelAttribute="user">
            <form:label path="username">Username</form:label><br>
            <form:input path="username" type="text"></form:input><br><br>
            <form:label path="password">Password</form:label><br>
            <form:input path="password" type="text"></form:input><br><br>
              Personal Information:<br><br>
            <form:label path="fullname">Full name</form:label><br>
            <form:input path="fullname" type="text"></form:input><br><br>
            <form:label path="phone" >Phone Number</form:label><br>
            <form:input path="phone" pattern="[0-9]{8}" type="text"></form:input><br><br>
            <form:label path="address">Address</form:label><br>
            <form:textarea path="address" rows="5" cols="30" /><br/><br/>
            <form:input path="roles" type="hidden" value="ROLE_USER"></form:input>
            <br><br>
            <input type="submit" value="Create" />
        </form:form>
         <br><br> 
        <a href="<c:url value="/login" />">Cancel</a>
        
    </body>
</html>
