package com.example.dao;

import com.example.dto.OrderDTO;
import com.example.model.Order;
import com.example.model.OrderProduct;
import com.example.util.ConnectionPoolHolder;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {
    public int insertOrder(Connection connection, Order order) {
        ResultSet resultSet = null;
        try (PreparedStatement preparedStatement = connection.prepareStatement(
                SQLConstants.ADD_NEW_ORDER, Statement.RETURN_GENERATED_KEYS)) {
            preparedStatement.setInt(1, order.getUserId());
            preparedStatement.setString(2, order.getStatus());
            preparedStatement.setTimestamp(3, order.getCreatedAt());
            preparedStatement.executeUpdate();
            resultSet = preparedStatement.getGeneratedKeys();
            if (resultSet.next())
                order.setId(resultSet.getInt(1));
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (resultSet != null)
                    resultSet.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return order.getId();
    }

    public Order getOrder(int id) {
        Order order = null;
        ResultSet resultSet = null;
        try (Connection connection = ConnectionPoolHolder.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(
                     SQLConstants.FIND_ORDER_BY_ID, Statement.RETURN_GENERATED_KEYS)) {
            preparedStatement.setInt(1, id);
            resultSet = preparedStatement.executeQuery();
            if (resultSet.next())
                order = mapOrder(resultSet);
            else
                return null;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (resultSet != null)
                    resultSet.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return order;
    }

    public void createOrderWithProducts(Order order, List<OrderProduct> orderProducts) throws SQLException {
        Connection connection = null;
        try {
            connection = ConnectionPoolHolder.getConnection();
            connection.setAutoCommit(false);
            int orderId = insertOrder(connection, order);
            for (OrderProduct product : orderProducts)
                addProductForOrder(connection, orderId, product.getProductId(), product.getQuantity());
            connection.commit();
        } catch (SQLException e) {
            connection.rollback();
            e.printStackTrace();
        } finally {
            if (connection != null)
                connection.close();
        }
    }

    public void addProductForOrder(Connection connection, int orderId, int productId, int quantity) {
        try (PreparedStatement preparedStatement = connection.prepareStatement(SQLConstants.ADD_NEW_ORDER_ENTRY)) {
            preparedStatement.setInt(1, orderId);
            preparedStatement.setInt(2, productId);
            preparedStatement.setInt(3, quantity);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<OrderDTO> findAllOrders() {
        List<OrderDTO> orders = new ArrayList<>();
        try (Connection connection = ConnectionPoolHolder.getConnection();
             Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(SQLConstants.FIND_ORDER_ENTRIES)) {
            while (resultSet.next()) {
                OrderDTO orderDTO = new OrderDTO();
                orderDTO.setOrderId(resultSet.getInt(1));
                orderDTO.setProductsTotalPrice(resultSet.getInt(2));
                orderDTO.setProductName(resultSet.getString(3));
                orderDTO.setProductsQuantity(resultSet.getInt(4));
                orderDTO.setOrderCreatedAt(resultSet.getString(5));
                orders.add(orderDTO);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    private Order mapOrder(ResultSet resultSet) throws SQLException {
        Order order = new Order();
        order.setId(resultSet.getInt(1));
        order.setUserId(resultSet.getInt(2));
        order.setStatus(resultSet.getString(3));
        order.setCreatedAt(resultSet.getTimestamp(4));
        return order;
    }
}
