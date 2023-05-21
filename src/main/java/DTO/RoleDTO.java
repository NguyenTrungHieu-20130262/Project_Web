package DTO;

import java.util.ArrayList;

public class RoleDTO {
    private int id;
    private String name;
    private ArrayList<Permission> arrPermission ;
    private int status;

    public RoleDTO(String name, int status) {
        this.name = name;
        this.status = status;
        arrPermission = new ArrayList<>();
    }
    public RoleDTO(int id, String name, int status) {
        this.id = id;
        this.name = name;
        this.status = status;
        arrPermission = new ArrayList<>();
    }

    public RoleDTO(int id, String name, ArrayList<Permission> arrPermission) {
        this.id = id;
        this.name = name;
        this.status = status;
        this.arrPermission = arrPermission;
    }
    public RoleDTO() {
        arrPermission = new ArrayList<>();

    }

    public RoleDTO(int i) {
        this.id = i;
        arrPermission = new ArrayList<>();

    }
    public void addPermission(Permission i){
        this.arrPermission.add(i);
    }
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getStatus() {
        return status;
    }

    public ArrayList<Permission> getArrPermission() {
        return arrPermission;
    }

    public void setArrPermission(ArrayList<Permission> arrPermission) {
        this.arrPermission = arrPermission;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    @Override
    public String toString() {
        String rs =  "Role: " +
                "id=" + id +
                ", name='" + name + '\'' +
                ", status=" + status +
                ", arrPermission="  ;
        for (Permission tmp: arrPermission) {
            rs+= tmp + ",";
        }
        return rs;
    }
}
