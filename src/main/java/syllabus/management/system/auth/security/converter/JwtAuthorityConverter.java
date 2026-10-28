package syllabus.management.system.auth.security.converter;

import java.util.Collection;
import java.util.LinkedHashSet;
import java.util.List;

import org.springframework.core.convert.converter.Converter;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.stereotype.Component;

@Component
public class JwtAuthorityConverter
    implements Converter<Jwt, Collection<GrantedAuthority>> {

  private static final String ROLE_PREFIX = "ROLE_";

  @Override
  public Collection<GrantedAuthority> convert(Jwt jwt) {

    var result = new LinkedHashSet<GrantedAuthority>();

    List<String> roles = jwt.getClaimAsStringList("roles");

    if (roles != null) {
      roles.stream()
          .map(role -> ROLE_PREFIX + role)
          .map(SimpleGrantedAuthority::new)
          .forEach(result::add);
    }

    List<String> permissions = jwt.getClaimAsStringList("permissions");

    if (permissions != null) {
      permissions.stream()
          .map(SimpleGrantedAuthority::new)
          .forEach(result::add);
    }

    return result;
  }
}
