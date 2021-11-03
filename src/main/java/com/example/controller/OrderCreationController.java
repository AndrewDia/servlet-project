package com.example.controller;

import com.example.dao.OrderDAO;
import com.example.dao.ProductDAO;
import com.example.model.Order;
import com.example.model.OrderProduct;
import com.example.model.Product;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OrderCreationController extends HttpServlet {
    private OrderDAO orderDAO = new OrderDAO();
    private ProductDAO productDAO = new ProductDAO();
    private int userId = 1000 + (int) (Math.random() * 999);

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        RequestDispatcher dispatcher = req.getRequestDispatcher("/createOrder.jsp");
        dispatcher.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int productId = Integer.parseInt(req.getParameter("productId"));
        int quantity = Integer.parseInt(req.getParameter("quantity"));
        RequestDispatcher dispatcher = req.getRequestDispatcher("/createOrder.jsp");

        Product product = productDAO.getProduct(productId);

        if (product == null) {
            req.setAttribute("error", "productId");
            dispatcher.forward(req, resp);
            return;
        }

        HttpSession session = req.getSession();
        List<OrderProduct> products;
        if (session.getAttribute("productsList") == null)
            products = new ArrayList<>();
        else
            products = (List<OrderProduct>) session.getAttribute("productsList");

        if (req.getParameter("action").equals("Create")) {
            products.add(new OrderProduct(productId, quantity));
            try {
                orderDAO.createOrderWithProducts(Order.createOrder(userId, "new"), products);
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
            session.invalidate();
        } else if (req.getParameter("action").equals("Add one more product")) {
            for (OrderProduct op : products)
                if (productId == op.getProductId()) {
                    req.setAttribute("error", "alreadyInList");
                    dispatcher.forward(req, resp);
                    return;
                }
            products.add(new OrderProduct(productId, quantity));
            session.setAttribute("productsList", products);
        }

        dispatcher.forward(req, resp);
    }
}
