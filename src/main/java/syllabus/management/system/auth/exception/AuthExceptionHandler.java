package syllabus.management.system.auth.exception;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.web.bind.MissingRequestCookieException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import syllabus.management.system.common.resp.ApiResp;

@RestControllerAdvice
public class AuthExceptionHandler {

  @ExceptionHandler(BadCredentialsException.class)
  public ResponseEntity<ApiResp<Void>> handleBadCredentials() {
    return ResponseEntity
        .status(HttpStatus.UNAUTHORIZED)
        .body(ApiResp.error("Invalid credentials"));
  }

  @ExceptionHandler(InvalidRefreshTokenException.class)
  public ResponseEntity<ApiResp<Void>> handleInvalidRefreshToken(
      InvalidRefreshTokenException ex) {

    return ResponseEntity
        .status(HttpStatus.UNAUTHORIZED)
        .body(ApiResp.error(ex.getMessage()));
  }

  @ExceptionHandler(MissingRequestCookieException.class)
  public ResponseEntity<ApiResp<Void>> handleMissingRequestCookie(
      MissingRequestCookieException ex) {

    return ResponseEntity
        .status(HttpStatus.UNAUTHORIZED)
        .body(
            ApiResp.error(
                "Refresh token is missing"));
  }

  @ExceptionHandler(AccessDeniedException.class)
  public ResponseEntity<ApiResp<Void>> handleAccessDenied(
      AccessDeniedException ex) {

    return ResponseEntity
        .status(HttpStatus.FORBIDDEN)
        .body(ApiResp.error("Access denied"));
  }
}
