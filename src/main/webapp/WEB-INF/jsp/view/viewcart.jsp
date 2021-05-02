
<!DOCTYPE html>
<html>
    <head>
        <title>Shopping Cart</title>
    </head>
    <body>        
        <a href="<c:url value="/system/index" />">Back</a><br />
        <h1>Your shopping cart</h1>
        <c:choose>
            <c:when test="${empty cart}">
                Your cart is empty
            </c:when>
            <c:otherwise>
                <ul>
                <c:forEach var="cartItem" items="${cart}">
                    <li>${products[cartItem.key]} (qty: ${cartItem.value})</li>
                </c:forEach>
                </ul>
                <a href="<c:url value="/system/viewcart">
               <c:param name="action" value="checkout" />
                   </c:url>">Checkout</a>
            </c:otherwise>
        </c:choose>
        
    </body>
</html>
