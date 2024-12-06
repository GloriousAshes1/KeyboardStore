package com.keyboardstore.entity;

import javax.persistence.*;

@Entity
@Table(name = "import_detail")

public class ImportDetail implements java.io.Serializable {

    private ImportDetailId id = new ImportDetailId();
    private Import importEntity;
    private Product product;
    private float importPrice;
    private int quantity;

    public ImportDetail() {
    }

    public ImportDetail(ImportDetailId id) {
        this.id = id;
    }

    public ImportDetail(ImportDetailId id, Import importEntity, Product product, float importPrice, int quantity) {
        this.id = id;
        this.importEntity = importEntity;
        this.product = product;
        this.importPrice = importPrice;
        this.quantity = quantity;
    }

    @EmbeddedId
    @AttributeOverrides({ @AttributeOverride(name = "importId", column = @Column(name = "import_id", nullable = false)),
            @AttributeOverride(name = "productId", column = @Column(name = "product_id", nullable = false))})
    public ImportDetailId getId() {
        return id;
    }

    public void setId(ImportDetailId id) {
        this.id = id;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "import_id", insertable = false, updatable = false, nullable = false)
    public Import getImportEntity() {
        return importEntity;
    }

    public void setImportEntity(Import importEntity) {
        this.importEntity = importEntity;
        this.id.setImportEntity(importEntity);
    }

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "product_id", insertable = false, updatable = false, nullable = false)
    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
        this.id.setProduct(product);
    }

    @Column(name = "import_price", nullable = false)
    public float getImportPrice() {
        return importPrice;
    }

    public void setImportPrice(float importPrice) {
        this.importPrice = importPrice;
    }

    @Column(name = "quantity", nullable = false)
    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
}
