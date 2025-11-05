package com.haui.service;

import com.haui.model.Role;
import com.haui.repository.RoleRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RoleService {
    @Autowired
    private RoleRepository roleRepository;

    public Role findByName(String name) {
        return roleRepository.findByName(name);
    }

    public Role findById(Integer id) {
        return roleRepository.findById(id).get();
    }
}
