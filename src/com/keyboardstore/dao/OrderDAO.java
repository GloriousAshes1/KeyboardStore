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

	public List<Object[]> getProfitsForAllProducts(Date startDate, Date endDate) {
		Map<String, Object> parameters = Map.of(
				"startDate", startDate,
				"endDate", endDate
		);
		return super.findWithNamedQueryObjects("OrderDetail.fetchProfitsForAllProducts", parameters);
	}

	public List<Object[]> getProfitsForSpecificProduct(Integer productId, Date startDate, Date endDate) {
		Map<String, Object> parameters = Map.of(
				"productId", productId,
				"startDate", startDate,
				"endDate", endDate
		);
		return super.findWithNamedQueryObjects("OrderDetail.fetchProfitsForSpecificProduct", parameters);
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

	/**
	 * Get total sales for orders within a specific date range.
	 */
	public Double totalSales(Date startDate, Date endDate) {
		Map<String, Object> parameters = Map.of(
				"startDate", startDate,
				"endDate", endDate
		);
		double sum = sumWithNamedQuery("ProductOrder.sumTotalByDate", parameters);
		return roundToTwoDecimalPlaces(sum);
	}

	/**
	 * Get total tax for orders within a specific date range.
	 */
	public Double totalTax(Date startDate, Date endDate) {
		Map<String, Object> parameters = Map.of(
				"startDate", startDate,
				"endDate", endDate
		);
		double sum = sumWithNamedQuery("ProductOrder.sumTaxByDate", parameters);
		return roundToTwoDecimalPlaces(sum);
	}

	/**
	 * Get total shipping fees for orders within a specific date range.
	 */
	public Double totalShippingFee(Date startDate, Date endDate) {
		Map<String, Object> parameters = Map.of(
				"startDate", startDate,
				"endDate", endDate
		);
		double sum = sumWithNamedQuery("ProductOrder.sumShippingFeeByDate", parameters);
		return roundToTwoDecimalPlaces(sum);
	}

	/**
	 * Get total subtotal for orders within a specific date range.
	 */
	public Double totalSubToTal(Date startDate, Date endDate) {
		Map<String, Object> parameters = Map.of(
				"startDate", startDate,
				"endDate", endDate
		);
		double sum = sumWithNamedQuery("ProductOrder.sumSubToTalByDate", parameters);
		return roundToTwoDecimalPlaces(sum);
	}

	/**
	 * Helper method to round values to two decimal places.
	 */
	private Double roundToTwoDecimalPlaces(double value) {
		BigDecimal bd = new BigDecimal(Double.toString(value));
		bd = bd.setScale(2, RoundingMode.HALF_UP);
		return bd.doubleValue();
	}

}
