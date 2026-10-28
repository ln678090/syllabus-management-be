package syllabus.management.system.auth.login.service;

import lombok.RequiredArgsConstructor;

import java.util.UUID;

import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.stereotype.Service;

import syllabus.management.system.auth.login.dto.AuthTokens;
import syllabus.management.system.auth.login.dto.LoginReq;
import syllabus.management.system.auth.security.principal.CustomUserDetails;
import syllabus.management.system.auth.user.service.CustomUserDetailsService;
import syllabus.management.system.auth.security.config.jwt.RefreshTokenService;
import syllabus.management.system.auth.security.config.jwt.TokenService;

@Service
@RequiredArgsConstructor
public class LoginService {

  private final AuthenticationManager authenticationManager;
  private final TokenService tokenService;
  private final RefreshTokenService refreshTokenService;
  private final CustomUserDetailsService customUserDetailsService;

  public AuthTokens login(LoginReq req) {

    var auth = authenticationManager.authenticate(
        UsernamePasswordAuthenticationToken.unauthenticated(
            req.login(),
            req.password()));

    var user = (CustomUserDetails) auth.getPrincipal();

    String accessToken = tokenService.generateAccessToken(
        user.id(),
        user.getAuthorities());

    String refreshToken = refreshTokenService.create(user.id());

    return new AuthTokens(accessToken, refreshToken);
  }

  public AuthTokens refresh(String refreshToken) {
    UUID userId = refreshTokenService.getUserId(refreshToken);

    CustomUserDetails principal = customUserDetailsService.loadById(userId);

    String newAccessToken = tokenService.generateAccessToken(
        principal.id(),
        principal.getAuthorities());

    String newRefreshToken = refreshTokenService.rotate(refreshToken);

    return new AuthTokens(newAccessToken, newRefreshToken);
  }

  public void logout(String refreshToken) {
    refreshTokenService.revoke(refreshToken);
  }
}
