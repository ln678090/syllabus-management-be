package syllabus.management.system.auth.user.entity;

import java.time.Instant;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.PrePersist;
import jakarta.persistence.Table;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import syllabus.management.system.auth.role.entity.Role;
import syllabus.management.system.common.entity.BaseIdEntity;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Entity
@Table(name = "user_roles")
public class UserRole extends BaseIdEntity {

  @ManyToOne(fetch = FetchType.LAZY, optional = false)
  @JoinColumn(name = "user_id", nullable = false)
  private User user;

  @ManyToOne(fetch = FetchType.LAZY, optional = false)
  @JoinColumn(name = "role_id", nullable = false)
  private Role role;

  @Column(name = "assigned_at", nullable = false, updatable = false)
  private Instant assignedAt;

  public UserRole(User user, Role role) {
    this.user = user;
    this.role = role;
  }

  @PrePersist
  protected void initializeAssignedAt() {
    if (assignedAt == null) {
      assignedAt = Instant.now();
    }
  }
}
