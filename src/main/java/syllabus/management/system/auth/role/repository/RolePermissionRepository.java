package syllabus.management.system.auth.role.repository;

import java.util.Collection;
import java.util.List;
import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;

import syllabus.management.system.auth.role.entity.RolePermission;

public interface RolePermissionRepository
    extends JpaRepository<RolePermission, UUID> {

  List<RolePermission> findAllByRoleIdIn(
      Collection<UUID> roleIds);
}
