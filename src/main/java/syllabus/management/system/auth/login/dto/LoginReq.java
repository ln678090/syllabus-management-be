package syllabus.management.system.auth.login.dto;

import jakarta.validation.constraints.NotBlank;

public record LoginReq(
    @NotBlank(message = "Login is required") String login,

    @NotBlank(message = "Password is required") String password) {
}
