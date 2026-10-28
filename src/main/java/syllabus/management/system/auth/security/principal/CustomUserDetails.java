package syllabus.management.system.auth.security.principal;

import java.util.Collection;
import java.util.UUID;
import java.util.List;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

public record CustomUserDetails(
    UUID id,
    String username,
    String email,
    String password,
    boolean enabled,
    Collection<? extends GrantedAuthority> authorities) implements UserDetails {

  public CustomUserDetails {
    authorities = authorities == null
        ? List.of()
        : List.copyOf(authorities);
  }

  @Override
  public Collection<? extends GrantedAuthority> getAuthorities() {
    return authorities;
  }

  @Override
  public String getPassword() {
    return password;
  }

  @Override
  public String getUsername() {
    return username;
  }

  @Override
  public boolean isEnabled() {
    return enabled;
  }
}
