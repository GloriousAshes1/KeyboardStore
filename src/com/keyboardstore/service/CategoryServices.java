package com.keyboardstore.service;

import com.keyboardstore.dao.CategoryDAO;
import com.keyboardstore.dao.ProductDAO;
import com.keyboardstore.entity.Category;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

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
		listCategory(null,null);
	}

	public void listCategory(String message, String messageType)throws ServletException, IOException {
		List<Category> listCategory = categoryDAO.listAll();

		request.setAttribute("listCategory", listCategory);
		if(message!=null) {
			request.setAttribute("message", message);
			request.setAttribute("messageType", messageType);
		}

		String listPage = "category_list.jsp";
		RequestDispatcher requestDispatcher = request.getRequestDispatcher(listPage);
		requestDispatcher.forward(request, response);

	}

	public void createCategory() throws ServletException, IOException {
		String categoryName = request.getParameter("name");

		Category existCategory = categoryDAO.findByName(categoryName);

		if(existCategory!=null) {
			String message = "Create Category fail. A Category with name: "+ categoryName +" already existed";
			request.setAttribute("message", message);
			request.setAttribute("messageType", "error");
			request.setAttribute("name",categoryName);
		}
		else {
			Category newCategory = new Category(categoryName);
			categoryDAO.create(newCategory);
			listCategory("New Category created successfully","success");
		}
	}
	public void editCategory() throws ServletException, IOException {
		Integer categoryId = Integer.parseInt(request.getParameter("id"));
		Category category = categoryDAO.get(categoryId);

		request.setAttribute("category", category);
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
			request.setAttribute("messageType", "error");
			request.setAttribute("name",categoryName);
		}
		else {
			categoryById.setName(categoryName);
			categoryDAO.update(categoryById);

			String message = "Category is updated successfully";
			listCategory(message,"success");
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
		listCategory(message,"success");
	}

	public void showCategoryNewForm() throws ServletException, IOException {
		String newPage = "category_form.jsp";
		RequestDispatcher requestDispatcher = request.getRequestDispatcher(newPage);
		requestDispatcher.forward(request, response);
	}
}