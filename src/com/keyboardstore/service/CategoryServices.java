package com.keyboardstore.service;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.keyboardstore.dao.CategoryDAO;
import com.keyboardstore.dao.ProductDAO;
import com.keyboardstore.entity.Category;

public class CategoryServices{
	
	private CategoryDAO categoryDAO;
	private HttpServletRequest request;
	private	HttpServletResponse response;
	
	public CategoryServices(HttpServletRequest request, HttpServletResponse response) {
		this.request=request;
		this.response=response;
		
		categoryDAO = new CategoryDAO();
	}
	
	public void listCategory()throws ServletException, IOException {
		listCategory(null);
	}
	
	public void listCategory(String message)throws ServletException, IOException {
		List<Category> listCategory = categoryDAO.listAll();
		
		request.setAttribute("listCategory", listCategory);
		if(message!=null) {
			request.setAttribute("message", message);
		}
		
		String listPage = "category_list.jsp";
		RequestDispatcher requestDispatcher = request.getRequestDispatcher(listPage);
		
		requestDispatcher.forward(request, response);
		
	}
	
	public void createCategory() throws ServletException, IOException {
		String name = request.getParameter("name");
		
		Category existCategory = categoryDAO.findByName(name);
		
		if(existCategory!=null) {
			String message = "Create Category fail. A Category with name: "+ name +" already existed";
			request.setAttribute("message", message);
			RequestDispatcher dispatcher = request.getRequestDispatcher("message.jsp");
			dispatcher.forward(request, response);
		}
		else {
			Category newCategory = new Category(name);
			categoryDAO.create(newCategory);
			
			listCategory("New Category created successfully");
		}
	}
	public void editCategory() throws ServletException, IOException {
		int CategoryId = Integer.parseInt(request.getParameter("id"));
		Category Category = categoryDAO.get(CategoryId);
		
		request.setAttribute("category", Category);
		String editPage = "category_form.jsp";
		RequestDispatcher requestDispatcher = request.getRequestDispatcher(editPage);
		requestDispatcher.forward(request, response);
	}

	public void updateCategory() throws ServletException, IOException {
		int categoryId = Integer.parseInt(request.getParameter("categoryId"));
		String categoryName = request.getParameter("name");
		
		Category categoryById = categoryDAO.get(categoryId);
		Category categoryByName = categoryDAO.findByName(categoryName);
		
		if(categoryByName != null && categoryById.getCategoryId() != categoryByName.getCategoryId()) {
			String message = "Could not update Category. Category with name " + categoryName + " is already exists.";
			request.setAttribute("message", message);
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("message.jsp");
			dispatcher.forward(request, response);
		}
		else {
			categoryById.setName(categoryName);
			categoryDAO.update(categoryById);
			
			String message = "Category is updated successfully";
			listCategory(message);
		}
	}


	public void deleteCategory() throws ServletException, IOException {
		int categoryId = Integer.parseInt(request.getParameter("id"));
		String message;
		ProductDAO gameDAO = new ProductDAO();
		long numberOfGames = gameDAO.countByCategory(categoryId);
		
		if (numberOfGames > 0) {
			message = "Could not delete the category (ID:" + categoryId + ") because it curently contains some games.";
		}
		else {
			categoryDAO.delete(categoryId);
			message = "Category with ID "+ categoryId +" has been deleted successfully";
		}
		listCategory(message);
	}

}
