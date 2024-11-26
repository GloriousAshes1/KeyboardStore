/*
package com.gamestore.dao;

import static org.junit.jupiter.api.Assertions.*;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

import com.gamestore.entity.Customer;
import com.gamestore.entity.Game;
import com.gamestore.entity.GameOrder;
import com.gamestore.entity.OrderDetail;
import com.gamestore.entity.OrderDetailId;

class OrderDAOTest {
	private static OrderDAO orderDAO;

	@BeforeAll
	static void setUpBeforeClass() throws Exception {
		orderDAO = new OrderDAO();
	}

	@AfterAll
	static void tearDownAfterClass() throws Exception {
		orderDAO.close();
	}

	@Test
	void testOrderDAO() {
		fail("Not yet implemented");
	}

	@Test
	void testCreateGameOrder() {
		GameOrder order = new GameOrder();
		Customer customer = new Customer();
		customer.setCustomerId(11);
		
		order.setCustomer(customer);
		order.setFirstname("Test");
		order.setPhone("0000000000");
		order.setAddressLine1("test address");
		
		Set<OrderDetail> orderDetails = new HashSet<>();
		OrderDetail orderDetail = new OrderDetail();
		
		Game game = new Game(33);
		orderDetail.setGame(game);
		orderDetail.setQuantity(2);
		orderDetail.setSubtotal(1.98f);
		orderDetail.setProductOrder(order);
		
		orderDetails.add(orderDetail);
		
		order.setOrderDetails(orderDetails);
		
		orderDAO.create(order);
		
		assertTrue(order.getOrderId()!= null && order.getOrderDetails().size() > 0);
	}

	@Test
	void testGet() {
		fail("Not yet implemented");
	}

	@Test
	void testDeleteObject() {
		fail("Not yet implemented");
	}

	@Test
	void testListAll() {
		fail("Not yet implemented");
	}

	@Test
	void testListRecent() {
		List<GameOrder> list = orderDAO.listMostRecentSales();
//		for(GameOrder order : list) {
//			System.out.println(order.getOrderId() +" "+order.getCustomer()+" "+order.getgameQuantities()+" "+order.getTotal());
//		}
		assertEquals(3, list.size());
	}

}
*/
