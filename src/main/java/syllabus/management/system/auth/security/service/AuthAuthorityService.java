package syllabus.management.system.auth.security.service;

import java.util.LinkedHashSet;
import java.util.Set;
import java.util.UUID;

import lombok.RequiredArgsConstructor;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import syllabus.management.system.auth.role.repository.RolePermissionRepository;
import syllabus.management.system.auth.user.repository.UserRoleRepository;

@Service
@RequiredArgsConstructor
public class AuthAuthorityService {

  private final UserRoleRepository userRoleRepository;
  private final RolePermissionRepository rolePermissionRepository;

  @Transactional(readOnly = true)
  public Set<GrantedAuthority> get(UUID userId) {
    var roles = userRoleRepository.findAllByUserId(userId).stream()
        .map(it -> it.getRole())
        .filter(it -> it.isActive())
        .toList();

    var result = new LinkedHashSet<GrantedAuthority>();

    roles.stream()
        .map(it -> "ROLE_" + it.getCode())
        .map(SimpleGrantedAuthority::new)
        .forEach(result::add);

    var roleIds = roles.stream()
        .map(it -> it.getId())
        .toList();

    if (!roleIds.isEmpty()) {
      rolePermissionRepository.findAllByRoleIdIn(roleIds).stream()
          .map(it -> it.getPermission())
          .filter(it -> it.isActive())
          .map(it -> it.getCode())
          .map(SimpleGrantedAuthority::new)
          .forEach(result::add);
    }

    return result;
  }
}
