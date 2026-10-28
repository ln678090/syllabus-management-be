package syllabus.management.system.auth.role.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.PrePersist;
import jakarta.persistence.Table;
import java.time.Instant;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import syllabus.management.system.auth.permission.entity.Permission;
import syllabus.management.system.common.entity.BaseIdEntity;

@Getter
@Setter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Entity
@Table(name = "role_permissions")
public class RolePermission extends BaseIdEntity {

  @ManyToOne(fetch = FetchType.LAZY, optional = false)
  @JoinColumn(name = "role_id", nullable = false)
  private Role role;

  @ManyToOne(fetch = FetchType.LAZY, optional = false)
  @JoinColumn(name = "permission_id", nullable = false)
  private Permission permission;

  @Column(name = "assigned_at", nullable = false, updatable = false)
  private Instant assignedAt;

  @PrePersist
  protected void initializeAssignedAt() {
    if (assignedAt == null) {
      assignedAt = Instant.now();
    }
  }
}
