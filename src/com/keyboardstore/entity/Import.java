package com.keyboardstore.entity;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;
import javax.persistence.*;

@Entity
@Table(name = "import")
@NamedQueries({
        @NamedQuery(name = "Import.findAll", query = "SELECT i FROM Import i ORDER BY i.importDate DESC"),
        @NamedQuery(name = "Import.countAll", query = "SELECT COUNT(i) FROM Import i"),
        @NamedQuery(name = "Import.findByUser", query = "SELECT i FROM Import i WHERE i.user.userId =:userId ORDER BY i.importDate DESC"),
        @NamedQuery(name = "Import.findByIdAndUser", query = "SELECT i FROM Import i WHERE i.importId =:importId AND i.user.userId =:userId"),
        @NamedQuery(name = "Import.countByUser", query = "SELECT COUNT(i.importId) FROM Import i WHERE i.user.userId =:userId"),
        @NamedQuery(name = "Import.sumTotal", query = "SELECT SUM(i.sumPrice) FROM Import i"),
        @NamedQuery(name = "Import.sumTotalByDay", query = "SELECT DATE(i.importDate), SUM(i.sumPrice) FROM Import i WHERE i.importDate BETWEEN :startDate AND :endDate GROUP BY DATE(i.importDate)"),
        @NamedQuery(name = "Import.sumTotalByMonth", query = "SELECT FUNCTION('DATE_FORMAT', i.importDate, '%Y-%m'), SUM(i.sumPrice) FROM Import i WHERE i.importDate BETWEEN :startDate AND :endDate GROUP BY FUNCTION('DATE_FORMAT', i.importDate, '%Y-%m')"),
        @NamedQuery(name = "Import.sumTotalByYear", query = "SELECT YEAR(i.importDate), SUM(i.sumPrice) FROM Import i WHERE i.importDate BETWEEN :startDate AND :endDate GROUP BY YEAR(i.importDate)")
})
public class Import implements java.io.Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "import_id", unique = true, nullable = false)
    private Integer importId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private Users user;  // Assuming you have a User entity

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "import_date", nullable = false)
    private Date importDate;

    @Column(name = "sum_price", nullable = false)
    private float sumPrice;

    @OneToMany(fetch = FetchType.EAGER, mappedBy = "importEntity", cascade = CascadeType.ALL, orphanRemoval = true)
    private Set<ImportDetail> importDetails = new HashSet<>();

    public Import() {
    }

    public Import(Users user, Date importDate, float sumPrice) {
        this.user = user;
        this.importDate = importDate;
        this.sumPrice = sumPrice;
    }

    public Integer getImportId() {
        return importId;
    }

    public void setImportId(Integer importId) {
        this.importId = importId;
    }

    public Users getUser() {
        return user;
    }

    public void setUser(Users user) {
        this.user = user;
    }

    public Date getImportDate() {
        return importDate;
    }

    public void setImportDate(Date importDate) {
        this.importDate = importDate;
    }

    public float getSumPrice() {
        return sumPrice;
    }

    public void setSumPrice(float sumPrice) {
        this.sumPrice = sumPrice;
    }

    public Set<ImportDetail> getImportDetails() {
        return importDetails;
    }

    public void setImportDetails(Set<ImportDetail> importDetails) {
        this.importDetails = importDetails;
    }
}
