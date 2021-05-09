<!DOCTYPE html>
<html>
    <head>
        <title>Favourite fast food</title>
    </head>
    <body>        
         <a href="<c:url value="/system/index" />">Back</a><br />
        <h1>Favourite list</h1>
        <c:choose>
            <c:when test="${empty favourite}">
                Your favourite list is empty
            </c:when>
            <c:otherwise>
                <ul>
                <c:forEach var="favouriteitem" items="${favourite}">
                    <li>${products[favouriteitem.value]}</li>
                </c:forEach>
                </ul>
            </c:otherwise>
        </c:choose>
    </body>
</html>
