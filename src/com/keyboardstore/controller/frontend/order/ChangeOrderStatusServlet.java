package com.keyboardstore.controller.frontend.order;

import com.keyboardstore.dao.OrderDAO;
import com.keyboardstore.entity.Customer;
import com.keyboardstore.entity.ProductOrder;
import com.keyboardstore.service.OrderServices;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

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

        try {
            OrderServices orderServices = new OrderServices(request, response);
            orderServices.changeOrderStatus(status, "order_list.jsp", message); // Gọi dịch vụ thay đổi trạng thái

//            // Kiểm tra xem response đã bị commit chưa trước khi điều hướng
//            if (!response.isCommitted()) {
//                OrderDAO orderDAO = new OrderDAO();
//                HttpSession session = request.getSession();
//                Customer customer = (Customer) session.getAttribute("loggedCustomer");
//                List<ProductOrder> listOrders = orderDAO.listByCustomer(customer.getCustomerId());
//
//                request.setAttribute("listOrders", listOrders);
//
//                String historyPage = "frontend/order_list.jsp";
//                RequestDispatcher dispatcher = request.getRequestDispatcher(historyPage);
//                dispatcher.forward(request, response);
//            }
        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("error", "Error occurred while updating order status.");
            // Đảm bảo không sử dụng forward() nếu response đã được commit
            if (!response.isCommitted()) {
                request.getRequestDispatcher("error.jsp").forward(request, response);
            }
        }
    }
}
