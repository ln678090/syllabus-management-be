package syllabus.management.system.auth.security.config.jwt;

import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.oauth2.jwt.JwtDecoder;
import org.springframework.security.oauth2.jwt.JwtEncoder;
import org.springframework.security.oauth2.jwt.NimbusJwtDecoder;
import org.springframework.security.oauth2.jwt.NimbusJwtEncoder;

import syllabus.management.system.auth.security.properties.RsaKeyProperties;

@Configuration
@EnableConfigurationProperties(RsaKeyProperties.class)
public class JwtConfig {

  @Bean
  public JwtEncoder jwtEncoder(RsaKeyProperties rsaKeys) {
    return NimbusJwtEncoder
        .withKeyPair(rsaKeys.publicKey(), rsaKeys.privateKey())
        .build();
  }

  @Bean
  public JwtDecoder jwtDecoder(RsaKeyProperties rsaKeys) {
    return NimbusJwtDecoder
        .withPublicKey(rsaKeys.publicKey())
        .build();
  }
}
