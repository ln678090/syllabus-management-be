
package syllabus.management.system.auth.login.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import syllabus.management.system.common.resp.ApiResp;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.RequestMapping;

@RestController
@RequestMapping("/api/test")
public class TestController {

  // Chỉ cần đăng nhập
  @GetMapping
  public ResponseEntity<ApiResp<?>> test() {
    return ResponseEntity.ok(
        ApiResp.success(
            "Authenticated successfully",
            null));
  }

  // Chỉ PTCT
  @GetMapping("/ptct")
  @PreAuthorize("hasRole('PTCT')")
  public ResponseEntity<ApiResp<?>> ptctOnly() {
    return ResponseEntity.ok(
        ApiResp.success(
            "PTCT role accepted",
            null));
  }

  // Chỉ TEACHER
  @GetMapping("/teacher")
  @PreAuthorize("hasRole('TEACHER')")
  public ResponseEntity<ApiResp<?>> teacherOnly() {
    return ResponseEntity.ok(
        ApiResp.success(
            "TEACHER role accepted",
            null));
  }

  // Permission PLAN_MANAGE
  @GetMapping("/plan")
  @PreAuthorize("hasAuthority('PLAN_MANAGE')")
  public ResponseEntity<ApiResp<?>> planManage() {
    return ResponseEntity.ok(
        ApiResp.success(
            "PLAN_MANAGE permission accepted",
            null));
  }

  // Permission DEADLINE_MANAGE
  @GetMapping("/deadline")
  @PreAuthorize("hasAuthority('DEADLINE_MANAGE')")
  public ResponseEntity<ApiResp<?>> deadlineManage() {
    return ResponseEntity.ok(
        ApiResp.success(
            "DEADLINE_MANAGE permission accepted",
            null));
  }

  // Permission ACCEPTANCE_PERFORM
  @GetMapping("/acceptance")
  @PreAuthorize("hasAuthority('ACCEPTANCE_PERFORM')")
  public ResponseEntity<ApiResp<?>> acceptance() {
    return ResponseEntity.ok(
        ApiResp.success(
            "ACCEPTANCE_PERFORM permission accepted",
            null));
  }

  // Permission SYSTEM_CONFIGURE
  @GetMapping("/configure")
  @PreAuthorize("hasAuthority('SYSTEM_CONFIGURE')")
  public ResponseEntity<ApiResp<?>> configure() {
    return ResponseEntity.ok(
        ApiResp.success(
            "SYSTEM_CONFIGURE permission accepted",
            null));
  }
}
