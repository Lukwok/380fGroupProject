<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Fast food ordering system</title>
    </head>
    <body>        
        <a href="<c:url value="/system/item?productId=${productId}" />">Back</a><br />
        <form:form method="POST" enctype="multipart/form-data"
                   modelAttribute="attachmentForm"> 
        <h1>Product description(${products[productId]})</h1>
        Item description:<br>
       <form:textarea path="description" rows="5" cols="30" /><br/><br/>
        Item price:<br>
        <form:input path="price" type="text" ></form:input><br><br>
        Availability:
        <form:select  path="availability">
            <form:option value="Yes">Yes</form:option>
            <form:option value="No">No</form:option>
        </form:select>
        <br><br>
        Image of the product: <br>
        <ul>
        <c:forEach items="${imageDatabase}" var="image">
            <li>
            <a href="<c:url value="/system/item/${productId}/attachment/${image.name}" />">
             <c:out value="${image.name}" />
            </a> 
             [<a href="<c:url value="/system/edit/${productId}/delete/${image.id}"/>">Delete</a>]
             </li>
        </c:forEach>
        </ul><br>
        Comments from registered users:<br/>
        <c:if test="${comments[0] != ''}">
            <c:forEach items="${comments}" var="comment" varStatus="idxStatus">
                ${comment}

                [<a href="<c:url value="/system/edit/${productId}/deletecm/${idxStatus.index}"/>">Delete</a>]

                <br/>
            
            </c:forEach>
        </c:if>
        
        <br/><br/>

               =============================================================================================== 
               <br>
                <label for="attachments">Upload Item Image:</label>
                <input type="file" name="attachments" multiple="multiple"accept="image/*"/><br/>
                <input id="itemid" name="itemid"   input="number" value="${productId}" hidden="true" readonly><br>
                <div>
                    <label>Your chosen image:</label>
                    <p id="filename">
                    </p>
                </div>
                <br>
                
                [<a href="<c:url value="/system/edit/${productId}/deleteitem"/>">Delete</a>]
                <br/>
                <br/>
                <input type="submit" value="Save">
    </form:form>

    </body>
    
      <script>
            var pullfiles=function(){
                // love the query selector
                var fileInput = document.querySelector('input[name="attachments"]');
                var files = fileInput.files;
                var filen = "";
               
               //number of uploaded files
                var fl = files.length;
                var i = 0;
                while ( i < fl) {
                    // localize file var in the loop
                    var file = files[i];
                    filen = filen+file.name+"<br>";
                    i++;
                }
                document.getElementById("filename").innerHTML=filen
            }
            //if user upload the photo
            document.querySelector('input[name="attachments"]').onchange=pullfiles;
        </script>

</html>
