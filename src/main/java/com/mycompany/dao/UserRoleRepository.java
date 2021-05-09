/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import com.mycompany.model.UserRole;

/**
 *
 * @author 路過
 */
public interface UserRoleRepository extends JpaRepository<UserRole, Integer> {
}