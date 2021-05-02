/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import com.mycompany.model.CustomerUser;

/**
 *
 * @author 路過
 */
public interface UserRepository extends JpaRepository<CustomerUser, String> {
}
