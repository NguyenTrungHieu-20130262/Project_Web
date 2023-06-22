package Utils;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;

import javax.mail.internet.MimeMessage;
import java.util.Properties;

public class SendEmail {
    private static SendEmail sendEmail;
    private JavaMailSenderImpl mailSender;
    private SendEmail(){
         mailSender = new JavaMailSenderImpl();
        mailSender.setHost("smtp.gmail.com");
        mailSender.setPort(587);
        mailSender.setDefaultEncoding("utf-8");
        mailSender.setUsername("nguyenhauxmvt@gmail.com");
        mailSender.setPassword("zadhllwgaiyurjyn");
        Properties props = mailSender.getJavaMailProperties();
        props.setProperty("mail.mime.charset", "utf-8");
        props.put("mail.transport.protocol", "smtp");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.debug", "true");
        props.put("session.setDebug", "true");
    }
    public static SendEmail getInstance(){
        if(sendEmail == null)
            return new SendEmail();
        return sendEmail;
    }
    public void sendTokenVerify(String email,String linkVerify){
        try {
            MimeMessage mimeMessage = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, false, "utf-8");
            mimeMessage.setSubject("Verify Account");
            mimeMessage.setContent("<p>Nhấn vào đường dẫn bên dươi để hoàn thành đăng ký: </p> </br> <b>Đường dẫn chỉ có tác dụng trong "+JWT.TIMEOUT+" phút</b> </br> <a href = \""+linkVerify+"\">"+linkVerify+"</a> ", "text/html; charset=utf-8");

            helper.setFrom("nguyenhauxmvt@gmail.com");
            helper.setTo(email);

            mailSender.send(mimeMessage);

        } catch (Exception e) {
        }
    }
    public void sendTokenVerifyForgot(String email,String linkVerify){
        try {
            MimeMessage mimeMessage = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, false, "utf-8");
            mimeMessage.setSubject("Verify Forgot Password Account");
            mimeMessage.setContent("<p>Nhấn vào đường dẫn bên dươi để hoàn thành đăng ký: </p> </br> <b>Đường dẫn chỉ có tác dụng trong "+JWT.TIMEOUT+" phút</b> </br> <a href = \""+linkVerify+"\">"+linkVerify+"</a> ", "text/html; charset=utf-8");

            helper.setFrom("nguyenhauxmvt@gmail.com");
            helper.setTo(email);

            mailSender.send(mimeMessage);

        } catch (Exception e) {
        }
    }
    public void sendText(String toEmail,String title,String text) {

        try {
            MimeMessage mimeMessage = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, false, "utf-8");
            mimeMessage.setSubject(title);
            mimeMessage.setContent(text, "text/html; charset=utf-8");

            helper.setFrom("nguyenhauxmvt@gmail.com");
            helper.setTo(toEmail);

            mailSender.send(mimeMessage);

        } catch (Exception e) {
        }
    }


    public static void main(String[] args) {
        SendEmail.getInstance().sendTokenVerify("ngohuyk80169@gmail.com","http://google.com");
    }
} 
