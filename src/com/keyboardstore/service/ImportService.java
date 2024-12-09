package com.keyboardstore.service;

import com.keyboardstore.dao.ImportDAO;
import com.keyboardstore.dao.ProductDAO;
import com.keyboardstore.dao.UserDAO;
import com.keyboardstore.entity.Import;
import com.keyboardstore.entity.ImportDetail;
import com.keyboardstore.entity.Users;
import com.keyboardstore.entity.Product;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class ImportService {

    private ImportDAO importDAO;
    private ProductDAO productDAO;
    private UserDAO userDAO;
    private HttpServletRequest request;
    private HttpServletResponse response;

    public ImportService(HttpServletRequest request, HttpServletResponse response) {
        this.request = request;
        this.response = response;
        this.importDAO = new ImportDAO();
        this.productDAO = new ProductDAO();
        this.userDAO = new UserDAO();
    }

    public void showStock() throws ServletException, IOException {
        List<Product> listProducts = productDAO.listAllSortedByStock();

        request.setAttribute("listProducts", listProducts);

        String stockPage = "show_stock.jsp";  // JSP page to display product stock
        RequestDispatcher dispatcher = request.getRequestDispatcher(stockPage);
        dispatcher.forward(request, response);
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

    // View details of a specific import, including the user who created it and the list of products
    public void viewImportDetail() throws ServletException, IOException {
        Integer importId = Integer.parseInt(request.getParameter("id"));

        Import imp = importDAO.get(importId);

        if (imp == null) {
            String errorMessage = "Could not find the import with ID: " + importId;
            request.setAttribute("message", errorMessage);
            listAllImports();
            return;
        }

        // Get the user and import details
        Users user = imp.getUser();
        Set<ImportDetail> importDetails = imp.getImportDetails();

        // Initialize total quantity and total price
        int totalQuantity = 0;
        float totalSumPrice = 0;

        // Iterate through import details to calculate total quantity and total price
        for (ImportDetail detail : importDetails) {
            totalQuantity += detail.getQuantity();
            totalSumPrice += detail.getQuantity() * detail.getImportPrice();
        }

        // Set attributes to be accessed in the JSP
        request.setAttribute("userId", user.getUserId());
        request.setAttribute("fullName", user.getFullName());
        request.setAttribute("importDetails", importDetails);
        request.setAttribute("totalQuantity", totalQuantity);  // Total quantity
        request.setAttribute("totalSumPrice", totalSumPrice);  // Total price

        // Forward to the detail page
        String detailPage = "import_detail.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(detailPage);
        dispatcher.forward(request, response);
    }


    // Show form to add new import
    public void showAddImportForm() throws ServletException, IOException {
        List<Product> listProduct = productDAO.listAllSortedByStock();
        request.setAttribute("listProduct", listProduct);

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        Users user = userDAO.get(userId);
        String fullName = user.getFullName();
        System.out.println("FullName: " + fullName); // Kiểm tra giá trị fullName
        request.setAttribute("fullName", fullName);
        String addPage = "import_form.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(addPage);
        dispatcher.forward(request, response);
    }


    private void addImport(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Đọc thông tin nhập hàng
        Import imp = readImportInfo(request);

        // Lấy thông tin người dùng từ phiên làm việc
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        // Thiết lập người dùng (người bán)
        Users user = userDAO.get(userId);
        imp.setUser(user);

        // Lấy chi tiết sản phẩm từ form
        String[] productIds = request.getParameterValues("productId");
        String[] quantities = request.getParameterValues("quantity");
        String[] importPrices = request.getParameterValues("importPrice");

        // Kiểm tra tính hợp lệ của dữ liệu
        if (productIds == null || quantities == null || importPrices == null ||
                productIds.length != quantities.length || quantities.length != importPrices.length) {
            throw new ServletException("Thông tin sản phẩm không hợp lệ.");
        }

        // Tạo bộ sưu tập để lưu trữ chi tiết nhập hàng
        Set<ImportDetail> importDetails = new HashSet<>();
        float totalSumPrice = 0;

        // Xử lý từng sản phẩm
        for (int i = 0; i < productIds.length; i++) {
            try {
                // Chuyển đổi dữ liệu
                Integer productId = Integer.parseInt(productIds[i]);
                int quantity = Integer.parseInt(quantities[i]);
                float importPrice = Float.parseFloat(importPrices[i]);

                // Kiểm tra tính hợp lệ
                if (productId <= 0 || quantity <= 0 || importPrice <= 0) {
                    throw new ServletException("Dữ liệu sản phẩm không hợp lệ.");
                }

                // Lấy sản phẩm từ cơ sở dữ liệu
                Product product = productDAO.get(productId);

                // Cập nhật số lượng tồn kho
                int updatedStock = product.getStock() + quantity;
                product.setStock(updatedStock);

                // Cập nhật sản phẩm
                productDAO.update(product);

                // Tạo chi tiết nhập hàng
                ImportDetail importDetail = new ImportDetail();
                importDetail.setProduct(product);
                importDetail.setQuantity(quantity);
                importDetail.setImportPrice(importPrice);
                importDetail.setImportEntity(imp);

                // Thêm chi tiết nhập hàng vào bộ sưu tập
                importDetails.add(importDetail);

                // Tính tổng giá trị nhập hàng
                totalSumPrice += quantity * importPrice;

            } catch (NumberFormatException e) {
                throw new ServletException("Dữ liệu sản phẩm không hợp lệ.", e);
            }
        }

        // Thiết lập chi tiết nhập hàng và tổng giá trị cho nhập hàng
        imp.setImportDetails(importDetails);
        imp.setSumPrice(totalSumPrice);

        // Lưu nhập hàng vào cơ sở dữ liệu
        importDAO.create(imp);

        // Trả về thông báo thành công và chuyển hướng
        String message = "Nhập hàng mới đã được thêm thành công!";
}

    private Import readImportInfo(HttpServletRequest request) {
        // Đọc thông tin nhập hàng từ form
        Import imp = new Import();
        // ...

        return imp;
    }

    // Delete an import
    public void deleteImport() throws ServletException, IOException {
        Integer importId = Integer.parseInt(request.getParameter("id"));
        Import imp = importDAO.get(importId);

        if(imp!=null) {
            importDAO.delete(importId);

            String message = "Import ID " + importId + " has been deleted.";
            listAllImports(message);
        }
        else {
            String message = "Could not find order with ID " + importId
                    + ", or it might have been deleted by another admin.";
            listAllImports(message);
        }
    }

    // Helper method to read import information from request
    private Import readImportInfo() throws ServletException {
        // Create the Import object and set the basic details
        Import imp = new Import();
        imp.setImportDate(new java.util.Date());  // Use the current date as import date

        // Optionally, set the current user for the import
        Users user = (Users) request.getSession().getAttribute("user");
        if (user != null) {
            imp.setUser(user);  // Associate the current user with the import
        }

        // Retrieve product details from the request
        String[] productIds = request.getParameterValues("productId");
        String[] quantities = request.getParameterValues("quantity");
        String[] importPrices = request.getParameterValues("importPrice");

        // Check if all necessary fields are provided (productId, quantity, importPrice)
        if (productIds == null || quantities == null || importPrices == null ||
                productIds.length != quantities.length || quantities.length != importPrices.length) {
            throw new ServletException("Missing or invalid product details.");
        }

        // Loop through the provided product details and create ImportDetail objects
        for (int i = 0; i < productIds.length; i++) {
            try {
                // Parse product data
                int productId = Integer.parseInt(productIds[i]);
                Product product = productDAO.get(productId);  // Assuming you have a productDAO to retrieve products

                int quantity = Integer.parseInt(quantities[i]);
                float importPrice = Float.parseFloat(importPrices[i]);

                // Create the ImportDetail object and add it to the Import object
                ImportDetail importDetail = new ImportDetail();
                importDetail.setProduct(product);
                importDetail.setQuantity(quantity);
                importDetail.setImportPrice(importPrice);
                importDetail.setImportEntity(imp); // Associate with the Import

                imp.getImportDetails().add(importDetail);  // Assuming Import has a List<ImportDetail> getImportDetails()

            } catch (NumberFormatException e) {
                throw new ServletException("Invalid format for product details (e.g., quantity or importPrice).", e);
            } catch (Exception e) {
                throw new ServletException("Error processing product with ID: " + productIds[i], e);
            }
        }

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
}
