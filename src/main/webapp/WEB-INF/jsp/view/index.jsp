<!DOCTYPE html>
<html>
    <head>
        <style>
            table, th, td {
                border: 1px solid black;
                border-collapse: collapse;
            }
            th, td {
                padding: 5px;
                text-align: left;    
            }
        </style>
        <title>Fast Food Ordering System</title>
    </head>
    <body>
        <h1>Fast Food Items List</h1>
        <security:authorize access ="isAnonymous()">
        <a href="<c:url value="/login" />">Login</a>
        </security:authorize>
        
        <security:authorize access="isAuthenticated()">
        <a href="<c:url value="/logout" />">Logout</a>
        <security:authorize access="hasRole('USER')">
        <a href="<c:url value="/reg/edit" />">Personal Information</a>
        </security:authorize>
        <security:authorize access="hasRole('ADMIN')">
            <a href="<c:url value="/reg/manage" />">Manage User</a>
        </security:authorize>
        <br /><br /> 
        </security:authorize>
        <a href="<c:url value="/system/viewcart" />">View cart and Check out</a>

        <a href="<c:url value="/system/favouritepage" />">Favourite page</a><br /><br />
        <table style="width:100%">
            <tr>
                <th>Product (Click to add to cart)</th>
                <th>Description</th> 
                    <security:authorize access="hasAnyRole('ADMIN','USER')">
                    <th>Favourite</th>
                    </security:authorize>
                    <security:authorize access="hasRole('ADMIN')">
                    <th>Set availability(Admin only)</th>
                    </security:authorize> 
            </tr>    
            <c:forEach var="product" items="${products}">
                <tr>
                    <td><a href="<c:url value="/system/index">
                               <c:param name="action" value="addToCart" />
                               <c:param name="productId" value="${product.key}" />
                           </c:url>">${product.value}</a<br /></td>
                    <td>
                        <a href="<c:url value="/system/item">
                               <c:param name="productId" value="${product.key}" />
                           </c:url>">Detail</a
                    </td>
                    <security:authorize access="hasAnyRole('ADMIN','USER')">
                        <td>
                            <a href="<c:url value="/system/favouritepage">
                                   <c:param name="setfavourite" value="Add" />
                                   <c:param name="productId" value="${product.key}" />
                               </c:url>">Add/</a>
                            <a href="<c:url value="/system/favouritepage">
                                   <c:param name="setfavourite" value="Del" />
                                   <c:param name="productId" value="${product.key}" />
                               </c:url>">Delete</a
                        </td>
                    </security:authorize>
                    <security:authorize access="hasRole('ADMIN')">
                        <td><a href="<c:url value="/system/setavailability">
                                   <c:param name="setavailability" value="Yes" />
                                   <c:param name="productId" value="${product.key}" />
                               </c:url>">Yes/</a>
                            <a href="<c:url value="/system/setavailability">
                                   <c:param name="setavailability" value="No" />
                                   <c:param name="productId" value="${product.key}" />
                               </c:url>">No</a
                        </td>
                    </security:authorize>
                </tr>
            </c:forEach>
        </table>
    </body>
</html>
