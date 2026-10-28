package syllabus.management.system.auth.role.repository;

import java.util.Optional;
import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;

import syllabus.management.system.auth.role.entity.Role;

public interface RoleRepository extends JpaRepository<Role, UUID> {

  Optional<Role> findByCode(String code);
}
