package com.example.controller;

import com.example.dao.ProductDAO;
import com.example.util.ConnectionProperties;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

public class ProductsListController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProductDAO dao = new ProductDAO();
        String filter = request.getParameter("filter");
        if (filter != null && filter.equals("ordered"))
            request.setAttribute("orderedProductsList", dao.findOrderedProducts());
        else
            request.setAttribute("productsList", dao.findAllProducts());
        RequestDispatcher dispatcher = request.getRequestDispatcher("/productsList.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProductDAO dao = new ProductDAO();
        if (request.getParameter("action").equals("delete_product")) {
            int productId = Integer.parseInt(request.getParameter("productId"));
            dao.deleteProduct(productId);
        } else if (request.getParameter("action").equals("delete_all")) {
            if (request.getParameter("password").equals(ConnectionProperties.getPassword())) {
                try {
                    dao.deleteAllProducts();
                } catch (SQLException throwables) {
                    throwables.printStackTrace();
                }
            }
        }
        response.sendRedirect("/list/products");
    }
}
