<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Fast food ordering system</title>
    </head>
    <style>
        * {
            box-sizing: border-box;
        }

        .column {
            float: left;
            width: 25%;
            padding: 5px;
        }

        /* Clearfix (clear floats) */
        .row::after {
            content: "";
            clear: both;
            display: table;
        }
    </style>
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
        <div class="row">
                    <c:forEach items="${imageDatabase}" var="image">
                        <div class="column">
                        <img src="<c:url value="/system/item/${productId}/attachment/${image.name}" />" style="width:100%"/>
                        </div>
                    </c:forEach>
        </div>
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
