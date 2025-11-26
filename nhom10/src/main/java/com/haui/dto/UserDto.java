package com.haui.dto;

import com.haui.service.validator.RegisterChecked;
import lombok.*;

@Builder
@Data
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@RegisterChecked
public class UserDto {
    private String username;

    private String password;

    private String email;

    private String phone;
    private String address;
    private String fullName;
    private String confirmPassword;
}
