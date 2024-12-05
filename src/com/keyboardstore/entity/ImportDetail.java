package com.keyboardstore.entity;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "import_detail")

public class ImportDetail implements java.io.Serializable {

    @EmbeddedId
    private ImportDetailId id = new ImportDetailId();

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "import_id", insertable = false, updatable = false, nullable = false)
    private Import importEntity;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_id", insertable = false, updatable = false, nullable = false)
    private Product product;

    @Column(name = "import_price", nullable = false)
    private float importPrice;

    @Column(name = "quantity", nullable = false)
    private int quantity;

    public ImportDetail() {
    }

    public ImportDetail(Import importEntity, Product product, float importPrice, int quantity) {
        this.importEntity = importEntity;
        this.product = product;
        this.importPrice = importPrice;
        this.quantity = quantity;
        this.id.setImportEntity(importEntity);
        this.id.setProduct(product);
    }

    public ImportDetailId getId() {
        return id;
    }

    public void setId(ImportDetailId id) {
        this.id = id;
    }

    public Import getImportEntity() {
        return importEntity;
    }

    public void setImportEntity(Import importEntity) {
        this.importEntity = importEntity;
        this.id.setImportEntity(importEntity);
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
        this.id.setProduct(product);
    }

    public float getImportPrice() {
        return importPrice;
    }

    public void setImportPrice(float importPrice) {
        this.importPrice = importPrice;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
}
