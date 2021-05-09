/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.service;

import com.mycompany.exception.AttachmentNotFound;
import com.mycompany.model.Photo;
import java.io.IOException;
import java.util.List;
import org.springframework.web.multipart.MultipartFile;

/**
 *
 * @author 路過
 */
public interface AttachmentService {

    public Photo getAttachment(long item_id, String name);
    
    public void updateAttachment(long item_id,List<MultipartFile> attachments) throws IOException;
    
    public List<Photo> getAttachments(long item_id);
    
    public void deleteAttachment(long id) throws AttachmentNotFound;
    
    public void deleteAttachmentbyItemid(long itemid) throws AttachmentNotFound;
}

