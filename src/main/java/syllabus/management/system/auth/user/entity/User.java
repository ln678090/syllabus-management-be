package syllabus.management.system.auth.user.entity;

import java.time.Instant;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import syllabus.management.system.common.entity.BaseEntity;

@Getter
@Setter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Entity
@Table(name = "users")
public class User extends BaseEntity {

  @Column(name = "username", nullable = false, unique = true, length = 100)
  private String username;

  @Column(name = "email", nullable = false, unique = true, length = 255)
  private String email;

  @Column(name = "password_hash", nullable = false, length = 255)
  private String passwordHash;

  @Column(name = "is_active", nullable = false)
  private boolean active = true;

  @Column(name = "last_login_at")
  private Instant lastLoginAt;

  public User(
      String username,
      String email,
      String passwordHash) {
    this.username = username;
    this.email = email;
    this.passwordHash = passwordHash;
    this.active = true;
  }
}
