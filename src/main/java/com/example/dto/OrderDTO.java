package com.example.dto;

public class OrderDTO {
    private int orderId;
    private int productsTotalPrice;
    private String productName;
    private int productsQuantity;
    private String orderCreatedAt;

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getProductsTotalPrice() {
        return productsTotalPrice;
    }

    public void setProductsTotalPrice(int productsTotalPrice) {
        this.productsTotalPrice = productsTotalPrice;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public int getProductsQuantity() {
        return productsQuantity;
    }

    public void setProductsQuantity(int productsQuantity) {
        this.productsQuantity = productsQuantity;
    }

    public String getOrderCreatedAt() {
        return orderCreatedAt;
    }

    public void setOrderCreatedAt(String orderCreatedAt) {
        this.orderCreatedAt = orderCreatedAt;
    }
}
