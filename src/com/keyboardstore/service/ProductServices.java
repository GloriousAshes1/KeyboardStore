package com.keyboardstore.service;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.keyboardstore.dao.CategoryDAO;
import com.keyboardstore.dao.ProductDAO;
import com.keyboardstore.entity.Category;
import com.keyboardstore.entity.Product;

public class ProductServices {
	private EntityManager entityManager;
	private ProductDAO productDAO;
	private CategoryDAO categoryDAO;
	private HttpServletRequest request;
	private	HttpServletResponse response;
	
	
	
	public ProductServices(HttpServletRequest request, HttpServletResponse response) {
		super();
		this.request = request;
		this.response = response;
		productDAO = new ProductDAO();
		categoryDAO = new CategoryDAO();
	}

	public void listProducts() throws ServletException, IOException {
		listProducts(null);
	}

	public void listProducts(String message) throws ServletException, IOException {
		List<Product> listProducts = productDAO.listAll();
		request.setAttribute("listProducts", listProducts);
		
		if(message != null) {
			request.setAttribute("message", message);
		}
		
		String listPage = "product_list.jsp";
		RequestDispatcher requestDispatcher = request.getRequestDispatcher(listPage);
		requestDispatcher.forward(request, response);
	}
	
	public void showProductNewForm() throws ServletException, IOException {
		List<Category> listCategory = categoryDAO.listAll();
		request.setAttribute("listCategory", listCategory);
		
		String newPage = "product_form.jsp";
		RequestDispatcher requestDispatcher = request.getRequestDispatcher(newPage);
		requestDispatcher.forward(request, response);
	}

	public void createProduct() throws ServletException, IOException {
		String productName = request.getParameter("productName");
		
		Product existProduct = productDAO.findByTitle(productName);
		if (existProduct != null) {
			String message = "Could not create new Product because the productName '" + productName + "' already exists.";
			listProducts(message);
			return;
		}
		
		Product newProduct = new Product();
		readProductFields(newProduct);
		
		Product createdProduct = productDAO.create(newProduct);
		
		if (createdProduct.getProductId() > 0) {
			String message = "A new Product has been created successfully";
			listProducts(message);
		}
	}
	
	public void readProductFields(Product product) throws ServletException, IOException {
	    String productName = request.getParameter("productName");
	    String code = request.getParameter("code");
	    String brand = request.getParameter("brand");
	    String description = request.getParameter("description");
	    float price = Float.parseFloat(request.getParameter("sellingPrice"));
	    
	    final String newFormat = "yyyy-MM-dd";
	    SimpleDateFormat sdf = new SimpleDateFormat(newFormat);
	    Date publishDate = null;
	    
	    try {
	        String publishDateString = request.getParameter("publishDate");
	        if (publishDateString != null && !publishDateString.isEmpty()) {
	            publishDate = sdf.parse(publishDateString);
	        } else {
	            throw new ServletException("Publish date is required and cannot be empty.");
	        }
	    } catch (ParseException ex) {
	        ex.printStackTrace();
	        throw new ServletException("Error parsing date (format is yyyy-MM-dd)");
	    }
	    
	    product.setProductName(productName);
	    product.setCode(code);
	    product.setBrand(brand);
	    product.setDescription(description);
	    product.setSellingPrice(price);
	    product.setPublishDate(publishDate);
	    
	    Integer categoryId = Integer.parseInt(request.getParameter("category"));        
	    Category category = categoryDAO.get(categoryId);
	    product.setCategory(category);
	    
	    int stock = 1;
	    product.setStock(stock);
	    
	    Part part = request.getPart("image");
	    if (part != null && part.getSize() > 0) {
	        long size = part.getSize();
	        String image = "123";
	        product.setImage(image);
	    }
	}

	public void editProduct() throws ServletException, IOException {
		Integer ProductId = Integer.parseInt(request.getParameter("id"));
		Product product = productDAO.get(ProductId);
		
		List<Category> listCategory = categoryDAO.listAll();
		
		request.setAttribute("Product", product);
		request.setAttribute("listCategory", listCategory);
		
		String editPage = "product_form.jsp";
		RequestDispatcher requestDispatcher = request.getRequestDispatcher(editPage);
		requestDispatcher.forward(request, response);
	}

	public void updateProduct() throws ServletException, IOException {
		Integer ProductId = Integer.parseInt(request.getParameter("ProductId"));
		String title = request.getParameter("title");
		
		Product existProduct = productDAO.get(ProductId);
		Product productByTitle = productDAO.findByTitle(title);
		
		if (productByTitle != null && !existProduct.equals(productByTitle)) {
			String message = "Couldn't update Product because there's another Product having same title.";
			listProducts(message);
			return;
		}
		
		readProductFields(existProduct);
		
		productDAO.update(existProduct);
		
		String message = "The Product has been updated successfully";
		listProducts(message);
	}

	public void deleteProduct() throws ServletException, IOException {
		Integer ProductId = Integer.parseInt(request.getParameter("id"));

		productDAO.delete(ProductId);
		
		String message = "The Product has been deleted successfully.";
		listProducts(message);
	}

	public void listProductsByCategory() throws ServletException, IOException {
		int categoryId = Integer.parseInt(request.getParameter("id"));
		List<Product> listProducts = productDAO.listByCategory(categoryId);
		Category category = categoryDAO.get(categoryId);
		List<Category> listCategory = categoryDAO.listAll();
		
		request.setAttribute("listCategory", listCategory);
		request.setAttribute("listProducts", listProducts);
		request.setAttribute("category", category);
		
		String listPage = "frontend/products_list_by_category.jsp";
		RequestDispatcher requestDispatcher = request.getRequestDispatcher(listPage);
		requestDispatcher.forward(request, response);
	}

	public void viewProductDetail() throws ServletException, IOException {
		Integer productId = Integer.parseInt(request.getParameter("id"));
		Product product = productDAO.get(productId);
		List<Category> listCategory = categoryDAO.listAll();
		
		request.setAttribute("listCategory", listCategory);
		request.setAttribute("product", product);
		
		String detailPage = "frontend/product_detail.jsp";
		RequestDispatcher requestDispatcher = request.getRequestDispatcher(detailPage);
		requestDispatcher.forward(request, response);
	}

	public void search() throws ServletException, IOException {
		String keyword = request.getParameter("keyword");
		List<Product> result = null;
		
		if (keyword.equals("")) {
			result = productDAO.listAll();
		}
		else {
			result = productDAO.search(keyword);
		}
		
		request.setAttribute("keyword", keyword);
		request.setAttribute("result", result);
		
		String resultPage = "frontend/search_result.jsp";
		RequestDispatcher requestDispatcher = request.getRequestDispatcher(resultPage);
		requestDispatcher.forward(request, response);
	}
}
