package com.mycompany.controller;

import com.mycompany.exception.AttachmentNotFound;
import java.io.IOException;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.view.RedirectView;
import com.mycompany.model.Photo;
import com.mycompany.service.AttachmentService;
import com.mycompany.view.DownloadingView;
import java.security.Principal;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;

@Controller
@RequestMapping("/system")
public class SystemController {
    
    @Autowired
    private AttachmentService attachmentService;

    private boolean login = false;
    private final Map<Integer, String> products = new Hashtable<>();
    private String[][] itemdesciption = {{"0", "0", "0", "0"},
    {"Yummy chicken from USA", "$56", "Yes", ""},
    {"A meat generally sliced across the muscle fibers, potentially including a bone", "$80", "Yes", ""},
    {"A cheeseburger is a hamburger topped with cheese", "$50", "Yes", ""},
    {"Long thin pieces of fried potato fries", "$30", "Yes", ""},
    {"A food produced by bacterial fermentation of milk", "$10", "Yes", ""}};

    public SystemController() {
        products.put(1, "American Chicken");
        products.put(2, "Australia Steak");
        products.put(3, "Cheese Burger");
        products.put(4, "Fries");
        products.put(5, "Yogurt");
    }

    public static class Form {

        private String addComment;

        public String getAddComment() {
            return addComment;
        }

        public void setAddComment(String addComment) {
            this.addComment = addComment;
        }

       }
    
    public static class ItemForm {
        private String itemid;
        private List<MultipartFile> attachments;

        public String getItemid() {
            return itemid;
        }

        public void setItemid(String itemid) {
            this.itemid = itemid;
        }

        public List<MultipartFile> getAttachments() {
            return attachments;
        }

        public void setAttachments(List<MultipartFile> attachments) {
            this.attachments = attachments;
        }
        
        
    }


    @GetMapping(value = {"", "/index"})
    public String list(ModelMap model, HttpServletRequest request, HttpServletResponse response) throws IOException {
        String action = request.getParameter("action");
        if (action == null) {
            model.addAttribute("products", products);
            return "index";
        }

        switch (action) {
            case "addToCart":
                addToCart(request, response);
                break;
            case "viewCart":
                viewCart(model, request, response);
                break;
        }

        return "index";
    }

    @GetMapping(value = {"", "/setavailability"})
    public String Setavailability(ModelMap model, HttpServletRequest request, HttpServletResponse response) throws IOException {
        int productId;
        productId = Integer.parseInt(request.getParameter("productId"));
        String setavailability = request.getParameter("setavailability");
        if (setavailability != null) {
            if (setavailability.equals("Yes")) {
                itemdesciption[productId][2] = "Yes";
            } else {
                itemdesciption[productId][2] = "No";
            }

        }
        return "setavailability";
    }

    @GetMapping(value = {"", "/favouritepage"})
    public String Favouritepage(ModelMap model, HttpServletRequest request, HttpServletResponse response) throws IOException {

        String setfavourite = request.getParameter("setfavourite");
        if (setfavourite != null) {
            int productId;
            productId = Integer.parseInt(request.getParameter("productId"));
            HttpSession session = request.getSession();
            if (session.getAttribute("favourite") == null) {
                session.setAttribute("favourite", new Hashtable<>());
            }
            @SuppressWarnings("unchecked")
            Map<Integer, Integer> favourite
                    = (Map<Integer, Integer>) session.getAttribute("favourite");

            if (setfavourite != null) {
                if (setfavourite.equals("Add")) {
                    if (!favourite.containsKey(productId)) {
                        favourite.put(productId, productId);
                    }
                } else {
                    favourite.remove(productId, productId);
                }
            }
        }
        model.addAttribute("products", products);
        return "favouritepage";
    }

    @GetMapping(value = {"", "/item"})
    public ModelAndView Item(ModelMap model, HttpServletRequest request,
            HttpServletResponse response) throws IOException {
        int productId;
        productId = Integer.parseInt(request.getParameter("productId"));

        model.addAttribute("productId", productId);
        model.addAttribute("products", products);
        model.addAttribute("itemdesciption", itemdesciption);
        
        model.addAttribute("imageDatabase",attachmentService.getAttachments(new Long(productId)));

        return new ModelAndView("item", "commentForm", new Form());
    }

