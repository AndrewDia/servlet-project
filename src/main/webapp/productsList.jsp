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
            margin-top: 1.5em;
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

        form {
            margin: 0;
        }

        .buttons {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        input[type=submit], button, .cancel {
            padding: 0.3em 1.3em;
            background: #4f606c;
            color: white;
            font-size: 1.1em;
            border: 0;
        }

        .delete_button {
            background: none !important;
            color: red !important;
            padding: 0 !important;
            width: 100%;
            cursor: pointer;
        }

        /*****confirm******/

        body._lock {
            overflow: hidden;
        }

        .confirm_bg {
            width: 100%;
            height: 100%;
            position: fixed;
            top: 0;
            left: 0;
            background: rgba(3, 3, 3, 0.59);
            z-index: 2;
            backdrop-filter: blur(5px);
            display: none;
            align-items: center;
            justify-content: center;
        }

        .confirm_bg._active {
            display: flex;
        }

        .confirm-form {
            background: white;
            border: 2px solid black;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-direction: column;
            padding: 2.5em;
            width: fit-content;
        }

        input[type=password] {
            margin-bottom: 1.5em;
            font-size: 1em;
        }

        .cancel {
            margin-left: 2em;
        }

        h3 {
            margin-top: 0;
        }

        /***endOfConfirm***/
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
    <h1>List of products</h1>
    <div class="buttons">
        <form action="${pageContext.request.contextPath}/list/products" method="get">
            <button type="submit" name="filter" value="ordered">Ordered at least once</button>
        </form>
        <input type="submit" name="deleteAll" value="Delete all products" style="background: #ff4d46"
               class="delete_all">
    </div>
    <c:set var="isEmpty" value="true"/>
    <table>
        <c:if test="${requestScope.productsList != null && requestScope.productsList.size() != 0}">
            <c:set var="isEmpty" value="false"/>
            <tr>
                <th>Id</th>
                <th>Name</th>
                <th>Price</th>
                <th>Status</th>
                <th></th>
            </tr>
            <c:forEach var="product" items="${requestScope.productsList}">
                <tr>
                    <td><c:out value="${product.id}"/></td>
                    <td><c:out value="${product.name}"/></td>
                    <td><c:out value="${product.price}"/></td>
                    <td><c:out value="${product.status.productStatus}"/></td>
                    <td>
                        <form action="${pageContext.request.contextPath}/list/products" method="post">
                            <input type="hidden" name="action" value="delete_product">
                            <input type="hidden" name="productId" value="${product.id}">
                            <input type="submit" value="&#10060;" class="delete_button">
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </c:if>
        <c:if test="${requestScope.orderedProductsList != null && requestScope.orderedProductsList.size() != 0}">
            <c:set var="isEmpty" value="false"/>
            <tr>
                <th>Id</th>
                <th>Name</th>
                <th>Price</th>
                <th>Status</th>
                <th>Total Ordered Quantity</th>
                <th>&nbsp;</th>
            </tr>
            <c:forEach var="product" items="${requestScope.orderedProductsList}">
                <tr>
                    <td><c:out value="${product.id}"/></td>
                    <td><c:out value="${product.name}"/></td>
                    <td><c:out value="${product.price}"/></td>
                    <td><c:out value="${product.status}"/></td>
                    <td><c:out value="${product.orderQuantity}"/></td>
                    <td>
                        <form action="${pageContext.request.contextPath}/list/products" method="post">
                            <input type="hidden" name="productId" value="${product.id}">
                            <input type="submit" value="&#10060;" class="delete_button">
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </c:if>
    </table>
    <c:if test="${isEmpty == true}">
        <h2>No products found</h2>
    </c:if>
    <div class="confirm_bg">
        <div class="confirm-form">
            <h3>Enter the password: </h3>
            <form action="${pageContext.request.contextPath}/list/products" method="post">
                <input type="password" name="password" required>
                <div class="buttons">
                    <button type="submit" name="action" value="delete_all">Confirm</button>
                    <div class="cancel" style="background: #ff4d46">Cancel</div>
                </div>
            </form>
            <c:if test="${requestScope.allDeleted == false}">
                <i style="color: red">Wrong password!</i>
            </c:if>
        </div>
    </div>
    <script>
        const deleteAll = document.querySelector('.delete_all');
        if (deleteAll) {
            const choosePizza = document.querySelector('.confirm_bg');
            deleteAll.addEventListener("click", function (e) {
                document.body.classList.add('_lock');
                choosePizza.classList.add('_active');
            });
        }

        const cancel = document.querySelector('.cancel');
        if (cancel) {
            const choosePizza = document.querySelector('.confirm_bg');
            cancel.addEventListener("click", function (e) {
                document.body.classList.remove('_lock');
                choosePizza.classList.remove('_active');
            });
        }
    </script>
</main>
</body>
</html>
