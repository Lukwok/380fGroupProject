/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.service;

import com.mycompany.exception.UpdatePasswordFail;
import com.mycompany.model.CustomerUser;
import java.io.IOException;

/**
 *
 * @author 路過
 */
//for update personal information use
public interface InformationService {

//    public CustomerUser getDetails();
    public CustomerUser getDetail(String username);

    public void updateUser(String username, String password,
            String fullname, String phone, String address)
            throws IOException, UpdatePasswordFail;

//    public void delete(long id) throws TicketNotFound;
//
//    public void deleteAttachment(long ticketId, String name)
//            throws AttachmentNotFound;
}
