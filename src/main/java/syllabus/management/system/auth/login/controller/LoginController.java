package syllabus.management.system.auth.login.controller;

import java.time.Duration;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;

import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseCookie;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import syllabus.management.system.auth.login.dto.LoginReq;
import syllabus.management.system.auth.login.dto.LoginResp;
import syllabus.management.system.auth.login.service.LoginService;
import syllabus.management.system.common.resp.ApiResp;

@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
public class LoginController {

  private final LoginService loginService;

  @PostMapping("/login")
  public ResponseEntity<ApiResp<LoginResp>> login(
      @Valid @RequestBody LoginReq req) {

    var tokens = loginService.login(req);

    var cookie = refreshCookie(tokens.refreshToken());

    return ResponseEntity.ok()
        .header(HttpHeaders.SET_COOKIE, cookie.toString())
        .body(
            ApiResp.success(
                "Login successful",
                new LoginResp(tokens.accessToken())));
  }

  @PostMapping("/refresh")
  public ResponseEntity<ApiResp<LoginResp>> refresh(
      @CookieValue(name = "refresh_token") String refreshToken) {

    var tokens = loginService.refresh(refreshToken);

    var cookie = refreshCookie(tokens.refreshToken());
    return ResponseEntity.ok()
        .header(HttpHeaders.SET_COOKIE, cookie.toString())
        .body(
            ApiResp.success(
                "Token refreshed",
                new LoginResp(tokens.accessToken())));
  }

  @PostMapping("/logout")
  public ResponseEntity<ApiResp<Void>> logout(
      @CookieValue(name = "refresh_token", required = false) String refreshToken) {

    if (refreshToken != null) {
      loginService.logout(refreshToken);
    }

    var cookie = ResponseCookie.from("refresh_token", "")
        .httpOnly(true)
        .secure(false)
        .sameSite("Lax")
        .path("/api/auth")
        .maxAge(Duration.ZERO)
        .build();

    return ResponseEntity.ok()
        .header(HttpHeaders.SET_COOKIE, cookie.toString())
        .body(ApiResp.success("Logout successful", null));
  }

  private ResponseCookie refreshCookie(String token) {
    return ResponseCookie.from("refresh_token", token)
        .httpOnly(true)
        .secure(false)
        .sameSite("Lax")
        .path("/api/auth")
        .maxAge(Duration.ofDays(30))
        .build();
  }
}
