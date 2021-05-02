/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.dao;

import com.mycompany.model.Photo;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 *
 * @author 路過
 */
public interface AttachmentRepository extends JpaRepository<Photo, Long> {

    public Photo findByItemIdAndName(long itemId, String name);
    
    public List<Photo> findAllByItemId(long itemId);
}
