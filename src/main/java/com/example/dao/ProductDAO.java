package com.example.dao;

import com.example.dto.OrderedProductDTO;
import com.example.model.Product;
import com.example.model.ProductsStatus;
import com.example.util.ConnectionPoolHolder;
import com.example.util.ConnectionProperties;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {
    public Product insertProduct(Product product) {
        ResultSet resultSet = null;
        try (Connection connection = ConnectionPoolHolder.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(
                     SQLConstants.ADD_NEW_PRODUCT, Statement.RETURN_GENERATED_KEYS)) {
            preparedStatement.setString(1, product.getName());
            preparedStatement.setInt(2, product.getPrice());
            preparedStatement.setString(3, product.getStatus().getProductStatus());
            preparedStatement.setTimestamp(4, product.getCreatedAt());
            preparedStatement.executeUpdate();
            resultSet = preparedStatement.getGeneratedKeys();
            if (resultSet.next())
                product.setId(resultSet.getInt(1));
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
        return product;
    }

    public Product getProduct(int id) {
        Product product = null;
        ResultSet resultSet = null;
        try (Connection connection = ConnectionPoolHolder.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(
                     SQLConstants.FIND_PRODUCT_BY_ID, Statement.RETURN_GENERATED_KEYS)) {
            preparedStatement.setInt(1, id);
            resultSet = preparedStatement.executeQuery();
            if (resultSet.next())
                product = mapProduct(resultSet);
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
        return product;
    }

    public List<Product> findAllProducts() {
        List<Product> products = new ArrayList<>();
        try (Connection connection = ConnectionPoolHolder.getConnection();
             Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(SQLConstants.FIND_ALL_PRODUCTS)) {
            while (resultSet.next())
                products.add(mapProduct(resultSet));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public boolean isProductInOrder(int orderId, int productId) {
        ResultSet resultSet = null;
        try (Connection connection = ConnectionPoolHolder.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(
                     SQLConstants.FIND_ORDER_ENTRY, Statement.RETURN_GENERATED_KEYS)) {
            preparedStatement.setInt(1, orderId);
            preparedStatement.setInt(2, productId);
            resultSet = preparedStatement.executeQuery();
            return resultSet.next();
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
        return false;
    }

    public List<OrderedProductDTO> findOrderedProducts() {
        List<OrderedProductDTO> products = new ArrayList<>();
        try (Connection connection = ConnectionPoolHolder.getConnection();
             Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(SQLConstants.FIND_ORDERED_PRODUCTS)) {
            while (resultSet.next()) {
                OrderedProductDTO product = new OrderedProductDTO();
                product.setId(resultSet.getInt(1));
                product.setName(resultSet.getString(2));
                product.setPrice(resultSet.getInt(3));
                product.setStatus(resultSet.getString(4));
                product.setOrderQuantity(resultSet.getInt(5));
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public void deleteProduct(int productId) {
        try (Connection connection = ConnectionPoolHolder.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SQLConstants.DELETE_PRODUCT)) {
            preparedStatement.setInt(1, productId);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteAllProducts() throws SQLException {
        Connection connection = ConnectionPoolHolder.getConnection();
        connection.setAutoCommit(false);
        try (Statement statement = connection.createStatement()) {
            statement.execute(SQLConstants.DELETE_ALL_PRODUCTS);
            statement.execute(SQLConstants.RESET_AUTO_INCREMENT_FOR_PRODUCTS_TABLE);
            connection.commit();
        } catch (SQLException e) {
            connection.rollback();
            e.printStackTrace();
        } finally {
            connection.close();
        }
    }

    public void updateOrderQuantity(int orderId, int productId, int quantity) throws SQLException {
        Connection connection = null;
        try {
            connection = ConnectionPoolHolder.getConnection();
            connection.setAutoCommit(false);
            PreparedStatement preparedStatement = connection.prepareStatement(SQLConstants.UPDATE_ORDER_ENTRY_QUANTITY);
            preparedStatement.setInt(1, quantity);
            preparedStatement.setInt(2, orderId);
            preparedStatement.setInt(3, productId);
            preparedStatement = connection.prepareStatement(SQLConstants.UPDATE_ORDER_ENTRY_STATUS);
            preparedStatement.setInt(1, orderId);
            preparedStatement.executeUpdate();
            connection.commit();
        } catch (SQLException e) {
            if (connection != null)
                connection.rollback();
            e.printStackTrace();
        } finally {
            if (connection != null)
                connection.close();
        }
    }

    private Product mapProduct(ResultSet resultSet) throws SQLException {
        Product product = new Product();
        product.setId(resultSet.getInt(1));
        product.setName(resultSet.getString(2));
        product.setPrice(resultSet.getInt(3));
        product.setStatus(ProductsStatus.fromString(resultSet.getString(4)));
        product.setCreatedAt(resultSet.getTimestamp(5));
        return product;
    }
}
