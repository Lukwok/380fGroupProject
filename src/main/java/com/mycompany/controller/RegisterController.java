/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.controller;

import javax.annotation.Resource;

import com.mycompany.dao.UserRepository;
import com.mycompany.exception.UpdatePasswordFail;
import com.mycompany.model.CustomerUser;
import com.mycompany.model.Photo;
import com.mycompany.service.AttachmentService;
import com.mycompany.service.InformationService;
import com.mycompany.view.DownloadingView;
import java.io.IOException;
import java.security.Principal;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.view.RedirectView;

/**
 *
 * @author 路過
 */
@Controller
@RequestMapping("/reg")
public class RegisterController {

    public RegisterController() {
    }
    
    @Autowired
     private InformationService informationService;
    @Autowired
    private AttachmentService attachmentService;

    @Resource
    UserRepository userRepo;

    public static class Form {

        private String username;
        private String password;
        private String[] roles;
        private String phone;
        private String fullname;
        private String  address;
        private String oldpassword;

        public String getUsername() {
            return username;
        }

        public void setUsername(String username) {
            this.username = username;
        }

        public String getPassword() {
            return password;
        }

        public void setPassword(String password) {
            this.password = password;
        }

        public String[] getRoles() {
            return roles;
        }

        public void setRoles(String[] roles) {
            this.roles = roles;
        }

        public String getPhone() {
            return phone;
        }

        public void setPhone(String phone) {
            this.phone = phone;
        }

        public String getFullname() {
            return fullname;
        }

        public void setFullname(String fullname) {
            this.fullname = fullname;
        }

        public String getAddress() {
            return address;
        }

        public void setAddress(String address) {
            this.address = address;
        }

        public String getOldpassword() {
            return oldpassword;
        }

        public void setOldpassword(String oldpassword) {
            this.oldpassword = oldpassword;
        }

        

    }

    @GetMapping(value = {"", "/logon"})
    public ModelAndView create() {
//        return "logon";
        return new ModelAndView("logon", "user", new Form());
    }
    
       @PostMapping("/logon")
        public View create(Form form) throws IOException {
            CustomerUser user = new CustomerUser(form.getUsername(),
                    form.getPassword(), form.getRoles(),
                    form.getFullname(), form.getPhone(),form.getAddress()
            );
            userRepo.save(user);
            return new RedirectView("/reg/success", true);
        }
        
        @GetMapping("/success")
        public String createSuccess(){
            return("aftercreate");
        }
        
        @GetMapping("/edit")
        public ModelAndView showEdit(
                Form form, Principal principal, HttpServletRequest request){
                
                CustomerUser user = informationService.getDetail(principal.getName());
                ModelAndView modelAndView = new ModelAndView("edit");
                modelAndView.addObject("user",user);

                Form userForm = new Form();
                userForm.setUsername(user.getUsername());
                userForm.setPhone(user.getPhone());
                userForm.setFullname(user.getFullname());
                userForm.setAddress(user.getAddress());
                modelAndView.addObject("userForm", userForm);

                return modelAndView;
    }
        
    //continue the PostMapping("/edit") for saving the updated information
    @PostMapping("/edit")
    public String edit(Form form,
            Principal principal, HttpServletRequest request)
            throws IOException, UpdatePasswordFail {
        CustomerUser user = informationService.getDetail(principal.getName());
        
        this.informationService.updateUser(form.getUsername(), form.getPassword(),
                form.getFullname(), form.getPhone(), form.getAddress());
        
        return "redirect:/reg/edit";
    }
        
        
     //not done yet   
    @GetMapping("/{ticketId}/attachment/{attachment:.+}")
    public View download(@PathVariable("ticketId") long ticketId,
            @PathVariable("attachment") String name) {
        Photo attachment = attachmentService.getAttachment(ticketId, name);
        if (attachment != null) {
            return new DownloadingView(attachment.getName(),
                    attachment.getMimeContentType(), attachment.getContents());
        }
        return new RedirectView("/system/detail", true);
    }
    
    @GetMapping({"", "/manage"})
        public String list(ModelMap model) {
        model.addAttribute("users", userRepo.findAll());
        return "userlist";
       }
        
    @GetMapping("/manage/delete/{username}")
    public RedirectView deleteTicket(@PathVariable("username") String username) {
       userRepo.delete(userRepo.findById(username).orElse(null));
        return new RedirectView("/reg/manage", true);
    }
    
    @GetMapping("/manage/edituser/{username}")    
    public ModelAndView showEdituser(
                Form form, HttpServletRequest request,@PathVariable("username") String username){
                CustomerUser user = userRepo.findById(username).orElse(null);
                ModelAndView modelAndView = new ModelAndView("edituser");
                modelAndView.addObject("user",user);

                Form userForm = new Form();
                userForm.setUsername(user.getUsername());
                userForm.setPhone(user.getPhone());
                userForm.setFullname(user.getFullname());
                userForm.setAddress(user.getAddress());
                modelAndView.addObject("userForm", userForm);

                return modelAndView;
    }
//    @PostMapping("/manage/edituser/{username}")
//    public String edituser(Form form, HttpServletRequest request,@PathVariable("username") String username)
//            throws IOException, UpdatePasswordFail {
//        userRepo.update("update USERS set username = ?,password = ?,fullname = ?,phone= ?,address= ? where username = ?;",form.getUsername(), form.getPassword(),
//                form.getFullname(), form.getPhone(), form.getAddress(),username);
//        
//        
//        return "redirect:/reg/manage";
//    }
   @PostMapping("/manage/edituser/{username}")
    public String edituser(Form form, HttpServletRequest request,@PathVariable("username") String username)
            throws IOException, UpdatePasswordFail {
        CustomerUser user = informationService.getDetail(username);
        
        this.informationService.updateUser(form.getUsername(), form.getPassword(),
                form.getFullname(), form.getPhone(), form.getAddress());
        
        return "redirect:/reg/manage";
    } 
}


