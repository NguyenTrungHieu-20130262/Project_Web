package Model;

import com.google.gson.Gson;

public class RespJsonServlet {
    private String message;
    private Object object;
    public RespJsonServlet(String message,Object object) {
        this.message = message;
        this.object=object;
    }
    public RespJsonServlet(String message) {
        this.message = message;
    }
    public String json(){
        Gson gson=new Gson();
        return gson.toJson(this);
    }
    public String toJsonObject(){
        Gson gson=new Gson();
        return gson.toJson(object);
    }

}
