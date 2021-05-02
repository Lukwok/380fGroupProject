<%-- 
    Document   : login
    Created on : 2021年4月25日, 下午6:46:36
    Author     : 路過
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html>
    <head>
        <title>Login</title>
    </head>
    <body>
        <c:if test="${param.error != null}">
            <p>Login failed.</p>
        </c:if>
        <c:if test="${param.logout != null}">
            <p>You have logged out.</p>
        </c:if>
        <h2>Fast Food Ordering Login</h2>
        <form method="POST">
            <label for="username">Username:</label><br/>
            <input type="text" id="username" name="username" /><br/><br/>
            <label for="password">Password:</label><br/>
            <input type="password" id="password" name="password" /><br/><br/>
            <input type="checkbox" id="remember-me" name="remember-me" />
            <label for="remember-me">Remember me</label><br/><br/>
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <input type="submit" formaction="login"  value="Log In"/>
        </form>
         <br><br> 
         <a href="<c:url value="/reg/logon" />">Create New User</a>
        <a href="<c:url value="/system/index" />">Back</a>
    </body>
</html>
