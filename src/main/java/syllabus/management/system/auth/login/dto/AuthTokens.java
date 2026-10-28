package syllabus.management.system.auth.login.dto;

public record AuthTokens(
    String accessToken,
    String refreshToken) {
}
