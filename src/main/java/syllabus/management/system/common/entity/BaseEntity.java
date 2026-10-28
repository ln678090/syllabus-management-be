package syllabus.management.system.common.entity;

import java.time.Instant;

import jakarta.persistence.Column;
import jakarta.persistence.MappedSuperclass;
import jakarta.persistence.PrePersist;
import jakarta.persistence.PreUpdate;
import lombok.Getter;

@Getter
@MappedSuperclass
public abstract class BaseEntity extends BaseIdEntity {

  @Column(name = "created_at", nullable = false, updatable = false)
  private Instant createdAt;

  @Column(name = "updated_at", nullable = false)
  private Instant updatedAt;

  @PrePersist
  protected void initializeTimestamps() {
    Instant now = Instant.now();

    if (createdAt == null) {
      createdAt = now;
    }

    if (updatedAt == null) {
      updatedAt = now;
    }
  }

  @PreUpdate
  protected void updateTimestamp() {
    updatedAt = Instant.now();
  }
}
