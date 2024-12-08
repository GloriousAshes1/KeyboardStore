package com.keyboardstore.entity;

import static javax.persistence.GenerationType.IDENTITY;

import java.util.Date;
import java.util.HashSet;
import java.util.Locale;
import java.util.Set;

import javax.persistence.CascadeType;
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

@Entity
@Table(name = "product_order", catalog = "keyboardstoredb")
@NamedQueries({
	@NamedQuery(name = "ProductOrder.findAll", query = "SELECT po FROM ProductOrder po ORDER BY po.orderDate DESC"),
	@NamedQuery(name = "ProductOrder.countAll", query = "SELECT COUNT(*) FROM ProductOrder"),
	@NamedQuery(name = "ProductOrder.findByCustomer", query = "SELECT po FROM ProductOrder po JOIN FETCH po.orderDetails WHERE po.customer.customerId =:customerId ORDER BY po.orderDate DESC"),
	@NamedQuery(name = "ProductOrder.findByIdAndCustomer", query = "SELECT po FROM ProductOrder po WHERE po.orderId =:orderId AND po.customer.customerId =:customerId"),
	@NamedQuery(name = "ProductOrder.countByCustomer", query = "SELECT COUNT(po.orderId) FROM ProductOrder po WHERE po.customer.customerId =:customerId"),
	@NamedQuery(name = "ProductOrder.sumTotal", query = "SELECT SUM(po.total) FROM ProductOrder po"),
	@NamedQuery(name = "ProductOrder.sumTax", query = "SELECT SUM(po.tax) FROM ProductOrder po "),
	@NamedQuery(name = "ProductOrder.sumShippingFee", query = "SELECT SUM(po.shippingFee) FROM ProductOrder po "),
	@NamedQuery(name = "ProductOrder.sumSubToTal", query = "SELECT SUM(po.subtotal) FROM ProductOrder po "),
		@NamedQuery(name = "ProductOrder.sumTotalByDate",
				query = "SELECT SUM(o.total) FROM ProductOrder o WHERE o.orderDate BETWEEN :startDate AND :endDate"),
		@NamedQuery(name = "ProductOrder.sumTaxByDate",
				query = "SELECT SUM(o.tax) FROM ProductOrder o WHERE o.orderDate BETWEEN :startDate AND :endDate"),
		@NamedQuery(name = "ProductOrder.sumShippingFeeByDate",
				query = "SELECT SUM(o.shippingFee) FROM ProductOrder o WHERE o.orderDate BETWEEN :startDate AND :endDate"),
		@NamedQuery(name = "ProductOrder.sumSubToTalByDate",
				query = "SELECT SUM(o.subtotal) FROM ProductOrder o WHERE o.orderDate BETWEEN :startDate AND :endDate")
})
public class ProductOrder implements java.io.Serializable {

	private Integer orderId;
	private Customer customer;
	private Date orderDate;
	private String addressLine1;
	private String addressLine2;
	private String firstname;
	private String lastname;
	private String phone;
	private String city;
	private String state;
	private String zipcode;
	private String country;
	private String paymentMethod;
	private String status;
	private Set<OrderDetail> orderDetails = new HashSet<OrderDetail>(0);

	private float total;
	private float subtotal;
	private float shippingFee;
	private float tax;

	public ProductOrder() {
	}

	public ProductOrder(Customer customer, Date orderDate, String shippingAddress, String recipientName,
						String recipientPhone, String paymentMethod, float total, String status) {
		this.customer = customer;
		this.orderDate = orderDate;
		this.addressLine1 = shippingAddress;
		this.firstname = recipientName;
		this.phone = recipientPhone;
		this.paymentMethod = paymentMethod;
		this.total = total;
		this.status = status;
	}

	public ProductOrder(Customer customer, Date orderDate, String shippingAddress, String recipientName,
						String recipientPhone, String paymentMethod, float total, String status, Set<OrderDetail> orderDetails) {
		this.customer = customer;
		this.orderDate = orderDate;
		this.addressLine1 = shippingAddress;
		this.firstname = recipientName;
		this.phone = recipientPhone;
		this.paymentMethod = paymentMethod;
		this.total = total;
		this.status = status;
		this.orderDetails = orderDetails;
	}

