package com.keyboardstore.dao;

import java.util.ArrayList;
import java.util.List;

import com.keyboardstore.entity.Product;

public class ProductDAO extends JpaDAO<Product> implements GenericDAO<Product> {
	public ProductDAO() {
	}

	@Override
	public Product create(Product product) {
		return super.create(product);
	}
	
	@Override
	public Product update(Product product) {
		return super.update(product);
	}
	
	@Override
	public Product get(Object id) {
		return super.find(Product.class, id);
	}

	@Override
	public void delete(Object id) {
		super.delete(Product.class, id);
		
	}

	@Override
	public List<Product> listAll() {
		return super.findWithNamedQuery("Product.findAll");
	}

	public Product findByProductName(String productName) {
		List<Product> result = super.findWithNamedQuery("Product.findByProductName", "productName", productName);
		if(!result.isEmpty()){
			return result.get(0);
		}
		return null;
	}
	
	public List<Product> listByCategory(int categoryId) {
		return super.findWithNamedQuery("Product.findByCategory", "catId", categoryId);
	}
	
	public List<Product> search(String keyword) {
		return super.findWithNamedQuery("Product.search", "keyword", keyword);
	}
	
	public List<Product> listNewProducts() {
		return super.findWithNamedQuery("Product.listNew", 0,4);
	}
	 

	@Override
	public long count() {
		return super.countWithNamedQuery("Product.countAll");
	}
	
	public long countByCategory(int categoryId) {
		return super.countWithNamedQuery("Product.countByCategory", "catId", categoryId);
	}
	
	public List<Product> listBestSellingProducts(){
		return super.findWithNamedQuery("OrderDetail.bestSelling", 0, 3);
	}
	
	public List<Product> listMostFavoredProducts(){
		List<Object[]> result = super.findWithNamedQueryObjects("Review.mostFavoredProducts", 0, 3);
		List<Product> mostFavoredProducts = new ArrayList<>();
		if(!result.isEmpty()) {
			for(Object[] elements : result) {
				Product product = (Product) elements[0];
				mostFavoredProducts.add(product);
			}
		}
		return mostFavoredProducts;
	}
}
