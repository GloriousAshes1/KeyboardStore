
package com.keyboardstore.dao;

import static org.junit.Assert.*;

import java.util.List;

import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Test;

import com.keyboardstore.entity.Category;

public class CategoryDAOTest extends BaseDAOTest{
	private static CategoryDAO categoryDAO; 
	
	@BeforeClass
	public static void setUpBeforeClass() throws Exception {
		categoryDAO = new CategoryDAO();
	}

	@AfterClass
	public static void tearDownAfterClass() throws Exception {
		categoryDAO.close();
	}

	@Test
	public void testCreateCategory() {
		Category newCat = new Category("Tac Tile");
		Category category = categoryDAO.create(newCat);
		
		assertTrue(category != null && category.getCategoryId()>0);
	}

	@Test
	public void testUpdateCategory() {
		Category cat = new Category("Casual");
		
		cat.setCategoryId(2);
		
		Category category = categoryDAO.update(cat);
		
		assertEquals(cat.getName(), category.getName());
	}

	@Test
	public void testGet() {
		Integer catId = 1;
		Category cat = categoryDAO.get(catId);
		System.out.println(cat.getName()+" "+cat.getCategoryId());
		assertNotNull(cat);
	}

	@Test
	public void testDeleteCategory() {
		Integer catId = 2;
		categoryDAO.delete(catId);
		
		Category cat = categoryDAO.get(catId);
		
		assertNull(cat);
	}

	@Test
	public void testListAll() {
		List<Category> listCategory = categoryDAO.listAll();
		listCategory.forEach(c -> System.out.println(c.getName()+ " "));
		assertTrue(listCategory.size()>0);
	}

	@Test
	public void testCount() {
		long totalCategories = categoryDAO.count();
		
		assertEquals(totalCategories, 3);
	}
	
	@Test
	public void testFindByName() {
		String name = "FPS1";
		Category category =  categoryDAO.findByName(name);
		
		assertNotNull(category);
	}
}

