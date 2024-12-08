package com.keyboardstore.dao;

import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.persistence.*;

public class JpaDAO<E> {
	private static EntityManagerFactory entityManagerFactory;
	static {
		if (entityManagerFactory == null) {
			entityManagerFactory = Persistence.createEntityManagerFactory("KeyboardStore");
		}
	}

	public JpaDAO() {

	}

	public E create(E entity) {
		EntityManager entityManager = entityManagerFactory.createEntityManager();

		entityManager.getTransaction().begin();

		entityManager.persist(entity);
		entityManager.flush();
		entityManager.refresh(entity);

		entityManager.getTransaction().commit();

		entityManager.close();
		return entity;
	}

	public E update(E entity) {
		EntityManager entityManager = entityManagerFactory.createEntityManager();

		entityManager.getTransaction().begin();

		entity = entityManager.merge(entity);

		entityManager.getTransaction().commit();

		entityManager.close();
		return entity;
	}

	public E find(Class<E> type, Object id) {
		EntityManager entityManager = entityManagerFactory.createEntityManager();

		E entity = entityManager.find(type, id);
		entityManager.refresh(entity);

		entityManager.close();
		return entity;
	}

	public void delete(Class<E> type, Object id) {
		EntityManager entityManager = entityManagerFactory.createEntityManager();

		entityManager.getTransaction().begin();

		Object reference = entityManager.getReference(type, id);
		entityManager.remove(reference);

		entityManager.getTransaction().commit();
		entityManager.close();
	}

	public List<E> findWithNamedQuery(String queryName) {
		EntityManager entityManager = entityManagerFactory.createEntityManager();

		Query query = entityManager.createNamedQuery(queryName);

		List<E> result = query.getResultList();

		entityManager.close();

		return result;
	}

	public List<E> findWithNamedQuery(String queryName, String paramName, Object paramValue) {
		EntityManager entityManager = entityManagerFactory.createEntityManager();

		Query query = entityManager.createNamedQuery(queryName);

		query.setParameter(paramName, paramValue);

		List<E> result = query.getResultList();

		entityManager.close();

		return result;
	}

	public List<E> findWithNamedQuery(String queryName, int firstResult, int maxResult) {
		EntityManager entityManager = entityManagerFactory.createEntityManager();

		Query query = entityManager.createNamedQuery(queryName);
		query.setFirstResult(firstResult);
		query.setMaxResults(maxResult);

		List<E> result = query.getResultList();

		entityManager.close();
		return result;
	}

	public List<Object[]> findWithNamedQueryObjects(String queryName, int firstResult, int maxResult) {
		EntityManager entityManager = entityManagerFactory.createEntityManager();

		Query query = entityManager.createNamedQuery(queryName);
		query.setFirstResult(firstResult);
		query.setMaxResults(maxResult);

		List<Object[]> result = query.getResultList();

		entityManager.close();
		return result;
	}

	public List<E> findWithNamedQuery(String queryName, Map<String, Object> parameters) {
		EntityManager entityManager = entityManagerFactory.createEntityManager();

		Query query = entityManager.createNamedQuery(queryName);
		Set<Entry<String, Object>> setParameters = parameters.entrySet();
		for (Entry<String, Object> entry : setParameters) {
			query.setParameter(entry.getKey(), entry.getValue());
		}
		List<E> result = query.getResultList();
		return result;
	}

	public List<Object[]> findWithNamedQueryObjects(String queryName, Map<String, Object> parameters) {
		EntityManager entityManager = entityManagerFactory.createEntityManager();

		Query query = entityManager.createNamedQuery(queryName);

		// Set the parameters
		Set<Entry<String, Object>> setParameters = parameters.entrySet();
		for (Entry<String, Object> entry : setParameters) {
			query.setParameter(entry.getKey(), entry.getValue());
		}

		List<Object[]> result = query.getResultList();

		entityManager.close();

		return result;
	}


	public long countWithNamedQuery(String queryName) {
		EntityManager entityManager = entityManagerFactory.createEntityManager();
		Query query = entityManager.createNamedQuery(queryName);

		return (long) query.getSingleResult();
	}

	public long countWithNamedQuery(String queryName, String paramName, Object paramValue) {
		EntityManager entityManager = entityManagerFactory.createEntityManager();
		Query query = entityManager.createNamedQuery(queryName);
		query.setParameter(paramName, paramValue);

		return (long)query.getSingleResult();
	}

	public double sumWithNamedQuery(String queryName) {
		EntityManager entityManager = entityManagerFactory.createEntityManager();
		Query query = entityManager.createNamedQuery(queryName);

		Object result = query.getSingleResult();

		// If the result is null, return 0.0 (or handle as needed)
		double sum = (result != null) ? ((Double) result).doubleValue() : 0.0;

		entityManager.close();

		return sum;
	}

	public double sumWithNamedQuery(String queryName, Map<String, Object> parameters) {
		EntityManager entityManager = entityManagerFactory.createEntityManager();
		Query query = entityManager.createNamedQuery(queryName);

		// Set parameters for the query if provided
		if (parameters != null) {
			for (Map.Entry<String, Object> entry : parameters.entrySet()) {
				query.setParameter(entry.getKey(), entry.getValue());
			}
		}

		double sum = 0.0;

		try {
			// Execute the query and retrieve the result
			Object result = query.getSingleResult();

			// Check if the result is null and handle it
			if (result != null) {
				// If the result is a Number, we can safely cast it to a double
				if (result instanceof Number) {
					sum = ((Number) result).doubleValue();
				} else {
					// Handle unexpected result types
					System.err.println("Unexpected result type: " + result.getClass().getName());
				}
			}
		} catch (NoResultException e) {
			// No results found, returning 0.0 as the sum
			sum = 0.0;
		} catch (Exception e) {
			// Catch other exceptions and log them
			e.printStackTrace();
		} finally {
			// Ensure the entity manager is closed to release resources
			entityManager.close();
		}

		return sum;
	}


	public void close() {
		 if (entityManagerFactory != null) { entityManagerFactory.close(); }
	}
	public void updateSize(int productId, int addQuantity) {
		EntityManager entityManager = entityManagerFactory.createEntityManager();

		try {
			entityManager.getTransaction().begin();

			String jpql = "UPDATE Product p SET p.stock = p.stock + ?1 WHERE p.productId = ?2";
			Query query = entityManager.createQuery(jpql);

			query.setParameter(1, addQuantity);
			query.setParameter(2, productId);

			int rowsUpdated = query.executeUpdate();

			entityManager.getTransaction().commit();

			if (rowsUpdated == 0) {
				System.out.println("Không có bản ghi nào được cập nhật");
			} else {
				System.out.println("Đã cập nhật số lượng thành công");
			}

		} catch (Exception e) {
			if (entityManager.getTransaction().isActive()) {
				entityManager.getTransaction().rollback();
			}
			e.printStackTrace();
		} finally {
			entityManager.close();
		}
	}

}
