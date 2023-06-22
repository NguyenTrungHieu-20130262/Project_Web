package Utils;


import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jws;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;

import java.util.Date;

public class JWT {
    public static final  int TIMEOUT = 6;
    private static final String JWT_SECRET = "Nguyen_Ngoc_Huy";

    private JWT(){

    }

    public static String createJWT(String subject,int time){
       return Jwts.builder()
                .setSubject(subject)
                .setExpiration(new Date(new Date().getTime() + 1000 * 60 * time))
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
    public static Jws<Claims> getBodyJWTLogin(String token){
        return Jwts.parser().setSigningKey(JWT_SECRET).parseClaimsJws(token);
    }
}
