<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Create Order</title>
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
            padding: 0.3em 1em;
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

        .error {
            padding: 1em;
            background: #ffa99d;
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
    <h1>Order creation</h1>
    <div class="input-form">
        <div class="labels">
            <p>Product id:</p>
            <p>Quantity:</p>
        </div>
        <form action="${pageContext.request.contextPath}/create/order" method="post">
            <input type="number" name="productId" required>
            <input type="number" name="quantity" required>
            <input type="submit" name="action" value="Add one more product">
            <input type="submit" name="action" value="Create">
        </form>
    </div>

    <c:choose>
        <c:when test="${requestScope.error == 'productId'}">
            <div class="error">The product with given id was not found!</div>
        </c:when>
        <c:when test="${requestScope.error == 'alreadyInList'}">
            <div class="error">The product with given id has already been added to order!</div>
        </c:when>
    </c:choose>
</main>
</body>
</html>
