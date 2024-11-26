package com.keyboardstore.controller.frontend.customer;

import com.keyboardstore.controller.BaseServlet;
import com.keyboardstore.service.CustomerService;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

@WebServlet("/login")
public class CustomerLoginServlet extends BaseServlet {
	private static final long serialVersionUID = 1L;

    public CustomerLoginServlet() {
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		CustomerService  customerService = new CustomerService(response, request);
		customerService.showLogin();
	}

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CustomerService customerService = new CustomerService(response, request);
        String captchaResponse = request.getParameter("h-captcha-response");
        
        if(verifyHCaptcha(captchaResponse)) {
            customerService.doLogin();
        } else {
            request.setAttribute("message", "Captcha verification failed");
            customerService.showLogin();
        }
    }


    private boolean verifyHCaptcha(String response) {
        String secret = "ES_6fdd59c2a56849d1b371c58d9d854ef6"; // Replace with your hCaptcha secret key
        try {
            URL url = new URL("https://hcaptcha.com/siteverify");
            HttpURLConnection con = (HttpURLConnection) url.openConnection();
            con.setRequestMethod("POST");
            con.setDoOutput(true);

            String data = "secret=" + URLEncoder.encode(secret, "UTF-8") + "&response=" + URLEncoder.encode(response, "UTF-8");

            OutputStream outStream = con.getOutputStream();
            outStream.write(data.getBytes());
            outStream.flush();
            outStream.close();

            InputStream inStream = con.getInputStream();
            InputStreamReader reader = new InputStreamReader(inStream);
            BufferedReader br = new BufferedReader(reader);

            StringBuilder responseBuilder = new StringBuilder();
            String line;
            while ((line = br.readLine()) != null) {
                responseBuilder.append(line);
            }

            br.close();
            
            // Assuming you have a method to parse JSON
            JSONObject json = new JSONObject(responseBuilder.toString());
            return json.getBoolean("success");
            
        } catch(Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}