package com.keyboardstore.entity;

import static javax.persistence.GenerationType.IDENTITY;

import java.util.HashSet;
import java.util.Set;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@NamedQueries({
	@NamedQuery(name = "Category.findAll", query = "SELECT c FROM Category c ORDER BY c.name"),
	@NamedQuery(name = "Category.countAll", query = "SELECT Count (" + "*" + ") FROM Category"),
	@NamedQuery(name = "Category.findByName", query = "SELECT c FROM Category c WHERE c.name = :name")
})
@Table(name = "category", catalog = "keyboardstoredb")
public class Category implements java.io.Serializable {

	private int categoryId;
	private String name;
	private Set<Product> products = new HashSet<Product>(0);

	public Category() {
	}

	public Category(String name) {
		this.name = name;
	}

	public Category(int categoryId, String name, Set<Product> products) {
		this.categoryId = categoryId;
		this.name = name;
		this.products = products;
	}

	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "category_id", unique = true, nullable = false)
	public int getCategoryId() {
		return this.categoryId;
	}

	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
	}

	@Column(name = "name", nullable = false, length = 30)
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "category")
	public Set<Product> getGames() {
		return this.products;
	}

	public void setGames(Set<Product> products) {
		this.products = products;
	}

}
