/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.mail.*;
import javax.mail.internet.*;
import java.util.Properties;

/**
 *
 * @author ASUS
 */
public class Booking extends HttpServlet {

    @Override
    public void init() throws ServletException {
        super.init();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new ServletException("MySQL JDBC Driver not found.", e);
        }
    }

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet MovieBookingServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet MovieBookingServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String date = request.getParameter("date");
        String movie = request.getParameter("movie");
        String time = request.getParameter("time");
        String cinema = request.getParameter("cinema");
        String seats = request.getParameter("seats");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");

        if (date == null || movie == null || time == null || cinema == null || name == null || email == null || phone == null) {
            System.out.println("Error: Missing required parameters");
            System.out.println("date=" + date);
            System.out.println("movie=" + movie);
            System.out.println("time=" + time);
            System.out.println("cinema=" + cinema);
            System.out.println("name=" + name);
            System.out.println("email=" + email);
            System.out.println("phone=" + phone);
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            out.println("<h1>Error: Missing required booking information</h1>");
            out.println("<a href='booking.jsp'>Go back to booking</a>");
            return;
        }

        String dbURL = "jdbc:mysql://localhost:3306/bms_db";
        String dbUser = "root";
        String dbPass = "root";  

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        try {
            try (Connection testConn = DriverManager.getConnection(dbURL, dbUser, dbPass)) {
                System.out.println("Database connection successful");
            }

            try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPass);
                 PreparedStatement ps = connection.prepareStatement("INSERT INTO bookings (date, movie, time, cinema, seats, name, email, phone) VALUES (?, ?, ?, ?, ?, ?, ?, ?)")) {

                ps.setString(1, date);
                ps.setString(2, movie);
                ps.setString(3, time);
                ps.setString(4, cinema);
                ps.setString(5, seats != null ? seats : "");
                ps.setString(6, name);
                ps.setString(7, email);
                ps.setString(8, phone);

                System.out.println("Executing SQL with values:");
                System.out.println("date=" + date);
                System.out.println("movie=" + movie);
                System.out.println("time=" + time);
                System.out.println("cinema=" + cinema);
                System.out.println("seats=" + seats);
                System.out.println("name=" + name);
                System.out.println("email=" + email);
                System.out.println("phone=" + phone);

                int result = ps.executeUpdate();
                if (result > 0) {
                    sendBookingEmail(email, date, movie, time, cinema, seats, name);

                    request.getRequestDispatcher("thankpage.jsp").forward(request, response);
                    return;
                } else {
                    out.println("<h1>Error in booking.</h1>");
                }
            } catch (SQLException e) {
                e.printStackTrace();
                out.println("<h1>Database error: " + e.getMessage() + "</h1>");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("<h1>Database error: " + e.getMessage() + "</h1>");
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    public String getServletInfo() {
        return "Short description";
    }

    private void sendBookingEmail(String to, String date, String movie, String time, String cinema, String seats, String name) {
        Properties properties = new Properties();
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.host", "smtp.gmail.com"); 
        properties.put("mail.smtp.port", "587"); 

        Session session = Session.getInstance(properties, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication("bookmyshow476@gmail.com", "zloplwavjredmbtb"); 
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress("bookmyshow476@gmail.com")); 
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject("Booking Confirmation");
            
            String content = "Dear " + name + ",\n\n" +
                             "Thank you for your booking!\n" +
                             "Here are your booking details:\n" +
                             "Date: " + date + "\n" +
                             "Movie: " + movie + "\n" +
                             "Time: " + time + "\n" +
                             "Cinema: " + cinema + "\n" +
                             "Seats: " + seats + "\n\n" +
                             "Thank you for choosing us!\n" +
                             "Best regards,\n" +
                             "Book My Show";
            
            message.setText(content);

            Transport.send(message);
            System.out.println("Booking confirmation email sent successfully.");

        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }

}

