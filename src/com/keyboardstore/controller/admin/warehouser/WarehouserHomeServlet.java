package com.keyboardstore.controller.admin.warehouser;

import com.keyboardstore.dao.ImportDAO;
import com.keyboardstore.entity.Import;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/warehouser/")
public class WarehouserHomeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    public WarehouserHomeServlet() {super();}

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ImportDAO importDAO = new ImportDAO();
        List<Import> listMostRecentImport = importDAO.listMostRecentImports();
        request.setAttribute("listMostRecentImport", listMostRecentImport);

        String homepage = "index.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(homepage);
        dispatcher.forward(request, response);
    }
}