    @PostMapping(value = {"", "/item"})
    public ModelAndView newComment(Principal principal, ModelMap model, Form form,
            HttpServletRequest request, HttpServletResponse response) throws IOException {
        int productId;
        productId = Integer.parseInt(request.getParameter("productId"));

        if (form.getAddComment() != "") {
            itemdesciption[productId][3] = itemdesciption[productId][3]
                    + "<br/>" + principal.getName() + ": " + form.getAddComment();
            model.addAttribute("productId", productId);
            model.addAttribute("products", products);
            model.addAttribute("itemdesciption", itemdesciption);
        }

        return new ModelAndView("item", "commentForm", new Form());
    }

    @GetMapping(value = {"", "/viewcart"})
    public String viewCart(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
        String action1 = request.getParameter("action");
        if (action1 == null) {
            model.addAttribute("products", products);
            return "viewcart";
        }

        switch (action1) {
            case "checkout":
                return "checkout";
        }

        model.addAttribute("products", products);
        return "viewcart";
    }

    @GetMapping(value = {"", "/checkout"})
    public String checkout() {
        return "checkout";
    }

    @PostMapping(value = {"", "/checkout"})
    public String aftercheckout(HttpServletRequest request) {
        request.getSession().removeAttribute("cart");
        return "afterpayment";
    }

    private void addToCart(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int productId;
        productId = Integer.parseInt(request.getParameter("productId"));

        HttpSession session = request.getSession();
        if (session.getAttribute("cart") == null) {
            session.setAttribute("cart", new Hashtable<>());
        }

        @SuppressWarnings("unchecked")
        Map<Integer, Integer> cart
                = (Map<Integer, Integer>) session.getAttribute("cart");

        if (itemdesciption[productId][2] == "Yes") {
            if (!cart.containsKey(productId)) {
                cart.put(productId, 0);
            }
            cart.put(productId, cart.get(productId) + 1);
            response.sendRedirect("viewcart");
        } else {
            response.sendRedirect("viewcart");
        }
    }
    
      @GetMapping(value = {"", "/edit"})
    public ModelAndView edit(ModelMap model, HttpServletRequest request,
            HttpServletResponse response) throws IOException {
        int productId;
        productId = Integer.parseInt(request.getParameter("productId"));

        model.addAttribute("productId", productId);
        model.addAttribute("products", products);
        model.addAttribute("itemdesciption", itemdesciption);
        model.addAttribute("imageDatabase",attachmentService.getAttachments(new Long(productId)));
        return new ModelAndView("editItem", "attachmentForm", new ItemForm());
    }
    
    @PostMapping(value = {"", "/edit"})
    public String updateItem(Principal principal, ModelMap model, ItemForm form,
            HttpServletRequest request, HttpServletResponse response) throws IOException {
        long item_id = Long.parseLong(form.getItemid());
        attachmentService.updateAttachment(item_id, form.getAttachments());
        return "redirect:/system/edit?productId="+item_id;
    }
    
        @GetMapping(value = {"", "/edit/{itemId}/delete/{imageId}"})
        public String deleteImage(@PathVariable("imageId") long imageId, @PathVariable("itemId") long itemId) 
                    throws AttachmentNotFound {
        attachmentService.deleteAttachment(imageId);
        return "redirect:/system/edit?productId="+itemId;
    }
    
    @GetMapping("/item/{itemId}/attachment/{attachment:.+}")
    public View download(@PathVariable("itemId") long itemId,
            @PathVariable("attachment") String name) {
        Photo attachment = attachmentService.getAttachment(itemId, name);
        if (attachment != null) {
            return new DownloadingView(attachment.getName(),
                    attachment.getMimeContentType(), attachment.getContents());
        }
        return new RedirectView("/system/index", true);
    }

}
