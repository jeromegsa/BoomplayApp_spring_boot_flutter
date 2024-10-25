package com.winner.boomplay.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        // Chemin pour les fichiers audio
        registry.addResourceHandler("/musics/**")
                .addResourceLocations("file:C:/Users/beni.sonkpian/Documents/BoomplayApp_spring_boot_flutter/boomplay/src/uploads/music/");

        // Chemin pour les images de musique
        registry.addResourceHandler("/musics/images/**")
                .addResourceLocations("file:C:/Users/beni.sonkpian/Documents/BoomplayApp_spring_boot_flutter/boomplay/src/uploads/music/images/");

        // Chemin pour les vidéos
        registry.addResourceHandler("/videos/files/**")
                .addResourceLocations("file:C:/Users/beni.sonkpian/Documents/BoomplayApp_spring_boot_flutter/boomplay/src/uploads/videos/");
    }

    @Bean
    public WebMvcConfigurer corsConfigurer() {
        return new WebMvcConfigurer() {
            @Override
            public void addCorsMappings(CorsRegistry registry) {
                registry.addMapping("/musics/**") // Appliquer CORS aux fichiers musicaux
                        .allowedOrigins("*") // Remplacez par l'origine de votre application Flutter
                        .allowedMethods("GET", "POST", "PUT", "DELETE")
                        .allowedHeaders("*")
                        .allowCredentials(false);
                
                registry.addMapping("/videos/**") // Appliquer CORS aux fichiers vidéo
                        .allowedOrigins("*") // Remplacez par l'origine de votre application Flutter
                        .allowedMethods("GET", "POST", "PUT", "DELETE")
                        .allowedHeaders("*")
                        .allowCredentials(false);
            }
        };
    }
}
