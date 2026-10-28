package syllabus.management.system.auth.security.properties;

import org.springframework.boot.context.properties.ConfigurationProperties;

@ConfigurationProperties(prefix = "jwt")
public record JwtProperties(
    long accessExpiration,
    long refreshExpiration
) {}
