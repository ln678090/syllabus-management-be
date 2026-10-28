package syllabus.management.system.auth.security.handler;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import lombok.RequiredArgsConstructor;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Component;
import syllabus.management.system.common.resp.ApiResp;
import tools.jackson.databind.ObjectMapper;

@Component
@RequiredArgsConstructor
public class AccessDeniedHandler
    implements org.springframework.security.web.access.AccessDeniedHandler {

  private final ObjectMapper objectMapper;

  @Override
  public void handle(
      HttpServletRequest request,
      HttpServletResponse response,
      org.springframework.security.access.AccessDeniedException ex)
      throws IOException {

    response.setStatus(HttpServletResponse.SC_FORBIDDEN);
    response.setContentType(MediaType.APPLICATION_JSON_VALUE);

    objectMapper.writeValue(
        response.getOutputStream(),
        ApiResp.error("Access denied"));
  }
}
