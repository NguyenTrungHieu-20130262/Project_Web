package DAO;



import org.apache.commons.io.IOUtils;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class TransportAPI {
    private final String email = "ngohuyk80169@gmail.com";
    private final String pass = "02022002";
    private final int provinceFrom = 200;
    private  static int idDistric = 3695;
    private  static int idWard = 90768;
    private static String token = "";
    private static long timout = 1;
    private static TransportAPI transportAPI;
    private TransportAPI(){
        Date date = new Date();
        String rs =login();
        String[] splitRs = rs.split(",");
        this.token = splitRs[0].split(":")[1];
        this.token = this.token.substring(1, this.token.length() - 1);
        this.timout = date.getTime() + (600 * 1000);
    }

    public static TransportAPI getInstance(){
        Date date = new Date();

        if(token == "" || date.getTime() > timout || transportAPI == null){
            transportAPI = new TransportAPI();
        }
        return transportAPI;

    }
    private String login() {
        try {
        CloseableHttpClient client = HttpClients.createDefault();
        HttpPost httpPost = new HttpPost("http://140.238.54.136/api/auth/login");
        List<NameValuePair> params = new ArrayList<NameValuePair>();
        params.add(new BasicNameValuePair("email", "ngohuyk80169@gmail.com"));
        params.add(new BasicNameValuePair("password", "02022002"));
        httpPost.setEntity(new UrlEncodedFormEntity(params));
        HttpResponse httpResponse = client.execute(httpPost);


            String content = IOUtils.toString(httpResponse.getEntity().getContent(), "UTF-8");
            System.out.println(content);
            return content;

        } catch (IOException e) {
            throw new RuntimeException(e);


        }
    }
    public String getProvince(){
        try {
            CloseableHttpClient client = HttpClients.createDefault();
            HttpGet httpPost = new HttpGet("http://140.238.54.136/api/province");
            System.out.println(token + "Tokeennnn");
            httpPost.setHeader("Authorization", "Bearer "+token);
            HttpResponse httpResponse = client.execute(httpPost);

            System.out.println("Protocol: " + httpResponse.getProtocolVersion());
            System.out.println("Status:" + httpResponse.getStatusLine().toString());
            System.out.println("Content type:" + httpResponse.getEntity().getContentType());
            System.out.println("Locale:" + httpResponse.getLocale());
            System.out.println("Content:");

            String content = IOUtils.toString(httpResponse.getEntity().getContent(), "UTF-8");
            return content;

        } catch (IOException e) {
            throw new RuntimeException(e);


        }
    }
    public String getDistrict(int idProvince){
        try {
            CloseableHttpClient client = HttpClients.createDefault();
            HttpGet httpPost = new HttpGet("http://140.238.54.136/api/district?provinceID="+idProvince);
            System.out.println(token + "Tokeennnn");
            httpPost.setHeader("Authorization", "Bearer "+token);
            HttpResponse httpResponse = client.execute(httpPost);

            System.out.println("Protocol: " + httpResponse.getProtocolVersion());
            System.out.println("Status:" + httpResponse.getStatusLine().toString());
            System.out.println("Content type:" + httpResponse.getEntity().getContentType());
            System.out.println("Locale:" + httpResponse.getLocale());
            System.out.println("Content:");
            String content = IOUtils.toString(httpResponse.getEntity().getContent(), "UTF-8");
            return content;
        } catch (IOException e) {
            throw new RuntimeException(e);


        }
    }
    public String getWard(int idDistrict){
        try {
            CloseableHttpClient client = HttpClients.createDefault();
            HttpGet httpPost = new HttpGet("http://140.238.54.136/api/ward?districtID="+idDistrict);
            System.out.println(token + "Tokeennnn");
            httpPost.setHeader("Authorization", "Bearer "+token);
            HttpResponse httpResponse = client.execute(httpPost);

            System.out.println("Protocol: " + httpResponse.getProtocolVersion());
            System.out.println("Status:" + httpResponse.getStatusLine().toString());
            System.out.println("Content type:" + httpResponse.getEntity().getContentType());
            System.out.println("Locale:" + httpResponse.getLocale());
            System.out.println("Content:");

            String content = IOUtils.toString(httpResponse.getEntity().getContent(), "UTF-8");
            return content;

        } catch (IOException e) {
            throw new RuntimeException(e);


        }
    }
    public static Integer calculateFee (int to_district, int to_ward, int height, int length, int width , int weight ){
        height = Integer.valueOf((int) (height *0.1));
        length = Integer.valueOf((int) (length *0.1));
        width = Integer.valueOf((int) (width *0.1));
        weight = Integer.valueOf((int) (weight *100 ));
    try {
        CloseableHttpClient client = HttpClients.createDefault();
        HttpPost httpPost = new HttpPost("http://140.238.54.136/api/calculateFee");
        httpPost.setHeader("Authorization", "Bearer "+token);
        List<NameValuePair> params = new ArrayList<NameValuePair>();
        params.add(new BasicNameValuePair("from_district_id", idDistric+""));
        params.add(new BasicNameValuePair("from_ward_id", idWard + ""));
        params.add(new BasicNameValuePair("to_district_id", to_district +""));
        params.add(new BasicNameValuePair("to_ward_id", to_ward +""));
        params.add(new BasicNameValuePair("height", shrinkData(height) +""));
        params.add(new BasicNameValuePair("length", shrinkData(length) +""));
        params.add(new BasicNameValuePair("width", shrinkData(width) +""));
        params.add(new BasicNameValuePair("weight", shrinkData(weight, 1600000) +""));
        httpPost.setEntity(new UrlEncodedFormEntity(params));
        HttpResponse httpResponse = client.execute(httpPost);
        String content = IOUtils.toString(httpResponse.getEntity().getContent(), "UTF-8");
        if(content.contains("400")){
            return 0;
        }
        content = content.split("service_fee\":")[1].split("}]}")[0];
        System.out.println(content+" "+height+" "+ length+" "+width +" "+ weight);
        return Integer.valueOf((int) Integer.valueOf(content)/2350);

    } catch (IOException e) {
        throw new RuntimeException(e);


    }
    }
    public static int shrinkData(int data){
        data = Integer.valueOf((int) (data *0.06));
        if(data > 200) return  200;
        return data;
    }
    public static int shrinkData(int data, int max){
        data = Integer.valueOf((int) (data *0.06));
        if(data > max) return max;
        return data;
    }
    private int getProvinceId(String province){
        String all = TransportAPI.getInstance().getProvince();

        String[] arrProvinceId = all.split(",");
        for (int i = 0; i < arrProvinceId.length; i++) {
            String tmp = arrProvinceId[i];
            if(tmp.contains(province))
                return Integer.valueOf(arrProvinceId[i-1].split("D\":")[1]);
        }
        return -1;
    }
    private int getDistricId(int province,String distric){
        String all = TransportAPI.getInstance().getDistrict(province);

        String[] arr = all.split(",");
        for (int i = 0; i < arr.length; i++) {
            String tmp = arr[i];
            if(tmp.contains(distric))
                return Integer.valueOf(arr[i-1].split(":")[1]);
        }
        return -1;
    }
    private int getWardId(int distric,String ward){
        String all = TransportAPI.getInstance().getWard(distric);
        System.out.println(all);

        String[] arr = all.split(",");
        for (int i = 0; i < arr.length; i++) {
            String tmp = arr[i];

            if(tmp.contains(ward))
                return Integer.valueOf(arr[i-2].split("WardCode\":")[1].replaceAll("\"",""));
        }
        return -1;
    }
    public int[] getIdAddress(String address){
        String[] arrAddress = address.split("-");
        String province = arrAddress[2].trim();
        String district = arrAddress[1].trim();
        String ward = arrAddress[0].trim();
        int idProvince = TransportAPI.getInstance().getProvinceId(province);
        int idDistrict = TransportAPI.getInstance().getDistricId(idProvince,district);
        int idWard = TransportAPI.getInstance().getWardId(idDistrict, ward);
        return new int[]{idProvince,idDistrict,idWard};
    }
    public String registerTransport(int to_district, int to_ward, int height, int length, int width , int weight ){
        height = Integer.valueOf((int) (height *0.1));
        length = Integer.valueOf((int) (length *0.1));
        width = Integer.valueOf((int) (width *0.1));
        weight = Integer.valueOf((int) (weight *100 ));
        try {
            CloseableHttpClient client = HttpClients.createDefault();
            HttpPost httpPost = new HttpPost("http://140.238.54.136/api/registerTransport");
            httpPost.setHeader("Authorization", "Bearer "+token);
            List<NameValuePair> params = new ArrayList<NameValuePair>();
            params.add(new BasicNameValuePair("from_district_id", idDistric+""));
            params.add(new BasicNameValuePair("from_ward_id", idWard + ""));
            params.add(new BasicNameValuePair("to_district_id", to_district +""));
            params.add(new BasicNameValuePair("to_ward_id", to_ward +""));
            params.add(new BasicNameValuePair("height", shrinkData(height) +""));
            params.add(new BasicNameValuePair("length", shrinkData(length) +""));
            params.add(new BasicNameValuePair("width", shrinkData(width) +""));
            params.add(new BasicNameValuePair("weight", shrinkData(weight, 1600000) +""));
            httpPost.setEntity(new UrlEncodedFormEntity(params));
            HttpResponse httpResponse = client.execute(httpPost);
            String content = IOUtils.toString(httpResponse.getEntity().getContent(), "UTF-8");
            System.out.println(content+" "+height+" "+ length+" "+width +" "+ weight);
            return content;

        } catch (IOException e) {
            throw new RuntimeException(e);


        }
    }
    public static long convertMoney(String money, boolean usdToVND){
        if(usdToVND == true){
            return Long.valueOf(money) *23500 * 100;
        }else{
            String strMoney = money + "";
            strMoney = strMoney.substring(0,strMoney.length()-3);
            return Integer.valueOf(TransportAPI.convertToUSD(Double.valueOf(strMoney)));
        }
    }
    public static int convertToUSD(double money){
        return Integer.valueOf((int) money/2350);
    }
    public static void main(String[] args) throws JSONException {
//        // -2 = "2323"
//        int money =TransportAPI.getInstance().calculateFee(2270, 231013, 1630,4140,1120,1044);
//        System.out.println( money);
//        String all = TransportAPI.getInstance().getProvince();
//        String[] arrProvinceId = all.split(",");
//        for (int i = 0; i < arrProvinceId.length; i++) {
//            String tmp = arrProvinceId[i];
//            if(tmp.contains("Lào Cai"))
//                System.out.println();
//        }
//
        String data =TransportAPI.getInstance().registerTransport(2270, 231013, 1630,4140,1120,1044);
        System.out.println(data);
//        JSONObject object = new JSONObject(data);
//        System.out.println(object.getJSONObject("Transport").getLong("leadTime"));

    }
}
