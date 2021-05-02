<%-- 
    Document   : listuser
    Created on : 2021年4月26日, 下午10:15:20
    Author     : 路過
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <body>
        <a href="<c:url value="/system/index" />">Back</a>
        <h2>Users</h2>
        <a href="<c:url value="/reg/logon" />">Create a User</a><br /><br />
        <c:choose>
            <c:when test="${fn:length(ticketUsers) == 0}">
                <i>There are no users in the system.</i>
            </c:when>
            <c:otherwise>
                <table>
                    <tr>
                        <th>Username</th><th>Password</th><th>Roles</th><th>Action</th>
                    </tr>
                    <c:forEach items="${ticketUsers}" var="user">
                        <tr>
                            <td>${user.username}</td><td>${user.password}</td>
                            <td>
                                <c:forEach items="${user.roles}" var="role" varStatus="status">
                                    <c:if test="${!status.first}">, </c:if>
                                    ${role.role}
                                </c:forEach>
                            </td>
                            <td>
                                [<a href="<c:url value="/user/delete/${user.username}" />">Delete</a>]
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </c:otherwise>
        </c:choose>
