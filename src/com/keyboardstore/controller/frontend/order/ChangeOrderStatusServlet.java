package com.keyboardstore.controller.frontend.order;

import com.keyboardstore.service.OrderServices;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/change_order_status")
public class ChangeOrderStatusServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ChangeOrderStatusServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String status = request.getParameter("status");  // Lấy trạng thái từ form JSP
        String message = "Order status has been updated successfully."; // Tin nhắn thông báo
        String path = "order_list.jsp"; // Trang đích sau khi xử lý

        try {
            OrderServices orderServices = new OrderServices(request, response);
            orderServices.changeOrderStatus(status, path, message); // Gọi dịch vụ
        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("error", "Error occurred while updating order status.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}
