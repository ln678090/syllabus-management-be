package syllabus.management.system.auth.user.repository;

import java.util.List;
import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;

import syllabus.management.system.auth.user.entity.UserRole;

public interface UserRoleRepository
    extends JpaRepository<UserRole, UUID> {

  List<UserRole> findAllByUserId(UUID userId);
}
