<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Fast food ordering system</title>
    </head>
    <body>        
        <a href="<c:url value="/system/index" />">Back</a>
        <security:authorize access="hasRole('ADMIN')"> 
         <a href="<c:url value="/system/edit">
                        <c:param name="productId" value="${productId}" />
           </c:url>">
           Edit</a
         </security:authorize>
         <br />
        <h1>Product description(${products[productId]})</h1><br><br>
        
        Item description:${itemdesciption[productId][0]}<br/>
        Item price:${itemdesciption[productId][1]}<br/>
        Availability:${itemdesciption[productId][2]}<br/><br/>
        Image of the product: <br>
        <c:forEach items="${imageDatabase}" var="image">
            <a href="<c:url value="/system/item/${productId}/attachment/${image.name}" />">
             <c:out value="${image.name}" /></a>
             <br>
        </c:forEach>
             <br>
        Comments from registered users:<br/>
        ${itemdesciption[productId][3]}<br/><br/>
        
        
        <br/><br/>

        <security:authorize access="hasAnyRole('ADMIN','USER')"> 
            <form:form method="POST" encrypt="mutipart/form-data"
                       modelAttribute="commentForm">
                <form:input path="addComment" type="text"></form:input><br><br>                             
                    <input type="submit" value="add comment" />
            </form:form>
        </security:authorize>
                    
</html>
