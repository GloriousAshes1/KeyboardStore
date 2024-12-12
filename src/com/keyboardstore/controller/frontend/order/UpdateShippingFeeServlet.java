package com.keyboardstore.controller.frontend.order;

import com.keyboardstore.entity.Customer;
import com.keyboardstore.service.CommonUtility;
import com.keyboardstore.util.NominatimAPI;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/update_shipping_fee")
public class UpdateShippingFeeServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        // Get form input values
        String firstName = request.getParameter("firstname");
        String lastName = request.getParameter("lastname");
        String phone = request.getParameter("phone");
        String address1 = request.getParameter("address1");
        String address2 = request.getParameter("address2");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String zipCode = request.getParameter("zipcode");
        String country = request.getParameter("country");

        // Update customer info
        Customer customer = (Customer) session.getAttribute("loggedCustomer");
        customer.setFirstname(firstName);
        customer.setLastname(lastName);
        customer.setPhone(phone);
        customer.setAddressLine1(address1);
        customer.setAddressLine2(address2);
        customer.setZipcode(zipCode);
        customer.setCity(city);
        customer.setState(state);
        customer.setCountry(country);

        // Calculate shipping fee based on address
        String customerAddress = address1 + ", " + city + ", " + state + ", " + zipCode + ", " + country;
        String origin = "Nam Kỳ Khởi Nghĩa, Vo Thi Sau Ward, District 3, Ho Chi Minh City, 70150, Vietnam";

        NominatimAPI api = new NominatimAPI();
        float distance = (float) api.calculateDistance(origin, customerAddress);
        float shippingFee = distance * 0.1f; // Calculate shipping fee

        // Set attributes
        request.setAttribute("shippingFee", shippingFee);
        request.setAttribute("loggedCustomer", customer);

        // Generate the country list for the JSP page
        CommonUtility.generateCountryList(request);

        // Forward to the checkout page
        RequestDispatcher dispatcher = request.getRequestDispatcher("frontend/checkout.jsp");
        dispatcher.forward(request, response);
    }
}