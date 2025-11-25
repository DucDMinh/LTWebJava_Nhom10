package com.haui.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.haui.model.Cart;
import com.haui.model.CartDetail;
import com.haui.model.ProConfiguration;

@Repository
public interface CartDetailRepository extends JpaRepository<CartDetail, Long> {

    CartDetail findByCartAndProConfiguration(Cart cart, ProConfiguration proConfiguration);

    boolean existsByCartAndProConfiguration(Cart cart, ProConfiguration proConfiguration);

    long countByCart(Cart cart);

    List<CartDetail> findByProConfiguration(ProConfiguration proConfiguration);

    List<CartDetail> findAllByCartAndProConfiguration(Cart cart, ProConfiguration proConfiguration);
}
