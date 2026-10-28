# Syllabus Management Backend

Backend quản lý Syllabus, học liệu, chuẩn đầu ra và quy trình học thuật.

## 1. Công nghệ sử dụng

- Java 25
- Spring Boot 4.1.2
- Gradle Wrapper, Kotlin DSL (`build.gradle.kts`)
- PostgreSQL 17
- Redis 7
- Flyway
- Spring Data JPA / Hibernate
- Spring Security OAuth2 Resource Server
- Spotless

> Dự án đã có Gradle Wrapper nên không bắt buộc cài Gradle toàn cục. Hãy ưu tiên `./gradlew` (Linux/macOS) hoặc `gradlew.bat` (Windows).

## 2. Chuẩn bị sau khi clone

```bash
git clone <repository-url>
cd syllabus-be
```

Kiểm tra Java:

```bash
java --version
javac --version
```

Yêu cầu của dự án: **JDK 25**.

Kiểm tra Gradle Wrapper:

### Linux / macOS

```bash
chmod +x gradlew
./gradlew --version
```

### Windows PowerShell

```powershell
.\gradlew.bat --version
```

## 3. Cài JDK 25

### CachyOS / Arch Linux

```bash
sudo pacman -S jdk25-openjdk
archlinux-java status
sudo archlinux-java set java-25-openjdk
source /etc/profile
java --version
```

Nếu đã từng chạy Gradle bằng JDK khác:

```bash
./gradlew --stop
./gradlew --version
```

### Ubuntu / Debian

Cài một bản phân phối JDK 25 phù hợp với máy, sau đó kiểm tra:

```bash
java --version
javac --version
```

### macOS

Có thể dùng Homebrew hoặc một bản phân phối JDK 25 khác. Sau khi cài:

```bash
java --version
javac --version
```

### Windows

Cài JDK 25, cấu hình `JAVA_HOME` và thêm `%JAVA_HOME%\bin` vào `PATH`, sau đó mở terminal mới:

```powershell
java --version
javac --version
```

## 4. PostgreSQL và Redis bằng Docker

Khuyến nghị dùng Docker để cả nhóm có môi trường gần giống nhau.

Kiểm tra Docker:

```bash
docker --version
docker ps
```

### PostgreSQL 17

```bash
docker run -d \
  --name syllabus-postgres \
  -e POSTGRES_DB=syllabus_management \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_PASSWORD=123456789 \
  -p 5432:5432 \
  -v syllabus_postgres_data:/var/lib/postgresql/data \
  postgres:17
```

### Redis 7

Local development đơn giản:

```bash
docker run -d \
  --name syllabus-redis \
  -p 6379:6379 \
  redis:7-alpine
```

Kiểm tra:

```bash
docker ps
```

Khởi động lại sau khi đã tạo container:

```bash
docker start syllabus-postgres syllabus-redis
```

Dừng:

```bash
docker stop syllabus-postgres syllabus-redis
```

> Không expose Redis không mật khẩu ra Internet. Cấu hình trên dành cho máy local.

## 5. Cấu hình `.env`

Repository chỉ nên chứa file mẫu `.env.example`. Sau khi clone:

### Linux / macOS / Git Bash / WSL

```bash
cp .env.example .env
```

### Windows PowerShell

```powershell
Copy-Item .env.example .env
```

Ví dụ `.env` cho local:

```properties
# ===== Application =====
SPRING_PROFILES_ACTIVE=dev
SERVER_PORT=8080

# ===== PostgreSQL =====
DB_URL=jdbc:postgresql://localhost:5432/syllabus_management
DB_USERNAME=postgres
DB_PASSWORD=123456789

# ===== Redis =====
REDIS_HOST=localhost
REDIS_PORT=6379
REDIS_USERNAME=default
REDIS_PASSWORD=
REDIS_DATABASE=0

# ===== JWT =====
JWT_ACCESS_EXPIRATION=900000
JWT_REFRESH_EXPIRATION=2592000000

# ===== RSA Keys =====
RSA_PUBLIC_KEY=classpath:keys/public.pem
RSA_PRIVATE_KEY=classpath:keys/private.pem

# ===== CORS =====
CORS_ALLOWED_ORIGINS=http://localhost:3000
```

`application.yaml` cần import file này, ví dụ:

```yaml
spring:
  config:
    import: optional:file:.env[.properties]
```

### Không commit secret

`.gitignore` nên có:

```gitignore
.env
.env.*
!.env.example

src/main/resources/keys/private.pem
src/main/resources/keys/public.pem
```

Mỗi thành viên tự tạo RSA key pair local.

## 6. Tạo RSA key pair

### Linux / macOS / Git Bash / WSL

```bash
mkdir -p src/main/resources/keys

openssl genpkey \
  -algorithm RSA \
  -out src/main/resources/keys/private.pem \
  -pkeyopt rsa_keygen_bits:3072

openssl pkey \
  -in src/main/resources/keys/private.pem \
  -pubout \
  -out src/main/resources/keys/public.pem
```

Linux/macOS nên hạn chế quyền đọc private key:

```bash
chmod 600 src/main/resources/keys/private.pem
```

### Windows PowerShell

