import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.paypal.api.payments.*;
import com.paypal.base.rest.APIContext;
import com.paypal.base.rest.PayPalRESTException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Map;
import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;

@WebServlet("/process-payment")
public class ProcessPayment extends HttpServlet {
    private static final String CLIENT_ID = "AXrselUdLz8Xa_GMghQQfwFGkS9Rn__xUtjBkcioSjqiZmB3VAdGR2-Jd32cSz7kShPJhCmtmlUM5tiY";
    private static final String CLIENT_SECRET = "EASKX78Ef5z4yCuJB-dnkovPr315fuFWbEhV2tY7Gika-LpS17VZpXKbJGo8IY42NonA67-A579WsGCV";
    private static final String MODE = "sandbox";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String paymentId = request.getParameter("paymentId");
        String payerId = request.getParameter("PayerID");
        
        try {
            APIContext apiContext = new APIContext(CLIENT_ID, CLIENT_SECRET, MODE);
            
            Payment payment = new Payment();
            payment.setId(paymentId);

            PaymentExecution paymentExecution = new PaymentExecution();
            paymentExecution.setPayerId(payerId);

            Payment executedPayment = payment.execute(apiContext, paymentExecution);

            if (executedPayment.getState().equals("approved")) {
                HttpSession session = request.getSession();
                Map<String, String[]> bookingDetails = (Map<String, String[]>) session.getAttribute("bookingDetails");
                
                // Extract booking details
                String name = bookingDetails.get("name")[0];
                String email = bookingDetails.get("email")[0];
                String phone = bookingDetails.get("phone")[0];
                String date = bookingDetails.get("date")[0];
                String movie = bookingDetails.get("movie")[0];
                String time = bookingDetails.get("time")[0];
                String cinema = bookingDetails.get("cinema")[0];
                String seats = bookingDetails.get("seats")[0];
                String totalPrice = bookingDetails.get("totalPrice")[0];
                
                // Save to database
                saveBooking(name, email, phone, date, movie, time, cinema, seats, totalPrice, paymentId);
                
                // Send confirmation email
                sendBookingEmail(email, date, movie, time, cinema, seats, name, totalPrice);
                
                response.sendRedirect("thankpage.jsp");
            } else {
                response.sendRedirect("error.jsp");
            }

        } catch (PayPalRESTException e) {
            response.sendRedirect("error.jsp");
        }
    }

    private void saveBooking(String name, String email, String phone, String date, 
            String movie, String time, String cinema, String seats, String totalPrice, 
            String paymentId) throws ServletException {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/bms_db", "codebind", "amuthupunya123")) {
                
                String sql = "INSERT INTO bookings (name, email, phone, date, movie, time, "
                        + "cinema, seats, total_price, payment_id, booking_date) "
                        + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())";
                
                try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                    pstmt.setString(1, name);
                    pstmt.setString(2, email);
                    pstmt.setString(3, phone);
                    pstmt.setString(4, date);
                    pstmt.setString(5, movie);
                    pstmt.setString(6, time);
                    pstmt.setString(7, cinema);
                    pstmt.setString(8, seats);
                    pstmt.setString(9, totalPrice);
                    pstmt.setString(10, paymentId);
                    
                    pstmt.executeUpdate();
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            throw new ServletException("Database error: " + e.getMessage());
        }
    }

    private void sendBookingEmail(String to, String date, String movie, String time, 
            String cinema, String seats, String name, String totalPrice) {
        Properties properties = new Properties();
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.port", "587");

        Session session = Session.getInstance(properties, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication("bookmyshow476@gmail.com", "zloplwavjredmbtb");
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress("bookmyshow476@gmail.com"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject("Booking Confirmation - Book My Show");

            String emailContent = String.format("""
                Dear %s,
                
                Thank you for your booking! Here are your booking details:
                
                Movie: %s
                Date: %s
                Time: %s
                Cinema: %s
                Seats: %s
                Total Paid: $%s
                
                Please arrive 15 minutes before showtime.
                
                Enjoy your movie!
                
                Best regards,
                Book My Show Team
                """, name, movie, date, time, cinema, seats, totalPrice);

            message.setText(emailContent);
            Transport.send(message);

        } catch (MessagingException e) {
            e.printStackTrace();
            // Don't throw exception - email sending should not block the booking process
        }
    }
} 