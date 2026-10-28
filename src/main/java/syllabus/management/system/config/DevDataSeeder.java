package syllabus.management.system.config;

import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Profile;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import lombok.RequiredArgsConstructor;
import syllabus.management.system.auth.role.entity.Role;
import syllabus.management.system.auth.role.repository.RoleRepository;
import syllabus.management.system.auth.user.entity.User;
import syllabus.management.system.auth.user.entity.UserProfile;
import syllabus.management.system.auth.user.entity.UserRole;
import syllabus.management.system.auth.user.repository.UserProfileRepository;
import syllabus.management.system.auth.user.repository.UserRepository;
import syllabus.management.system.auth.user.repository.UserRoleRepository;

@Component
@Profile("dev")
@RequiredArgsConstructor
public class DevDataSeeder implements CommandLineRunner {

  private final UserRepository userRepository;
  private final UserProfileRepository userProfileRepository;
  private final RoleRepository roleRepository;
  private final UserRoleRepository userRoleRepository;
  private final PasswordEncoder passwordEncoder;

  private void seedPtct() {
    if (userRepository.existsByUsername("ptct.dev")) {
      return;
    }

    Role role = roleRepository.findByCode("PTCT")
        .orElseThrow(() -> new IllegalStateException(
            "Role PTCT has not been seeded"));

    User user = new User(
        "ptct.dev",
        "ptct.dev@example.local",
        passwordEncoder.encode("Dev@123456"));

    userRepository.save(user);

    UserProfile profile = new UserProfile(
        user,
        "PTCT Dev",
        null,
        null);

    userProfileRepository.save(profile);

    UserRole userRole = new UserRole(user, role);

    userRoleRepository.save(userRole);
  }

  private void seedTeacher(
      String username,
      String email,
      String fullName) {

    if (userRepository.existsByUsername(username)) {
      return;
    }

    Role role = roleRepository.findByCode("TEACHER")
        .orElseThrow(() -> new IllegalStateException(
            "Role TEACHER has not been seeded"));

    User user = new User(
        username,
        email,
        passwordEncoder.encode("Dev@123456"));

    userRepository.save(user);

    UserProfile profile = new UserProfile(
        user,
        fullName,
        null,
        null);

    userProfileRepository.save(profile);

    UserRole userRole = new UserRole(user, role);

    userRoleRepository.save(userRole);
  }

  @Override
  @Transactional
  public void run(String... args) {
    seedPtct();

    seedTeacher(
        "teacher01.dev",
        "teacher01.dev@example.local",
        "Teacher Dev 01");

    seedTeacher(
        "teacher02.dev",
        "teacher02.dev@example.local",
        "Teacher Dev 02");

    seedTeacher(
        "teacher03.dev",
        "teacher03.dev@example.local",
        "Teacher Dev 03");

    seedTeacher(
        "teacher04.dev",
        "teacher04.dev@example.local",
        "Teacher Dev 04");

    seedTeacher(
        "teacher05.dev",
        "teacher05.dev@example.local",
        "Teacher Dev 05");
  }
}
