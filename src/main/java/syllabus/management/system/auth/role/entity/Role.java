package syllabus.management.system.auth.role.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import syllabus.management.system.common.entity.BaseEntity;

@Getter
@Setter
@NoArgsConstructor
@Entity
@Table(name = "roles")
public class Role extends BaseEntity {

  @Column(name = "code", nullable = false, unique = true, length = 100)
  private String code;

  @Column(name = "name", nullable = false, length = 150)
  private String name;

  @Column(name = "description", length = 500)
  private String description;

  @Column(name = "is_active", nullable = false)
  private boolean active = true;

}
