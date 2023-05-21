package DTO;

import Model.Oder;
import Model.Payment;

import java.sql.Date;

public class Orders extends Oder {
   private Payment payment;

    public Orders(long id, int idUser, String address, String idTransport, Date createAt, String note, int status, double total_price, Date leadTime) {
        super(id, idUser, address, idTransport, createAt, note, status, total_price, leadTime);
    }

    public Orders(Payment payment) {
        this.payment = payment;
    }

    public Payment getPayment() {
        return payment;
    }

    public void setPayment(Payment payment) {
        this.payment = payment;
    }
}
