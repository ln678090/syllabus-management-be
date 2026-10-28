package syllabus.management.system.auth.user.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToOne;
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
@Table(name = "user_profiles")
public class UserProfile extends BaseEntity {

  @OneToOne(fetch = FetchType.LAZY, optional = false)
  @JoinColumn(name = "user_id", nullable = false, unique = true)
  private User user;

  @Column(name = "full_name", nullable = false, length = 255)
  private String fullName;

  @Column(name = "phone", length = 20)
  private String phone;

  @Column(name = "avatar_url", length = 500)
  private String avatarUrl;

  public UserProfile(
      User user,
      String fullName,
      String phone,
      String avatarUrl) {
    this.user = user;
    this.fullName = fullName;
    this.phone = phone;
    this.avatarUrl = avatarUrl;
  }
}
