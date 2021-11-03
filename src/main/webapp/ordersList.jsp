<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Products List</title>
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

        table {
            border-collapse: collapse;
            width: 100%;
        }

        td, th {
            border-top: 1px solid #4f606c;
            border-bottom: 1px solid #4f606c;
            text-align: left;
            padding: 10px;
        }

        td:first-child, th:first-child {
            border-left: 1px solid #4f606c;
        }

        td:last-child, th:last-child {
            border-right: 1px solid #4f606c;
        }

        th {
            background-color: #dddddd;
        }

        td form {
            margin: 0;
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
    <h1>List of orders</h1>
    <table>
        <tr>
            <th>Order ID</th>
            <th>Products total Price</th>
            <th>Product Name</th>
            <th>Products Quantity</th>
            <th>Order Created Date</th>
        </tr>
        <c:forEach var="order" items="${requestScope.ordersList}">
            <tr>
                <td><c:out value="${order.orderId}"/></td>
                <td><c:out value="${order.productsTotalPrice}"/></td>
                <td><c:out value="${order.productName}"/></td>
                <td><c:out value="${order.productsQuantity}"/></td>
                <td><c:out value="${order.orderCreatedAt}"/></td>
            </tr>
        </c:forEach>
    </table>
</main>
</body>
</html>
