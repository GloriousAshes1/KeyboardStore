package com.keyboardstore.entity;
// Generated May 18, 2024, 11:32:32 AM by Hibernate Tools 4.3.6.Final

import static javax.persistence.GenerationType.IDENTITY;

import java.util.Comparator;
import java.util.Date;
import java.util.HashSet;
import java.util.Objects;
import java.util.Set;
import java.util.TreeSet;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;
import javax.persistence.UniqueConstraint;

@Entity
@Table(name = "product", catalog = "keyboardstoredb", uniqueConstraints = @UniqueConstraint(columnNames = "product_name"))
@NamedQueries({
	@NamedQuery(name = "Product.findAll", query = "SELECT p FROM Product p"),
		@NamedQuery(name = "Product.findAllSortedByStock", query = "SELECT p FROM Product p ORDER BY p.stock ASC"),
		@NamedQuery(name = "Product.findByProductName", query = "SELECT p FROM Product p WHERE p.productName = :productName"),
	@NamedQuery(name = "Product.countAll", query = "SELECT COUNT(*) FROM Product p"),
	@NamedQuery(name = "Product.countByCategory", query = "SELECT COUNT(p) FROM Product p WHERE p.category.categoryId = :catId"),
	@NamedQuery(name = "Product.findByCategory", query = "SELECT p FROM Product p JOIN Category c ON p.category.categoryId = c.categoryId AND c.categoryId = :catId"),
	@NamedQuery(name = "Product.listNew", query = "SELECT p FROM Product p ORDER BY p.publishDate DESC"),
	@NamedQuery(name = "Product.search", query = "SELECT p FROM Product p WHERE p.productName LIKE '%' || :keyword || '%' "
												+ " OR p.brand LIKE '%' || :keyword || '%'"
												+ " OR p.code LIKE '%' || :keyword || '%'")
})
public class Product implements java.io.Serializable {

	private Integer productId;
	private Category category;
	private String productName;
	private String image;
	private String code;
	private String brand;
	private String description;
	private float sellingPrice;
	private float importPrice;
	private Date publishDate;
	private int stock;
	private Set<OrderDetail> orderDetails = new HashSet<OrderDetail>(0);
	private Set<Review> reviews = new HashSet<Review>(0);
	
	@Transient
	private String base64Image;

	public Product() {
	}

	public Product(Integer productId) {
		super();
		this.productId = productId;
	}

	public Product(Category category, String productName, String code, String brand, String description,
				   String image, float sellingPrice, float importPrice ,Date publishDate, int stock) {
		this.category = category;
		this.productName = productName;
		this.code = code;
		this.brand = brand;
		this.description = description;
		this.image = image;
		this.sellingPrice = sellingPrice;
		this.importPrice = importPrice;
		this.publishDate = publishDate;
		this.stock = stock;
	}

	public Product(Category category, String productName, String code, String brand, String description,
				   String image, float sellingPrice, float importPrice , Date publishDate, int stock, Set<OrderDetail> orderDetails,
				   Set<Review> reviews) {
		this.category = category;
		this.productName = productName;
		this.code = code;
		this.brand = brand;
		this.description = description;
		this.image = image;
		this.sellingPrice = sellingPrice;
		this.importPrice = importPrice;
		this.publishDate = publishDate;
		this.stock = stock;
		this.orderDetails = orderDetails;
		this.reviews = reviews;
	}

	@Id
	@GeneratedValue(strategy = IDENTITY)
	
	@Column(name = "product_id", unique = true, nullable = false)
	public Integer getProductId() {
		return this.productId;
	}

	public void setProductId(Integer gameId) {
		this.productId = gameId;
	}

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "category_id", nullable = false)
	public Category getCategory() {
		return this.category;
	}

	public void setCategory(Category category) {
		this.category = category;
	}

	@Column(name = "product_name", unique = true, nullable = false, length = 128)
	public String getProductName() {
		return this.productName;
	}

	public void setProductName(String title) {
		this.productName = title;
	}

	@Column(name = "code", nullable = false, length = 64)
	public String getCode() {
		return this.code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	@Column(name = "brand", nullable = false, length = 64)
	public String getBrand() {
		return this.brand;
	}

	public void setBrand(String brand) {
		this.brand = brand;
	}

	@Column(name = "description", nullable = false, length = 16777215)
	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	@Column(name = "image", nullable = false)
	public String getImage() {
		return this.image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	@Column(name = "selling_price", nullable = false, precision = 12, scale = 0)
	public float getSellingPrice() {
		return this.sellingPrice;
	}

	public void setSellingPrice(float price) {
		this.sellingPrice = price;
	}

	@Column(name = "import_price", nullable = false, precision = 12, scale = 0)
	public float getImportPrice() {
		return this.importPrice;
	}

	public void setImportPrice(float importPrice) {
		this.sellingPrice = importPrice;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "publish_date", nullable = false, length = 10)
	public Date getPublishDate() {
		return this.publishDate;
	}

	public void setPublishDate(Date publishDate) {
		this.publishDate = publishDate;
	}

	@Column(name = "stock", nullable = false, length = 19)
	public int getStock() {
		return this.stock;
	}

	public void setStock(int stock) {
		this.stock = stock;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "product")
	public Set<OrderDetail> getOrderDetails() {
		return this.orderDetails;
	}

	public void setOrderDetails(Set<OrderDetail> orderDetails) {
		this.orderDetails = orderDetails;
	}

	@OneToMany(fetch = FetchType.EAGER, mappedBy = "product")
	public Set<Review> getReviews() {
		TreeSet<Review> sortedReviews = new TreeSet<>(new Comparator<Review>() {

			@Override
			public int compare(Review review1, Review review2) {
				return review2.getReviewTime().compareTo(review1.getReviewTime());
			}
			
		});
		
		sortedReviews.addAll(reviews);
		return sortedReviews;
	}

	public void setReviews(Set<Review> reviews) {
		this.reviews = reviews;
	}
	
	@Transient
	public int getSumReviews() {
		int sum = 0;
		
		if (reviews.isEmpty()) {
			return 0;
		}
		
		for (Review review : reviews) {
			sum++;
		}
		
		return sum;
	}
	
	@Transient
	public float getAverageRating() {
		float averageRating = 0.0f;
		float sum = 0.0f;
		
		if (reviews.isEmpty()) {
			return 0.0f;
		}
		
		for (Review review : reviews) {
			sum += review.getRating();
		}
		
		averageRating = sum / reviews.size();
		
		return averageRating;
	}
	
	@Transient
	public String getRatingStars() {
		float averageRating = getAverageRating();
		
		return getRatingString(averageRating);
	}
	
	@Transient
	public String getRatingString(float averageRating) {
		String result = "";
		
		int numberOfStarsOn = (int)averageRating;
		
		for (int i = 1; i <= numberOfStarsOn; i++) {
			result += "on,";
		}
		
		int next = numberOfStarsOn + 1;
		
		if (averageRating > numberOfStarsOn) {
			result += "half,";
			next++;
		}
		
		for (int i = next; i <= 5; i++) {
			result += "off,";
		}
		
		return result.substring(0, result.length() - 1);
	}

	@Override
	public int hashCode() {
		return Objects.hash(productId);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Product other = (Product) obj;
		return productId == other.productId;
	}
}
