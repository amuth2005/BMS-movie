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
import java.util.ArrayList;
import java.util.List;

@WebServlet("/InitiatePayment")
public class InitiatePayment extends HttpServlet {
    private static final String CLIENT_ID = "AXrselUdLz8Xa_GMghQQfwFGkS9Rn__xUtjBkcioSjqiZmB3VAdGR2-Jd32cSz7kShPJhCmtmlUM5tiY";
    private static final String CLIENT_SECRET = "EASKX78Ef5z4yCuJB-dnkovPr315fuFWbEhV2tY7Gika-LpS17VZpXKbJGo8IY42NonA67-A579WsGCV";
    private static final String MODE = "sandbox";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String totalPrice = request.getParameter("totalPrice");
        
        // Store booking details in session for later use
        HttpSession session = request.getSession();
        session.setAttribute("bookingDetails", request.getParameterMap());

        try {
            APIContext apiContext = new APIContext(CLIENT_ID, CLIENT_SECRET, MODE);
            
            // Create payment object
            Payment payment = createPayment(
                Double.parseDouble(totalPrice),
                "USD",
                "paypal",
                "sale",
                "Movie Ticket Booking",
                request.getRequestURL().toString().replace("InitiatePayment", "process-payment"),
                request.getRequestURL().toString().replace("InitiatePayment", "cancel-payment")
            );
            
            // Create payment
            Payment createdPayment = payment.create(apiContext);
            
            // Get approval link
            String approvalLink = createdPayment.getLinks().stream()
                .filter(link -> link.getRel().equals("approval_url"))
                .findFirst()
                .orElseThrow(() -> new ServletException("No approval URL found"))
                .getHref();
            
            // Redirect to PayPal
            response.sendRedirect(approvalLink);
            
        } catch (PayPalRESTException e) {
            throw new ServletException(e);
        }
    }

    private Payment createPayment(
            double total, 
            String currency, 
            String method,
            String intent,
            String description,
            String successUrl,
            String cancelUrl) throws PayPalRESTException {

        Amount amount = new Amount();
        amount.setCurrency(currency);
        amount.setTotal(String.format("%.2f", total));

        Transaction transaction = new Transaction();
        transaction.setDescription(description);
        transaction.setAmount(amount);

        List<Transaction> transactions = new ArrayList<>();
        transactions.add(transaction);

        Payer payer = new Payer();
        payer.setPaymentMethod(method);

        Payment payment = new Payment();
        payment.setIntent(intent);
        payment.setPayer(payer);
        payment.setTransactions(transactions);

        RedirectUrls redirectUrls = new RedirectUrls();
        redirectUrls.setReturnUrl(successUrl);
        redirectUrls.setCancelUrl(cancelUrl);
        payment.setRedirectUrls(redirectUrls);

        return payment;
    }
} 