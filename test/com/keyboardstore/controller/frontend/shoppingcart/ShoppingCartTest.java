
package com.keyboardstore.controller.frontend.shoppingcart;

import static org.junit.Assert.*;

import java.util.Map;

import com.keyboardstore.entity.Product;
import org.junit.BeforeClass;
import org.junit.Test;

public class ShoppingCartTest {

	private static ShoppingCart cart;
	
	@BeforeClass
	public static void setupBeforeClass() throws Exception{
		cart = new ShoppingCart();
		Product product = new Product();
		
		cart.addItem(product);
		cart.addItem(product);
		
	}
	
	@Test
	public void testAddItem() {
		Map<Product, Integer> items = cart.getItems();
		int quantity = items.get(new Product());
		
		assertEquals(2, quantity);
	}
	@Test
	public void testRemoveItem() {
		cart.removeItems(new Product());
		
		assertTrue(cart.getItems().isEmpty());
	}
	@Test
	public void testGetTotalQuantity() {
		Product product1 = new Product();
		
		cart.addItem(product1);
		cart.addItem(product1);
		cart.addItem(product1);
		
		assertEquals(5, cart.getTotalQuantity());
	}
	
	@Test
	public void testUpdateCart() {
		ShoppingCart cart = new ShoppingCart();
		Product product = new Product(33);
		Product product1 = new Product(35);
		
		cart.addItem(product);
		cart.addItem(product1);
		
		int[] gameIds = {1, 2};
		int[] quantites = {3, 4};
		
		cart.updateCart(gameIds, quantites);
		
		assertEquals(7, cart.getTotalQuantity());
	}
}

