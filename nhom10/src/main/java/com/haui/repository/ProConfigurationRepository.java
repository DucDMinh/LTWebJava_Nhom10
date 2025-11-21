package com.haui.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.haui.model.ProConfiguration;

@Repository
public interface ProConfigurationRepository extends JpaRepository<ProConfiguration, Long> {

    List<ProConfiguration> findByProduct_Id(long productId);
}
