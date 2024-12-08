package com.keyboardstore.controller.admin.warehouser.imports;

import com.keyboardstore.service.ImportService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/warehouser/show_stock")
public class ShowStockServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    public ShowStockServlet() {super();}

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ImportService importService = new ImportService(request, response);
        importService.showStock();
    }
}
