package syllabus.management.system.auth.security.config.jwt;

import java.time.Duration;
import java.util.UUID;

import lombok.RequiredArgsConstructor;
import syllabus.management.system.auth.security.properties.JwtProperties;

import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class RefreshTokenService {

  private static final String KEY_PREFIX = "auth:refresh:";

  private final StringRedisTemplate redisTemplate;
  private final JwtProperties jwtProperties;

  public String create(UUID userId) {

    String token = UUID.randomUUID().toString();
    String key = key(token);

    redisTemplate
        .opsForValue()
        .set(
            key,
            userId.toString(),
            Duration.ofMillis(jwtProperties.refreshExpiration()));

    return token;
  }

  public boolean exists(String token) {
    return Boolean.TRUE.equals(redisTemplate.hasKey(key(token)));
  }

  public UUID getUserId(String token) {

    String value = redisTemplate.opsForValue().get(key(token));

    if (value == null)
      throw new IllegalArgumentException("Invalid or expired refresh token");
    return UUID.fromString(value);
  }

  public void revoke(String token) {
    redisTemplate.delete(key(token));
  }

  private String key(String token) {
    return KEY_PREFIX + token;
  }

  public String rotate(String oldToken) {
    UUID userId = getUserId(oldToken);

    revoke(oldToken);

    return create(userId);
  }
}
