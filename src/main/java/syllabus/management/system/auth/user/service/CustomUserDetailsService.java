package syllabus.management.system.auth.user.service;

import java.util.UUID;

import lombok.RequiredArgsConstructor;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import syllabus.management.system.auth.security.principal.CustomUserDetails;
import syllabus.management.system.auth.security.service.AuthAuthorityService;
import syllabus.management.system.auth.user.entity.User;
import syllabus.management.system.auth.user.repository.UserRepository;

@Service
@RequiredArgsConstructor
public class CustomUserDetailsService implements UserDetailsService {

  private final UserRepository userRepository;
  private final AuthAuthorityService authorityService;

  @Override
  @Transactional(readOnly = true)
  public UserDetails loadUserByUsername(String login) {
    User user = userRepository
        .findByEmailIgnoreCase(login)
        .or(() -> userRepository.findByUsernameIgnoreCase(login))
        .orElseThrow(() -> new UsernameNotFoundException("Account not found"));

    return toDetails(user);
  }

  @Transactional(readOnly = true)
  public CustomUserDetails loadById(UUID id) {
    User user = userRepository
        .findById(id)
        .orElseThrow(() -> new UsernameNotFoundException("Account not found"));

    return toDetails(user);
  }

  private CustomUserDetails toDetails(User user) {
    return new CustomUserDetails(
        user.getId(),
        user.getUsername(),
        user.getEmail(),
        user.getPasswordHash(),
        user.isActive(),
        authorityService.get(user.getId()));
  }
}
