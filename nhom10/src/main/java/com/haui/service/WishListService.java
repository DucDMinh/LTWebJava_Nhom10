package com.haui.service;

import com.haui.model.Product;
import com.haui.model.User;
import com.haui.model.WishList;
import com.haui.repository.WishListRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class WishListService {

    @Autowired
    private WishListRepository wishListRepository;

    public List<WishList> getWishListByUser(Integer userId) {
        return wishListRepository.findByUserId(userId);
    }

    public WishList addToWishList(User user, Product product) {
        Optional<WishList> existing = wishListRepository.findByUserIdAndProductId(user.getId(), product.getId());
        if (existing.isPresent()) {
            return existing.get();
        }
        WishList wishList = new WishList();
        wishList.setUser(user);
        wishList.setProduct(product);
        return wishListRepository.save(wishList);
    }

    public void removeFromWishList(Integer integer, Long id) {
        wishListRepository.deleteById(id);
    }

    public WishList findByUserAndProduct(User user, Product product) {
        return wishListRepository.findByUserIdAndProductId(user.getId(), product.getId()).orElse(null);
    }
}