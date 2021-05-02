<%-- 
    Document   : userlist
    Created on : 2021年4月28日, 上午4:26:02
    Author     : 路過
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <body>
        <a href="<c:url value="/system/index" />">Back</a>
        <h2>Users Managment</h2>
        <a href="<c:url value="/reg/logon" />">Create a User</a><br /><br />
        <c:choose>
            <c:when test="${fn:length(users) == 0}">
                <i>There are no users in the system.</i>
            </c:when>
            <c:otherwise>
                <table>
                    <tr>
                        <th>Username</th><th>Fullname</th><th>Phone</th><th>Address</th><th>Roles</th><th>Action</th>
                    </tr>
                    <c:forEach items="${users}" var="user">
                        <tr>
                            <td>${user.username}</td>
                            <td>${user.fullname}</td>
                            <td>${user.phone}</td>
                            <td>${user.address}</td>
                            <td>
                                <c:forEach items="${user.roles}" var="role" varStatus="status">
                                    <c:if test="${!status.first}">, </c:if>
                                    ${role.role}
                                </c:forEach>
                            </td>
                            <td>
                                [<a href="<c:url value="/reg/manage/delete/${user.username}" />">Delete</a>]
                                [<a href="<c:url value="/reg/manage/edit/${user.username}" />">Edit</a>]
                            </td>
                        </tr>
                    </c:forEach>
                </table>