package syllabus.management.system.common.resp;

import java.time.Instant;

public record ApiResp<T>(
    String message,
    T data,
    Instant timestamp) {

  public static <T> ApiResp<T> success(String message, T data) {
    return new ApiResp<>(message, data, Instant.now());
  }

  public static <T> ApiResp<T> error(String message, T data) {
    return new ApiResp<>(message, data, Instant.now());
  }

  public static ApiResp<Void> error(String message) {
    return error(message, null);
  }
}