	@Id
	@GeneratedValue(strategy = IDENTITY)

	@Column(name = "order_id", unique = true, nullable = false)
	public Integer getOrderId() {
		return this.orderId;
	}

	public void setOrderId(Integer orderId) {
		this.orderId = orderId;
	}

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "customer_id", nullable = false)
	public Customer getCustomer() {
		return this.customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "order_date", nullable = false, length = 19)
	public Date getOrderDate() {
		return this.orderDate;
	}

	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}

	@Column(name = "r_address_line1", nullable = false, length = 256)
	public String getAddressLine1() {
		return this.addressLine1;
	}

	public void setAddressLine1(String shippingAddress) {
		this.addressLine1 = shippingAddress;
	}

	@Column(name = "r_lastname", nullable = false, length = 30)
	public String getLastname() {
		return this.lastname;
	}

	public void setLastname(String lastName) {
		this.lastname = lastName;
	}

	@Column(name = "r_firstname", nullable = false, length = 30)
	public String getFirstname() {
		return this.firstname;
	}

	public void setFirstname(String firstName) {
		this.firstname = firstName;
	}

	@Column(name = "r_phone", nullable = false, length = 15)
	public String getPhone() {
		return this.phone;
	}

	@Column(name = "r_address_line2", nullable = false, length = 256)
	public String getAddressLine2() {
		return addressLine2;
	}

	public void setAddressLine2(String addressLine2) {
		this.addressLine2 = addressLine2;
	}

	@Column(name = "r_city", nullable = false, length = 32)
	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	@Column(name = "r_state", nullable = false, length = 45)
	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	@Column(name = "r_zipcode", nullable = false, length = 24)
	public String getZipcode() {
		return zipcode;
	}

	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}

	@Column(name = "r_country", nullable = false, length = 4)
	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}
	
	@Transient
	public String getCountryName() {
		return new Locale("", this.country).getDisplayCountry();
	}

	@Column(name = "subtotal", nullable = false, precision = 12, scale = 0)
	public float getSubtotal() {
		return subtotal;
	}

	public void setSubtotal(float subtotal) {
		this.subtotal = subtotal;
	}

	@Column(name = "shipping_fee", nullable = false, precision = 12, scale = 0)
	public float getShippingFee() {
		return shippingFee;
	}

	public void setShippingFee(float shippingFee) {
		this.shippingFee = shippingFee;
	}

	@Column(name = "tax", nullable = false, precision = 12, scale = 0)
	public float getTax() {
		return tax;
	}

	public void setTax(float tax) {
		this.tax = tax;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	@Column(name = "payment_method", nullable = false, length = 20)
	public String getPaymentMethod() {
		return this.paymentMethod;
	}

	public void setPaymentMethod(String paymentMethod) {
		this.paymentMethod = paymentMethod;
	}

	@Column(name = "total", nullable = false, precision = 12, scale = 0)
	public float getTotal() {
		return this.total;
	}

	public void setTotal(float total) {
		this.total = total;
	}

	@Column(name = "status", nullable = false, length = 20)
	public String getStatus() {
		return this.status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@OneToMany(fetch = FetchType.EAGER, mappedBy = "productOrder", cascade = CascadeType.ALL, orphanRemoval = true)
	public Set<OrderDetail> getOrderDetails() {
		return this.orderDetails;
	}

	public void setOrderDetails(Set<OrderDetail> orderDetails) {
		this.orderDetails = orderDetails;
	}

	@Transient
	public int getProductQuantities() {
		int total = 0;

		for (OrderDetail orderDetail : orderDetails) {
			total += orderDetail.getQuantity();
		}

		return total;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((orderId == null) ? 0 : orderId.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		ProductOrder other = (ProductOrder) obj;
		if (orderId == null) {
			if (other.orderId != null)
				return false;
		} else if (!orderId.equals(other.orderId))
			return false;
		return true;
	}
}