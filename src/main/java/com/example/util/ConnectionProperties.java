package com.example.util;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class ConnectionProperties {
    private static String url;
    private static String user;
    private static String password;

    public static void getProperties() {
        try (InputStream input = Thread.currentThread().getContextClassLoader().getResourceAsStream("local.properties")) {
            Properties properties = new Properties();
            properties.load(input);
            url = properties.getProperty("connection.url");
            user = properties.getProperty("connection.user");
            password = properties.getProperty("connection.password");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static String getUrl() {
        if (url == null)
            getProperties();
        return url;
    }

    public static String getUser() {
        if (user == null)
            getProperties();
        return user;
    }

    public static String getPassword() {
        if (password == null)
            getProperties();
        return password;
    }
}
