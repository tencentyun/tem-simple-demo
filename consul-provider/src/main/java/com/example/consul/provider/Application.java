package com.example.consul.provider;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
@RestController
public class Application {
	@Value("${spring.application.name}")
	private String appName;

	@RequestMapping("/ping")
	public String ping() {
		return "pong from " + AppName.name(appName) + "\n";
	}

	public static void main(String[] args) {
		SpringApplication.run(Application.class, args);
	}

}
