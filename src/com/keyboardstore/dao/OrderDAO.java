package com.keyboardstore.dao;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.keyboardstore.entity.ProductOrder;;

public class OrderDAO extends JpaDAO<ProductOrder> implements GenericDAO<ProductOrder> {
	public OrderDAO() {
		super();
	}

	@Override
	public ProductOrder create(ProductOrder order) {
		order.setOrderDate(new Date());
		order.setStatus("Processing");
		return super.create(order);
	}

	@Override
	public ProductOrder update(ProductOrder order) {
		return super.update(order);
	}

	@Override
	public ProductOrder get(Object orderId) {
		return super.find(ProductOrder.class, orderId);
	}

	public ProductOrder get(Integer orderId, Integer customerId) {
		Map<String, Object> parameters = new HashMap<>();
		parameters.put("orderId", orderId);
		parameters.put("customerId", customerId);

		List<ProductOrder> result = super.findWithNamedQuery("ProductOrder.findByIdAndCustomer", parameters);

		if (!result.isEmpty()) {
			return result.get(0);
		}
		return null;
	}

	@Override
	public void delete(Object orderId) {
		super.delete(ProductOrder.class, orderId);
	}

	@Override
	public List<ProductOrder> listAll() {
		return super.findWithNamedQuery("ProductOrder.findAll");
	}

	@Override
	public long count() {
		return super.countWithNamedQuery("ProductOrder.countAll");
	}

	public List<ProductOrder> listByCustomer(Integer customerId) {
		return super.findWithNamedQuery("ProductOrder.findByCustomer", "customerId", customerId);

	}

	public List<ProductOrder> listMostRecentSales() {
		return super.findWithNamedQuery("ProductOrder.findAll", 0, 3);
	}

	public Double totalSales() {
		double sum = sumWithNamedQuery("ProductOrder.sumTotal");
		BigDecimal bd = new BigDecimal(Double.toString(sum));
		bd = bd.setScale(2, RoundingMode.HALF_UP); // Làm tròn đến 2 chữ số thập phân
		return bd.doubleValue();
	}
	public Double totalTax() {
		double sum = sumWithNamedQuery("ProductOrder.sumTax");
		BigDecimal bd = new BigDecimal(Double.toString(sum));
		bd = bd.setScale(2, RoundingMode.HALF_UP); // Làm tròn đến 2 chữ số thập phân
		return bd.doubleValue();
	}
	public Double totalShippingFee() {
		double sum = sumWithNamedQuery("ProductOrder.sumShippingFee");
		BigDecimal bd = new BigDecimal(Double.toString(sum));
		bd = bd.setScale(2, RoundingMode.HALF_UP); // Làm tròn đến 2 chữ số thập phân
		return bd.doubleValue();
	}
	public Double totalSubToTal() {
		double sum = sumWithNamedQuery("ProductOrder.sumSubToTal");
		BigDecimal bd = new BigDecimal(Double.toString(sum));
		bd = bd.setScale(2, RoundingMode.HALF_UP); // Làm tròn đến 2 chữ số thập phân
		return bd.doubleValue();
	}
}
