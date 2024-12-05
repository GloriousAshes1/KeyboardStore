package com.keyboardstore.dao;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.keyboardstore.entity.Import;

public class ImportDAO extends JpaDAO<Import> implements GenericDAO<Import> {

    public ImportDAO() {
        super();
    }

    @Override
    public Import create(Import imp) {
        imp.setImportDate(new Date());
        return super.create(imp);
    }

    @Override
    public Import update(Import imp) {
        return super.update(imp);
    }

    @Override
    public Import get(Object importId) {
        return super.find(Import.class, importId);
    }

    public Import get(Integer importId, Integer userId) {
        Map<String, Object> parameters = new HashMap<>();
        parameters.put("importId", importId);
        parameters.put("userId", userId);

        List<Import> result = super.findWithNamedQuery("Import.findByIdAndUser", parameters);

        if (!result.isEmpty()) {
            return result.get(0);
        }
        return null;
    }

    @Override
    public void delete(Object importId) {
        super.delete(Import.class, importId);
    }

    @Override
    public List<Import> listAll() {
        return super.findWithNamedQuery("Import.findAll");
    }

    @Override
    public long count() {
        return super.countWithNamedQuery("Import.countAll");
    }

    public List<Import> listByUser(Integer userId) {
        return super.findWithNamedQuery("Import.findByUser", "userId", userId);
    }

    public List<Import> listMostRecentImports() {
        return super.findWithNamedQuery("Import.findAll", 0, 3);
    }

    public Double totalImports() {
        double sum = sumWithNamedQuery("Import.sumTotal");
        BigDecimal bd = new BigDecimal(Double.toString(sum));
        bd = bd.setScale(2, RoundingMode.HALF_UP); // Round to 2 decimal places
        return bd.doubleValue();
    }

//    public Double totalImportsByDay(Date startDate, Date endDate) {
//        double sum = sumWithNamedQuery("Import.sumTotalByDay", "startDate", startDate, "endDate", endDate);
//        BigDecimal bd = new BigDecimal(Double.toString(sum));
//        bd = bd.setScale(2, RoundingMode.HALF_UP); // Round to 2 decimal places
//        return bd.doubleValue();
//    }
//
//    public Double totalImportsByMonth(Date startDate, Date endDate) {
//        double sum = sumWithNamedQuery("Import.sumTotalByMonth", "startDate", startDate, "endDate", endDate);
//        BigDecimal bd = new BigDecimal(Double.toString(sum));
//        bd = bd.setScale(2, RoundingMode.HALF_UP); // Round to 2 decimal places
//        return bd.doubleValue();
//    }
//
//    public Double totalImportsByYear(Date startDate, Date endDate) {
//        double sum = sumWithNamedQuery("Import.sumTotalByYear", "startDate", startDate, "endDate", endDate);
//        BigDecimal bd = new BigDecimal(Double.toString(sum));
//        bd = bd.setScale(2, RoundingMode.HALF_UP); // Round to 2 decimal places
//        return bd.doubleValue();
//    }
}
