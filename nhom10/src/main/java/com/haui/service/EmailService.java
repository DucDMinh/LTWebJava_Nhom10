package com.haui.service;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import java.text.DecimalFormat;
import java.util.List;

@Service
public class EmailService {

    private final JavaMailSender mailSender;

    @Autowired
    public EmailService(JavaMailSender mailSender) {
        this.mailSender = mailSender;
    }

    public void sendLoginSuccessEmail(String recipientEmail, String userName) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

            helper.setFrom("javawebnhom10@gmail.com", "CellWorld Support");
            helper.setTo(recipientEmail);
            helper.setSubject("Đăng nhập thành công");
            String content = "<div style=\"font-family: Arial, sans-serif; padding: 20px; background: #f5f7fa; border-radius: 10px; max-width: 600px; margin: auto; box-shadow: 0 4px 10px rgba(0,0,0,0.1);\">\n"
                    +
                    "    <h2 style=\"color: #4CAF50;\">Xin chào, <span style=\"color: #333;\">" + userName
                    + "</span> 🎉</h2>\n" +
                    "    <p style=\"font-size: 16px; color: #555;\">\n" +
                    "        Bạn đã <strong>đăng nhập thành công</strong> vào hệ thống của chúng tôi.\n" +
                    "    </p>\n" +
                    "    <p style=\"font-size: 16px; color: #555;\">\n" +
                    "        Chúc bạn có một trải nghiệm tuyệt vời! 🚀\n" +
                    "    </p>\n" +
                    "    <hr style=\"margin: 20px 0;\">\n" +
                    "    <p style=\"font-size: 14px; color: #777;\">\n" +
                    "        👉 Nếu không phải bạn thực hiện hành động này, vui lòng liên hệ ngay với đội ngũ hỗ trợ để được giúp đỡ.\n"
                    +
                    "    </p>\n" +
                    "</div>";

            helper.setText(content, true);

            mailSender.send(message);
            System.out.println("Email đăng nhập thành công đã được gửi đến " + recipientEmail);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
