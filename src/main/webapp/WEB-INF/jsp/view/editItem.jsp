<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Fast food ordering system</title>
    </head>
    <body>        
        <a href="<c:url value="/system/item?productId=${productId}" />">Back</a><br />
        <h1>Product description(${products[productId]})</h1>
        Item description:${itemdesciption[productId][0]}<br/>
        Item price:${itemdesciption[productId][1]}<br/>
        Availability:${itemdesciption[productId][2]}<br/><br/>
        Image of the product: <br>
        <ul>
        <c:forEach items="${imageDatabase}" var="image">
            <li>
            <a href="<c:url value="/system/item/${productId}/attachment/${image.name}" />">
             <c:out value="${image.name}" /></a> [<a href="<c:url
                            value="/system/edit/${productId}/delete/${image.id}"
                            />">Delete</a>]
             </li>
        </c:forEach>
        </ul><br>
        Comments from registered users:<br/>
        ${itemdesciption[productId][3]}<br/><br/>

           <form:form method="POST" enctype="multipart/form-data"
           modelAttribute="attachmentForm"> 
                <label for="attachments">Upload Item Image:</label>
                <input type="file" name="attachments" multiple="multiple"accept="image/*"/><br/><br/>
                <input id="itemid" name="itemid"   input="number" value="${productId}" hidden="true" readonly><br>
                <input type="submit" value="Upload">
            </form:form>
            <div>
                <br/>
                <label>Your chosen image:</label>
                <p id="filename">
                </p>
            </div>

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
