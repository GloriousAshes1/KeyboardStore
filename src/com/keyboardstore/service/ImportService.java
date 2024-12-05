package com.keyboardstore.service;

import com.keyboardstore.dao.ImportDAO;
import com.keyboardstore.entity.Import;
import com.keyboardstore.entity.Users;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class ImportService {

    private ImportDAO importDAO;
    private HttpServletRequest request;
    private HttpServletResponse response;

    public ImportService(HttpServletRequest request, HttpServletResponse response) {
        this.request = request;
        this.response = response;
        this.importDAO = new ImportDAO();
    }

    // List all imports
    public void listAllImports() throws ServletException, IOException {
        listAllImports(null);
    }

    public void listAllImports(String message) throws ServletException, IOException {
        List<Import> listImports = importDAO.listAll();

        request.setAttribute("listImports", listImports);

        if (message != null) {
            request.setAttribute("message", message);
        }

        String listPage = "import_list.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(listPage);
        dispatcher.forward(request, response);
    }

    // View details of a specific import
    public void viewImportDetail() throws ServletException, IOException {
        Integer importId = Integer.parseInt(request.getParameter("id"));

        Import imp = importDAO.get(importId);
        request.setAttribute("import", imp);

        String detailPage = "import_detail.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(detailPage);
        dispatcher.forward(request, response);
    }

    // Show form to add new import
    public void showAddImportForm() throws ServletException, IOException {
        String addPage = "frontend/import_form.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(addPage);
        dispatcher.forward(request, response);
    }

    // Add a new import
    public void addImport() throws ServletException, IOException {
        Import imp = readImportInfo();
        Users user = (Users) request.getSession().getAttribute("user"); // Assuming user is in session
        imp.setUser(user);

        importDAO.create(imp);

        String message = "New import has been added successfully!";
        listAllImports(message);
    }

    // Show form to edit import details
    public void showEditImportForm() throws ServletException, IOException {
        Integer importId = Integer.parseInt(request.getParameter("id"));
        Import imp = importDAO.get(importId);

        request.setAttribute("import", imp);
        String editPage = "frontend/import_form.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(editPage);
        dispatcher.forward(request, response);
    }

    // Update the import details
    public void updateImport() throws ServletException, IOException {
        Integer importId = Integer.parseInt(request.getParameter("id"));
        Import imp = importDAO.get(importId);

        // Update import details
        imp.setSumPrice(Float.parseFloat(request.getParameter("sumPrice")));
        importDAO.update(imp);

        String message = "Import details updated successfully!";
        listAllImports(message);
    }

    // Delete an import
    public void deleteImport() throws ServletException, IOException {
        Integer importId = Integer.parseInt(request.getParameter("id"));
        importDAO.delete(importId);

        String message = "Import ID " + importId + " has been deleted.";
        listAllImports(message);
    }

    // Helper method to read import information from request
    private Import readImportInfo() {
        float sumPrice = Float.parseFloat(request.getParameter("sumPrice"));

        Import imp = new Import();
        imp.setSumPrice(sumPrice);
        imp.setImportDate(new java.util.Date());  // Assuming import date is current time

        return imp;
    }

    // Calculate total imports sum
    public void totalImports() throws ServletException, IOException {
        Double total = importDAO.totalImports();
        request.setAttribute("totalImports", total);

        String totalPage = "frontend/total_imports.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(totalPage);
        dispatcher.forward(request, response);
    }

    public void createImport() {
    }
}
