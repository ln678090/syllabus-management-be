package syllabus.management.system.auth.security.config;

import lombok.RequiredArgsConstructor;

import java.util.List;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.convert.converter.Converter;
import org.springframework.security.authentication.AbstractAuthenticationToken;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.argon2.Argon2PasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationToken;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

import syllabus.management.system.auth.security.converter.JwtAuthorityConverter;
import syllabus.management.system.auth.security.handler.AuthEntryPoint;

@Configuration
@EnableMethodSecurity
@RequiredArgsConstructor
public class SecurityConfig {
  @Value("${CORS_ALLOWED_ORIGINS:http://localhost:3000}")
  private String allowedOrigin;
  private final JwtAuthorityConverter jwtAuthorityConverter;
  private final AuthEntryPoint authEntryPoint;
  private final AccessDeniedHandler accessDeniedHandler;

  @Bean
  public SecurityFilterChain securityFilterChain(
      HttpSecurity http) throws Exception {

    return http
        .csrf(csrf -> csrf.disable()).cors(Customizer.withDefaults())

        .sessionManagement(
            session -> session.sessionCreationPolicy(
                SessionCreationPolicy.STATELESS))

        .authorizeHttpRequests(
            auth -> auth
                .requestMatchers("/error")
                .permitAll()

                .requestMatchers("/api/auth/**")
                .permitAll()

                .requestMatchers(
                    "/v3/api-docs/**",
                    "/swagger-ui/**",
                    "/swagger-ui.html")
                .permitAll()

                .anyRequest()
                .authenticated())

        .oauth2ResourceServer(
            oauth2 -> oauth2.jwt(
                jwt -> jwt.jwtAuthenticationConverter(
                    jwtAuthenticationConverter())))
        .exceptionHandling(
            ex -> ex
                .authenticationEntryPoint(authEntryPoint)
                .accessDeniedHandler(accessDeniedHandler))

        .build();
  }

  @Bean
  public Converter<Jwt, AbstractAuthenticationToken> jwtAuthenticationConverter() {

    return jwt -> new JwtAuthenticationToken(
        jwt,
        jwtAuthorityConverter.convert(jwt),
        jwt.getSubject());
  }

  @Bean
  public AuthenticationManager authenticationManager(
      AuthenticationConfiguration configuration)
      throws Exception {

    return configuration.getAuthenticationManager();
  }

  @Bean
  public PasswordEncoder passwordEncoder() {
    return Argon2PasswordEncoder.defaultsForSpringSecurity_v5_8();
  }

  @Bean
  CorsConfigurationSource corsConfigurationSource() {
    var config = new CorsConfiguration();

    config.setAllowedOrigins(List.of(allowedOrigin));
    config.setAllowedMethods(
        List.of("GET", "POST", "PUT", "PATCH", "DELETE", "OPTIONS"));
    config.setAllowedHeaders(List.of("*"));
    config.setAllowCredentials(true);

    var source = new UrlBasedCorsConfigurationSource();
    source.registerCorsConfiguration("/**", config);

    return source;
  }
}
