package com.keyboardstore.controller.frontend.order;

import com.keyboardstore.entity.Customer;
import com.keyboardstore.util.NominatimAPI;

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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, IOException {
        HttpSession session = request.getSession();
        String firstName = request.getParameter("firstname");
        String lastName = request.getParameter("lastname");
        String phone = request.getParameter("phone");
        String address1 = request.getParameter("address1");
        String address2 = request.getParameter("address2");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String zipCode = request.getParameter("zipcode");
        String country = request.getParameter("country");
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

        String customerAddress = request.getParameter("address"); // Lấy địa chỉ từ form
        String origin = "Nam Kỳ Khởi Nghĩa, Vo Thi Sau Ward, District 3, Ho Chi Minh City, 70150, Vietnam";

        NominatimAPI api = new NominatimAPI();
        float distance = (float) api.calculateDistance(origin, customerAddress);

        float shippingFee = distance * 0.1f; // Tính phí vận chuyển

        request.setAttribute("shippingFee", shippingFee);
        request.setAttribute("loggedCustomer", customer);
        request.getRequestDispatcher("/checkout.jsp"); // Chuyển về trang checkout.jsp
    }
}

