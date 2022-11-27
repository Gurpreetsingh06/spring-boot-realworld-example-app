package io.spring.api;

import io.spring.application.TagsQueryService;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(path = "health")
@AllArgsConstructor
public class HealthApi {

  @GetMapping
  public ResponseEntity getHealth() {
    return ResponseEntity.ok("OK");
  }
}
