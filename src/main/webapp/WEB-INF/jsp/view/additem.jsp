<%-- 
    Document   : additem
    Created on : 7 May 2021, 18:35:16
    Author     : ewenyau
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Add Product</title>
    </head>
    <body>
        <h2>Create New Product</h2>
        <form:form method="POST" encrypt="mutipart/form-data"
                   modelAttribute="product">
            <form:label path="itemname">Item Name</form:label><br>
            <form:input path="itemname" type="text"></form:input><br><br>
            <form:label path="description">Item Description</form:label><br>
            <form:input path="description" type="text"></form:input><br><br>
            <form:label path="price"> Price</form:label><br>
            <form:input path="price" type="text"></form:input><br><br>
            <form:input path="availability" type="hidden" value="Yes"></form:input>
            <form:input path="comments" type="hidden" value=""></form:input>
            <br><br>
            <input type="submit" value="Add New Product" />
        </form:form>

    </body>
</html>
