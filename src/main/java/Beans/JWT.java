package Beans;


import Model.User;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.Date;
import java.util.StringTokenizer;
import java.util.regex.Pattern;

public class JWT {
    public static final  int TIMEOUT = 6;
    private static final String JWT_SECRET = "Nguyen_Ngoc_Huy";

    private JWT(){

    }

    public static String createJWT(String subject){
       return Jwts.builder()
                .setSubject(subject)
                .setExpiration(new Date(new Date().getTime() + 1000 * 60 * TIMEOUT))
                .signWith(SignatureAlgorithm.HS256, JWT_SECRET)
                .compact();
    }
    public static String getBodyJWT(String token){
        return Jwts.parser()
                .setSigningKey(JWT_SECRET)
                .parseClaimsJws(token)
                .getBody()
                .getSubject();
    }

    public static void main(String[] args) {


    }
}
