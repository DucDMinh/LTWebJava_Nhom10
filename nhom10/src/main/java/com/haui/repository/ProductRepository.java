package com.haui.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.haui.model.Product;

@Repository
public interface ProductRepository extends JpaRepository<Product, Long> {
    @SuppressWarnings("unchecked")
    Product save(Product laptop);

    Optional<Product> findById(long id);
}
