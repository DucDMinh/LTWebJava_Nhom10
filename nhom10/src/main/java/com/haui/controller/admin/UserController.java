package com.haui.controller.admin;

import java.io.File;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.security.crypto.password.PasswordEncoder;

import com.haui.model.Role;
import com.haui.model.User;
import com.haui.service.RoleService;
import com.haui.service.UploadService;
import com.haui.service.UserService;
import com.haui.service.specification.UserSpec;

import jakarta.servlet.ServletContext;
import jakarta.validation.Valid;

@Controller
@RequestMapping("/admin/users")
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private UploadService uploadService;

    @Autowired
    private PasswordEncoder PasswordEncoder;

    @Autowired
    private RoleService roleService;

    @Autowired
    private ServletContext servletContext;

    @GetMapping
    public String userPage(Model model,
            @RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "name", required = false) String name) {

        Pageable pageable = PageRequest.of(page - 1, 5, Sort.by("id").descending());
        Page<User> userPages;

        if (name != null && !name.isEmpty()) {
            userPages = userService.findAll(UserSpec.searchUserByName(name), pageable);
            model.addAttribute("nameSearch", name);
        } else {
            userPages = userService.findAll(pageable);
        }

        List<User> userList = userPages.getContent();
        List<User> users = userList.stream().collect(Collectors.toList());

        model.addAttribute("users", users);
        model.addAttribute("currentPage", page);

        int totalPages = userPages.getTotalPages();
        if (totalPages == 0) {
            totalPages = 1;
        }
        model.addAttribute("totalPages", totalPages);

        return "admin/users/user";
    }

    @GetMapping("/creates")
    public String userCreateForm(Model model) {
        User user = new User();
        model.addAttribute("newUser", user);
        return "admin/users/create";
    }

    @PostMapping("/create")
    public String createUser(@ModelAttribute("newUser") @Valid User newUser,
            BindingResult bindingResult,
            @RequestParam("nhatminhFile") MultipartFile file) {
        List<FieldError> errors = bindingResult.getFieldErrors();
        for (FieldError error : errors) {
            System.out.println(error.getField() + " - " + error.getDefaultMessage());
        }

        if (bindingResult.hasErrors()) {
            return "admin/users/create";
        }

        String avatar = this.uploadService.handleSaveUploadFile("user", file);
        String hashPassword = this.PasswordEncoder.encode(newUser.getPassword());
        User user = new User();
        user.setUsername(newUser.getUsername());
        user.setPassword(hashPassword);
        user.setAvatar(avatar);
        user.setEmail(newUser.getEmail());
        user.setAddress(newUser.getAddress());
        user.setPhone(newUser.getPhone());
        user.setFullName(newUser.getFullName());

        Role role = this.roleService.findById(newUser.getRole().getId());
        user.setRole(role);

        userService.save(user);
        return "redirect:/admin/users";
    }

    @GetMapping("/views/{id}")
    public String viewsPage(@PathVariable("id") long id, Model model) {
        User user = userService.findById(id);
        model.addAttribute("user", user);
        return "admin/users/view";
    }

    @GetMapping("/updates/{id}")
    public String updateUser(Model model, @PathVariable("id") long id) {
        User user = userService.findById(id);

        model.addAttribute("updateUser", user);
        return "admin/users/update";
    }

    @PostMapping("/update")
    public String updateUserForm(@ModelAttribute("updateUser") User updateUser,
            @RequestParam("nhatminhFile") MultipartFile file) {
        User user = userService.findById(updateUser.getId());
        if (user != null) {
            user.setPhone(updateUser.getPhone());
            user.setFullName(updateUser.getFullName());
            user.setAddress(updateUser.getAddress());

            if (file != null && !file.isEmpty()) {
                String avatar = this.uploadService.handleSaveUploadFile("user", file);
                if (user.getAvatar() != null && !user.getAvatar().isEmpty()) {
                    String path = this.servletContext.getRealPath("/resources/admin/images")
                            + "/user/" + user.getAvatar();
                    File avatarFile = new File(path);
                    if (avatarFile.exists()) {
                        avatarFile.delete();
                    }
                }
                user.setAvatar(avatar);
            }
            this.userService.save(user);
        }
        return "redirect:/admin/users";
    }

    @GetMapping("/deletes/{id}")
    public String deleteUser(@PathVariable("id") long id) {
        this.userService.delete(id);
        return "redirect:/admin/users";
    }
}
