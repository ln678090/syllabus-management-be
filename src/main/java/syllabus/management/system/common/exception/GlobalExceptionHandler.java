package syllabus.management.system.common.exception;

import java.util.Map;
import java.util.stream.Collectors;

import lombok.extern.slf4j.Slf4j;
import syllabus.management.system.common.resp.ApiResp;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@Slf4j
@RestControllerAdvice
public class GlobalExceptionHandler {

  @ExceptionHandler(MethodArgumentNotValidException.class)
  public ResponseEntity<ApiResp<Map<String, String>>> handleValidation(
      MethodArgumentNotValidException ex) {

    Map<String, String> errors = ex.getBindingResult().getFieldErrors().stream()
        .collect(
            Collectors.toMap(
                error -> error.getField(),
                error -> error.getDefaultMessage() != null
                    ? error.getDefaultMessage()
                    : "Invalid value",
                (first, ignored) -> first));

    return ResponseEntity.badRequest()
        .body(ApiResp.error("Validation failed", errors));
  }

  @ExceptionHandler(IllegalArgumentException.class)
  public ResponseEntity<ApiResp<Void>> handleBadRequest(
      IllegalArgumentException ex) {

    return ResponseEntity.badRequest()
        .body(ApiResp.error(ex.getMessage()));
  }

  @ExceptionHandler(Exception.class)
  public ResponseEntity<ApiResp<Void>> handleUnexpected(Exception ex) {

    log.error("Unexpected error", ex);

    return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
        .body(ApiResp.error("Internal server error"));
  }

}
