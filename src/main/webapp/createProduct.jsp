<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">
<head>
    <title>Create Product</title>
    <meta charset="UTF-8">
    <style>
        body {
            font-family: sans-serif;
            margin: 0;
        }

        nav {
            position: fixed;
            top: 0;
            left: 0;
            width: 25%;
            height: 100%;
            background: #4f606c;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        ul {
            list-style-type: none;
            padding: 0;
            margin-top: 4em;
        }

        li {
            margin: 1.3em 0;
        }

        li:first-child {
            margin-top: 0;
        }

        a {
            text-decoration: none;
        }

        li a {
            font-size: 1.35em;
            text-transform: uppercase;
            color: white;
            font-weight: bold;
        }

        li a:hover {
            color: #98aab4;
        }

        main {
            margin-left: 25%;
            padding: 4em 3em;
        }

        h1 {
            margin-top: 0;
        }

        .input-form {
            display: flex;
        }

        .labels {
            margin-top: 0.3em;
        }

        p {
            margin-top: 0;
            margin-bottom: 1em;
        }

        form {
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            align-items: flex-start;
            margin-left: 1em;
        }

        input {
            margin-bottom: 0.7em;
            font-size: 1em;
        }

        input[type=submit] {
            width: 100px;
            height: 30px;
            background: #4f606c;
            color: white;
            font-size: 1.1em;
            margin-top: 1em;
            border: 0;
        }

        input[type=submit]:hover {
            background: #98aab4;
            transition: 0.3s;
        }

        #success {
            padding: 1em;
            background: #bdffbf;
            font-size: 1.1em;
            border-radius: 15px;
        }
    </style>
</head>
<body>
<nav>
    <ul>
        <li><a href="${pageContext.request.contextPath}/">Home</a></li>
        <li>&nbsp;</li>
        <li><a href="${pageContext.request.contextPath}/list/products">List of products</a></li>
        <li><a href="${pageContext.request.contextPath}/list/orders">List of orders</a></li>
        <li>&nbsp;</li>
        <li><a href="${pageContext.request.contextPath}/create/product">Create product</a></li>
        <li><a href="${pageContext.request.contextPath}/create/order">Create order</a></li>
    </ul>
</nav>
<main>
    <h1>Product creation</h1>
    <div class="input-form">
        <div class="labels">
            <p>Name:</p>
            <p>Price:</p>
            <p>Status:</p>
        </div>
        <form action="${pageContext.request.contextPath}/create/product" method="post">
            <input type="text" name="productName" required>
            <input type="number" name="productPrice" required>
            <div>
                <input type="radio" id="status1" name="status" value="out_of_stock" checked>
                <label for="status1">out of stock</label>
                <input type="radio" id="status2" name="status" value="in_stock">
                <label for="status2">in stock</label>
                <input type="radio" id="status3" name="status" value="running_low">
                <label for="status3">running low</label>
            </div>
            <%--            <input type="hidden" name="action" value="create">--%>
            <input type="submit" value="Create">
        </form>
    </div>
    <c:if test="${sessionScope.productSuccessful == true}">
        <div id="success">Product was successfully created!</div>
        <c:remove var="productSuccessful"/>
    </c:if>
</main>
<script type="text/javascript">
    // close the div in 5 secs
    window.setTimeout("closeDiv();", 5000);

    function closeDiv(){
        document.getElementById("success").style.display=" none";
    }
</script>
</body>
</html>
