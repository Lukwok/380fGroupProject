<!DOCTYPE html>
<html>
    <head>
        <title>Check out</title>
    </head>
    <body>       
        <a href="<c:url value="/system/viewcart" />">Back</a><br />
        <h1>Payment</h1>
        <form action="checkout" method="POST">
        <label for="username">Credit Card Number:</label><br/>
        <input type="text" id="username" name="username" /><br/><br/>
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <input type="submit" value="Pay"/>
        </form>

    </body>
</html>
