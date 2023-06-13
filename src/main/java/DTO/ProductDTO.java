package DTO;

import Model.Company;
import Model.Product;

import java.sql.Date;
import java.util.ArrayList;

public class ProductDTO extends Product {
    private int quantity;

    public ProductDTO(int id, Company vendo, String name, String content, String body, int yearOfManuFacture, String fuel, double price, Date createAt, int status, ArrayList<String> images) {
        super(id, vendo, name, content, body, yearOfManuFacture, fuel, price, createAt, status, images);

    }
    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
}