Cài OpenSSL hoặc dùng OpenSSL trong Git Bash/WSL, sau đó chạy cùng hai lệnh OpenSSL ở trên.

Kiểm tra:

```bash
ls -la src/main/resources/keys
```

Cần có:

```text
private.pem
public.pem
```

Không commit hai key local này lên Git.

## 7. Flyway - lưu ý bắt buộc

Migration nằm tại:

```text
src/main/resources/db/migration/
```

Quy ước tên:

```text
VyyyyMMddHHmmssSSS__description.sql
```

Ví dụ:

```text
V20261028042411893__create_users.sql
```

Các nguyên tắc:

1. Mỗi Flyway version phải duy nhất.
2. Schema do Flyway quản lý; Hibernate chỉ `validate`.
3. UUID primary key do ứng dụng Java sinh UUIDv7; PostgreSQL không tự sinh UUID mặc định.
4. Khi migration đã được áp dụng vào database dùng chung, không sửa/xóa migration cũ. Muốn thay đổi schema, tạo migration mới.
5. Không chạy `ddl-auto=create` hoặc `ddl-auto=update` cho dự án này.

Sau khi Spring Boot khởi động, Flyway sẽ thực hiện các migration chưa chạy nếu Flyway đang được bật trong cấu hình.

Kiểm tra bằng PostgreSQL:

```sql
SELECT installed_rank, version, description, success
FROM flyway_schema_history
ORDER BY installed_rank;
```

## 8. Tạo file Flyway migration

Project có thể dùng script `migration.py` ở root:

### Linux / macOS

```bash
python3 migration.py "create ten bang"
```

### Windows

```powershell
python migration.py "create ten bang"
```

Script tạo file trong:

```text
src/main/resources/db/migration/
```

Không tự đặt lại version của migration đã được áp dụng vào database dùng chung.

## 9. Chạy dự án

Đảm bảo:

- JDK 25 hoạt động.
- PostgreSQL đang chạy.
- Redis đang chạy.
- `.env` đã được tạo.
- RSA key pair đã được tạo.

### Linux / macOS

```bash
./gradlew bootRun
```

### Windows

```powershell
.\gradlew.bat bootRun
```

Khi thấy log tương tự:

```text
Tomcat started on port 8080
Started ...Application
```

backend đã chạy. `bootRun` tiếp tục ở trạng thái EXECUTING vì server đang hoạt động. Dừng bằng `Ctrl+C`.

## 10. Các lệnh phát triển thường dùng

### Linux / macOS

```bash
# Kiểm tra format
./gradlew spotlessCheck

# Tự sửa format
./gradlew spotlessApply

# Test
./gradlew test

# Build sạch
./gradlew clean build

# Chạy backend
./gradlew bootRun
```

### Windows

```powershell
.\gradlew.bat spotlessCheck
.\gradlew.bat spotlessApply
.\gradlew.bat test
.\gradlew.bat clean build
.\gradlew.bat bootRun
```

## 11. CI/CD

Repository tách riêng:

```text
.github/workflows/ci-format.yml
.github/workflows/ci-db-validation.yml
```

- `ci-format.yml`: kiểm tra Spotless với JDK 25 và Gradle Wrapper.
- `ci-db-validation.yml`: dựng PostgreSQL trắng, kiểm tra tên/version migration, chạy Flyway migrate và validate.

Pull Request cần qua các check tương ứng trước khi merge.

## 12. Cấu trúc quan trọng

```text
syllabus-be/
├── .env.example
├── .gitignore
├── build.gradle.kts
├── settings.gradle.kts
├── gradlew
├── gradlew.bat
├── migration.py
├── .github/
│   └── workflows/
│       ├── ci-format.yml
│       └── ci-db-validation.yml
└── src/
    └── main/
        ├── java/
        └── resources/
            ├── application.yaml
            ├── application-dev.yaml
            ├── application-prod.yaml
            ├── keys/
            │   ├── private.pem   # local, khong commit
            │   └── public.pem    # local, khong commit
            └── db/
                └── migration/
```

## 13. Checklist sau khi clone

- [ ] Cài JDK 25 và xác nhận `java --version`.
- [ ] Chạy được Gradle Wrapper.
- [ ] Có Docker đang hoạt động.
- [ ] Tạo container `syllabus-postgres`.
- [ ] Tạo container `syllabus-redis`.
- [ ] Copy `.env.example` thành `.env`.
- [ ] Cập nhật thông tin PostgreSQL/Redis trong `.env`.
- [ ] Tạo `private.pem` và `public.pem` local.
- [ ] Chạy `./gradlew spotlessCheck`.
- [ ] Chạy `./gradlew test`.
- [ ] Chạy `./gradlew bootRun`.
- [ ] Kiểm tra Flyway không báo lỗi.

## 14. Lưu ý cho thành viên trong nhóm

- Không commit `.env`, password, private key hoặc credential thật.
- Không chia sẻ chung RSA private key local.
- Không chỉnh sửa migration Flyway đã chạy trên database dùng chung.
- Không để Hibernate tự thay đổi schema thay cho Flyway.
- Ưu tiên Gradle Wrapper của repository thay vì Gradle global.
- Nếu thay đổi schema, Pull Request phải qua DB validation CI.
