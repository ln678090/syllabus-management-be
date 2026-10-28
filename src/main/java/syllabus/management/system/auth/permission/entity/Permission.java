package syllabus.management.system.auth.permission.entity;

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
@Table(name = "permissions")
public class Permission extends BaseEntity {

  @Column(name = "code", nullable = false, unique = true, length = 150)
  private String code;

  @Column(name = "name", nullable = false, length = 255)
  private String name;

  @Column(name = "description", length = 500)
  private String description;

  @Column(name = "is_active", nullable = false)
  private boolean active = true;
}
