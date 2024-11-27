
package com.keyboardstore.dao;

import static org.junit.Assert.*;

import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import com.keyboardstore.entity.Product;
import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Test;

import com.keyboardstore.entity.Category;

public class ProductDAOTest {
	private static ProductDAO productDAO;

	@BeforeClass
	public static void setUpBeforeClass() throws Exception {
		productDAO = new ProductDAO();
	}

	@AfterClass
	public static void tearDownAfterClass() throws Exception {
		productDAO.close();
	}

	@Test
	public void testCreateProduct() throws ParseException, IOException {
		Product newProduct = new Product();
		
		CategoryDAO categoryDAO = new CategoryDAO();
		Category category = categoryDAO.get(1);
		
		newProduct.setCategory(category);

		newProduct.setProductName("Diablo® I");
		newProduct.setCode("12345tac");
		newProduct.setBrand("Blizzard Entertainment, Inc.");
		newProduct.setDescription(
				"Join the fight for Sanctuary in Diablo® IV, the ultimate action RPG adventure. Experience the critically acclaimed campaign and new seasonal content.");
		newProduct.setSellingPrice(38.99f);

		DateFormat dateformat = new SimpleDateFormat("dd/MM/yyyy");
		Date publishDate = dateformat.parse("18/10/2023");
		newProduct.setPublishDate(publishDate);

		String imagePath = "C:\\Users\\duylo\\OneDrive\\Máy tính\\App\\KTGK\\item2.jpg";
		newProduct.setImage(imagePath);

		newProduct.setStock(3);

		Product createProduct = productDAO.create(newProduct);

		assertTrue(createProduct.getProductId() > 0);
	}

	@Test
	public void testUpdateGame() throws ParseException, IOException {
		Product existProduct = new Product();
		existProduct.setProductId(33);

		Category category = new Category("Adventure");
		category.setCategoryId(2);
		existProduct.setCategory(category);

		existProduct.setProductName("Elden Ring");
		existProduct.setCode("FromSoftware Inc.");
		existProduct.setBrand("FromSoftware Inc., Bandai Namco Entertainment");
		existProduct.setDescription(
				"THE NEW FANTASY ACTION RPG. Rise, Tarnished, and be guided by grace to brandish the power of the Elden Ring and become an Elden Lord in the Lands Between.");
		existProduct.setSellingPrice(59.99f);

		DateFormat dateformat = new SimpleDateFormat("dd/MM/yyyy");
		Date publishDate = dateformat.parse("25/02/2022");
		existProduct.setPublishDate(publishDate);

		String imagePath = "C:\\Users\\duylo\\OneDrive\\Máy tính\\App\\KTGK\\item1.jpg";
		existProduct.setImage(imagePath);

		Product updateProduct = productDAO.update(existProduct);

		assertEquals(existProduct.getProductName(), "Elden Ring");
	}

	@Test
	public void testGetListAll() {
		List<Product> listProducts = productDAO.listAll();
		for (Product aProduct : listProducts) {
			System.out.println(aProduct.getProductName() + "-" + aProduct.getBrand());
		}
		assertFalse(listProducts.isEmpty());
	}

	@Test
	public void testFindByName() {
		String title = "Counter-Strike 2";
		Product product = productDAO.findByProductName(title);

		System.out.println(product.getCode());
		System.out.println(product.getSellingPrice());

		assertNull(product);
	}
	
	@Test
	public void testListByCategory() {
		int categoryId = 2;
		
		List<Product> listProducts = productDAO.listByCategory(categoryId);
		
		assertTrue(listProducts.size() > 0);
	}
	
	@Test
	public void testListNewGames() {
		List<Product> listNewProducts = productDAO.listNewProducts();
		for (Product Product : listNewProducts) {
			System.out.println(Product.getProductName() + " - " + Product.getPublishDate());
		}
		
		assertEquals(3, listNewProducts.size());
	}
	
	@Test
	public void testSearchGame() {
		String keyword = "Unknown";
		List<Product> result = productDAO.search(keyword);
		
		assertEquals(1, result.size());
	}
	
	@Test
	public void testCountByCategory() {
		int categoryId = 14;
		long numOfGames = productDAO.countByCategory(categoryId);
		
		assertTrue(numOfGames == 2);
	}
	@Test
	public void testBestSelling() {
		List<Product> topSellingProducts = productDAO.listBestSellingProducts();
		
		assertEquals(3, topSellingProducts.size());
	}
}
