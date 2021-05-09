<%-- 
    Document   : edit
    Created on : 2021年4月28日, 上午12:31:47
    Author     : 路過
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Edit</title>
        <style>
            #drop_zone {
                border: 5px solid gray;
                width:  200px;
                height: 100px;
            }
            .box__dragndrop,
            .box__uploading,
            .box__success,
            .box__error {
                display: none;
            }
            .box.has-advanced-upload {
                background-color: white;
                outline: 2px dashed black;
                outline-offset: -10px;
            }
            .box.has-advanced-upload .box__dragndrop {
                display: inline;
            }

        </style>
    </head>
    <body>
        <h2>Edit Personal Information</h2>
        <form:form method="POST" encrypt="mutipart/form-data"
                   modelAttribute="userForm">
            <form:label path="username">Username</form:label><br>
            <form:input path="username" type="text"  readonly="true"></form:input><br><br>
             <form:label path="password">New password</form:label><br>
            <form:input path="password" type="text"></form:input><br><br>
              Personal Information: <br><br>
            <form:label path="fullname">Full name</form:label><br>
            <form:input path="fullname" type="text" ></form:input><br><br>
            <form:label path="phone" >Phone Number</form:label><br>
            <form:input path="phone" pattern="[0-9]{8}" type="text" ></form:input><br><br>
            <form:label path="address">Address</form:label><br>
            <form:textarea path="address" rows="5" cols="30" /><br/><br/>
            <form:input path="roles" type="hidden" value="ROLE_USER"></form:input>
            <br><br>
            <input type="submit" value="update" />
        </form:form>
         <br><br> 
        <a href="<c:url value="/system/index" />">Cancel</a>  
        

    </body>
</html>
