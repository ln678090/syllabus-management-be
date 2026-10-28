package syllabus.management.system.auth.user.repository;

import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;

import syllabus.management.system.auth.user.entity.UserProfile;

public interface UserProfileRepository
    extends JpaRepository<UserProfile, UUID> {
}
