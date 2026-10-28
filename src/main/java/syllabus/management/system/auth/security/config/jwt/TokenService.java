package syllabus.management.system.auth.security.config.jwt;

import java.time.Duration;
import java.time.Instant;
import java.util.Collection;
import java.util.List;
import java.util.UUID;

import lombok.RequiredArgsConstructor;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.oauth2.jwt.JwtClaimsSet;
import org.springframework.security.oauth2.jwt.JwtEncoder;
import org.springframework.security.oauth2.jwt.JwtEncoderParameters;
import org.springframework.stereotype.Service;

import syllabus.management.system.auth.security.properties.JwtProperties;

@Service
@RequiredArgsConstructor
public class TokenService {

  private static final String ROLE_PREFIX = "ROLE_";

  private final JwtEncoder jwtEncoder;
  private final JwtProperties jwtProperties;

  public String generateAccessToken(
      UUID userId,
      Collection<? extends GrantedAuthority> authorities) {

    Instant now = Instant.now();

    Instant expiresAt = now.plus(
        Duration.ofMillis(jwtProperties.accessExpiration()));

    List<String> roles = authorities.stream()
        .map(GrantedAuthority::getAuthority)
        .filter(authority -> authority.startsWith(ROLE_PREFIX))
        .map(authority -> authority.substring(ROLE_PREFIX.length()))
        .distinct()
        .toList();

    List<String> permissions = authorities.stream()
        .map(GrantedAuthority::getAuthority)
        .filter(authority -> !authority.startsWith(ROLE_PREFIX))
        .distinct()
        .toList();

    JwtClaimsSet claims = JwtClaimsSet.builder()
        .issuer("syllabus-management")
        .issuedAt(now)
        .expiresAt(expiresAt)
        .subject(userId.toString())
        .claim("roles", roles)
        .claim("permissions", permissions)
        .build();

    return jwtEncoder
        .encode(JwtEncoderParameters.from(claims))
        .getTokenValue();
  }
}
