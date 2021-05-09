/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.service;

import com.mycompany.dao.AttachmentRepository;
import com.mycompany.exception.AttachmentNotFound;
import com.mycompany.model.Photo;
import java.io.IOException;
import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

/**
 *
 * @author 路過
 */
@Service
public class AttachmentServiceImpl implements AttachmentService {

    @Resource
    private AttachmentRepository attachmentRepo;
    
    @Override
    @Transactional
    public List<Photo> getAttachments(long item_id){
        return attachmentRepo.findAllByItemId(item_id);
    }

    @Override
    @Transactional
    public Photo getAttachment(long item_id, String name) {
        return attachmentRepo.findByItemIdAndName(item_id, name);
    }
    
    @Override
    @Transactional
    public void updateAttachment(long item_id,List<MultipartFile> attachments)
            throws IOException {
        for (MultipartFile filePart : attachments) {
            Photo attachment = new Photo();
            attachment.setName(filePart.getOriginalFilename());
            attachment.setMimeContentType(filePart.getContentType());
            attachment.setContents(filePart.getBytes());
            attachment.setItemId(item_id);
            if (attachment.getName() != null && attachment.getName().length() > 0
                    && attachment.getContents() != null
                    && attachment.getContents().length > 0) {
                attachmentRepo.save(attachment);
            }
        }
    }
    
    @Override
    @Transactional (rollbackFor = AttachmentNotFound.class)
    public void deleteAttachment(long id) throws AttachmentNotFound{
        Photo deletedImage = attachmentRepo.findById(id).orElse(null);
        if (deletedImage == null){
            throw new AttachmentNotFound();
        }
        attachmentRepo.delete(deletedImage);
    }
    
    @Override
    @Transactional (rollbackFor = AttachmentNotFound.class)
    public void deleteAttachmentbyItemid(long itemid) throws AttachmentNotFound{
        List<Photo> deletedImages = attachmentRepo. findAllByItemId(itemid);
        if (deletedImages == null){
            throw new AttachmentNotFound();
        }
        for (Photo image : deletedImages){
            attachmentRepo.delete(image);
        }
    }
}

