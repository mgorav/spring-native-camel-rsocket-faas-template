package com.gonnect.faas.nativespringboot;

import function.RequestHandler;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
public class SpringBootNativeApp {

    public static void main(String[] args) {
        SpringApplication.run(SpringBootNativeApp.class, args);
    }

    @Bean
    RequestHandler getHandler() {
        return new RequestHandler();
    }
}
