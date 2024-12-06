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

    private Integer importId;
    private Users user;  // Assuming you have a User entity
    private Date importDate;
    private float sumPrice;
    private Set<ImportDetail> importDetails = new HashSet<>();

    public Import() {
    }

    public Import(Users user, Date importDate, float sumPrice) {
        this.user = user;
        this.importDate = importDate;
        this.sumPrice = sumPrice;
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "import_id", unique = true, nullable = false)
    public Integer getImportId() {
        return importId;
    }

    public void setImportId(Integer importId) {
        this.importId = importId;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    public Users getUser() {
        return user;
    }

    public void setUser(Users user) {
        this.user = user;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "import_date", nullable = false)
    public Date getImportDate() {
        return importDate;
    }

    public void setImportDate(Date importDate) {
        this.importDate = importDate;
    }


    @Column(name = "sum_price", nullable = false)
    public float getSumPrice() {
        return sumPrice;
    }

    public void setSumPrice(float sumPrice) {
        this.sumPrice = sumPrice;
    }

    @OneToMany(fetch = FetchType.EAGER, mappedBy = "importEntity", cascade = CascadeType.ALL, orphanRemoval = true)
    public Set<ImportDetail> getImportDetails() {
        return importDetails;
    }

    public void setImportDetails(Set<ImportDetail> importDetails) {
        this.importDetails = importDetails;
    }
    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((importId == null) ? 0 : importId.hashCode());
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
        Import other = (Import) obj;
        if (importId == null) {
            if (other.importId != null)
                return false;
        } else if (!importId.equals(other.importId))
            return false;
        return true;
    }
    public void addImportDetail(ImportDetail detail) {
        this.importDetails.add(detail);
        detail.setImportEntity(this);
    }
}
