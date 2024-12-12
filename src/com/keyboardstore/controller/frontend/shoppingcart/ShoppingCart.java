package com.keyboardstore.controller.frontend.shoppingcart;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import com.keyboardstore.entity.Product;

public class ShoppingCart {
	private Map<Product, Integer> cart = new HashMap<>();
	
	public void addItem(Product product) {
		if(cart.containsKey(product)) {
			Integer quantity = cart.get(product) + 1;
			cart.put(product, quantity);
		}else {
			cart.put(product, 1);
		}
	}
	
	public void removeItems(Product product) {
		cart.remove(product);
	}
	
	public int getTotalQuantity() {
		int total = 0;
		
		Iterator<Product> iterator  = cart.keySet().iterator();
		
		while(iterator.hasNext()) {
			Product next = iterator.next();
			Integer quantity = cart.get(next);
			total += quantity;
		}
		
		return total;
	}
	
	public float getTotalAmount() {
		float total = 0.0f;
		
		Iterator<Product> iterator  = cart.keySet().iterator();
		
		while(iterator.hasNext()) {
			Product product = iterator.next();
			Integer quantity = cart.get(product);
			double subTotal = quantity * product.getSellingPrice();
			total += subTotal;
		}
		return total;
	}

	public float getTax(){
        return getTotalAmount() * 0.1f;
	}



	public float getTotalPrice() {
		return getTotalAmount() + getTax();
	}

	public void updateCart(int[] productIds, int[] quantities) {
		for(int i = 0; i < productIds.length; i++) {
			Product key = new Product(productIds[i]);
			Integer value = quantities[i];
			cart.put(key, value);
		}
	}
	
	public int getTotalItems() {
		return cart.size();
	}
	public Map<Product, Integer> getItems(){
		return this.cart;
	}
	public void clear() {
		cart.clear();
	}
}
