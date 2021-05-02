/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.service;

import com.mycompany.dao.UserRepository;
import com.mycompany.exception.UpdatePasswordFail;
import com.mycompany.model.CustomerUser;
import java.io.IOException;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author 路過
 */
//Update User Information Use
@Service
public class InformationImpl implements InformationService {

    @Resource
    private UserRepository userRepo;

//    @Override
//    @Transactional
//    public CustomerUser getDetails() {
//        return userRepo.findAll();
//    }
    @Override
    @Transactional
    public CustomerUser getDetail(String username) {
        return userRepo.findById(username).orElse(null);
    }

    //Saving updated information to databas (not yet process)
    @Override
    @Transactional(rollbackFor = UpdatePasswordFail.class)
    public void updateUser(String username, String password,
            String fullname, String phone, String address)
            throws IOException, UpdatePasswordFail {
        CustomerUser updatedUser = userRepo.findById(username).orElse(null);

        if (password != "") {
            password = "{noop}" + password;
        }
        updatedUser.setPassword(password);
        updatedUser.setUsername(username);
        updatedUser.setPhone(phone);
        updatedUser.setAddress(address);
        updatedUser.setFullname(fullname);

//        for (MultipartFile filePart : attachments) {
//            Attachment attachment = new Attachment();
//            attachment.setName(filePart.getOriginalFilename());
//            attachment.setMimeContentType(filePart.getContentType());
//            attachment.setContents(filePart.getBytes());
//            attachment.setTicket(updatedTicket);
//            if (attachment.getName() != null && attachment.getName().length() > 0
//                    && attachment.getContents() != null
//                    && attachment.getContents().length > 0) {
//                updatedTicket.getAttachments().add(attachment);
//            }
//        }
        userRepo.save(updatedUser);
    }

}
