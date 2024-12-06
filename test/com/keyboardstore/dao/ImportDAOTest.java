package com.keyboardstore.dao;

import static org.junit.jupiter.api.Assertions.*;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.keyboardstore.entity.Import;
import com.keyboardstore.entity.ImportDetail;
import com.keyboardstore.entity.Product;
import com.keyboardstore.entity.Users;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

public class ImportDAOTest {
    private static ImportDAO importDAO;

    @BeforeAll
    public static void setUpBeforeClass() throws Exception {
        importDAO = new ImportDAO();
    }

    @AfterAll
    public static void tearDownAfterClass() throws Exception {
        importDAO.close();
    }

    @Test
    void testImportDAO() {
        fail("Not yet implemented");
    }

    @Test
    void testCreate() {
        Import imp = new Import();
        Users user = new Users();
        user.setUserId(1);
        imp.setUser(user);

        ImportDetail importDetail = new ImportDetail();
        Product product = new Product(51);
        importDetail.setProduct(product);
        importDetail.setImportPrice(9);
        importDetail.setQuantity(10);

        imp.addImportDetail(importDetail); // Sử dụng phương thức addImportDetail

        importDAO.create(imp);

        assertTrue(imp.getImportId() != null && !imp.getImportDetails().isEmpty());
    }
    @Test
    void testListMostRecentImport() {
        List<Import> list = importDAO.listMostRecentImports();
        assertTrue(list.size() > 0);
    }
}
