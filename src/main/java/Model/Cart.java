package Model;

import java.sql.Date;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

public class Cart {
    private int id;
    private int idUser;
    private Product product;
    private int quantity;
    private Date createAt;
    private int status;
    private String messStatus;
    static Map<Integer, String> statusCart = new HashMap<>();

    static {
        statusCart.put(0, "OK");
        statusCart.put(1, "Sản phẩm đã hết");
        statusCart.put(2, "Vượt quá số lượng trong kho");
        statusCart.put(3, "Min");
        statusCart.put(4, "Max");

    }
    public Cart() {
    }

    public Cart(int idUser, Product product, int quantity) {
        this.idUser = idUser;
        this.product = product;
        this.quantity = quantity;
    }

    public Cart(int id, int idUser, Product product, int quantity, Date createAt, int status) throws SQLException {
        this.id = id;
        this.idUser = idUser;
        this.product = product;
        this.createAt = createAt;
        this.quantity = quantity;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setCreateAt(Date createAt) {
        this.createAt = createAt;
    }

    public void setStatus(int status) {
        this.status = status;
        this.messStatus = statusCart.get(status);

    }
    public String getMess(){
        return messStatus;
    }
    public int getId() {
        return id;
    }

    public Date getCreateAt() {
        return createAt;
    }

    public int getStatus() {
        return status;
    }

    public int getIdUser() {
        return idUser;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public double total(){
        return this.getProduct().getPrice() * this.getQuantity();
    }
    public void setIdUser(int idUser) {
        this.idUser = idUser;
    }


//    int idProduct = this.getProduct().getId();
//    int quantityProduct = ProductDAO.getQuantityProduct(idProduct);
//        System.out.println(quantityProduct + "-----" + quantity);
//
//        if (quantityProduct == 0) {
//        this.setStatus(1);
//    } else {
//
//        if (quantityProduct > quantity) {
//            this.quantity = quantity;
//            this.setStatus(0);
//
//        }
//
//        if (quantity > quantityProduct) {
//            this.quantity = quantity;
//            this.setStatus(2);
//        }
//        if (quantity <= 1) {
//            this.quantity = quantity;
//            this.setStatus(3);
//        }
//
//
//
//    }


    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) throws SQLException {

this.quantity = quantity;
    }
    @Override
    public String toString() {
        return idUser + "-" + product + "-" + quantity + "-" + messStatus + "-" + status;
    }
}
