package syllabus.management.system.common.entity;

import java.util.UUID;

import io.github.robsonkades.uuidv7.UUIDv7;
import jakarta.persistence.Column;
import jakarta.persistence.Id;
import jakarta.persistence.MappedSuperclass;
import jakarta.persistence.PrePersist;
import lombok.Getter;

@Getter
@MappedSuperclass
public abstract class BaseIdEntity {

  @Id
  @Column(name = "id", nullable = false, updatable = false)
  private UUID id;

  @PrePersist
  protected void generateId() {
    if (id == null) {
      id = UUIDv7.randomUUID();
    }
  }
}
