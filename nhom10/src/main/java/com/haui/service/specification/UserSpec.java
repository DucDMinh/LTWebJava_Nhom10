package com.haui.service.specification;

import com.haui.model.User;

import org.springframework.data.jpa.domain.Specification;

public class UserSpec {

    public static Specification<User> searchUserByName(String name) {
        return (root, query, criteriaBuilder) -> {
            if (name == null || name.isEmpty()) {
                return criteriaBuilder.conjunction();
            }
            
            // SỬA Ở ĐÂY: Dùng chuỗi "fullName" thay vì User_.fullName
            // Lưu ý: "fullName" phải viết đúng y hệt tên biến trong class User.java
            return criteriaBuilder.like(
                    criteriaBuilder.lower(root.get("fullName")),
                    "%" + name.toLowerCase() + "%");
        };
    }
}
