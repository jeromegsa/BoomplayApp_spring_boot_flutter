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
        // Servir les fichiers depuis le dossier local pour les musiques
        registry.addResourceHandler("/musics/**")
                .addResourceLocations(
                        "file:C:\\Users\\beni.sonkpian\\Documents\\BoomplayApp_spring_boot_flutter\\boomplay\\src\\uploads\\music\\");

        // Servir les fichiers depuis le dossier local pour les vidéos
        registry.addResourceHandler("/videos/**")
                .addResourceLocations(
                        "file:C:\\Users\\beni.sonkpian\\Documents\\BoomplayApp_spring_boot_flutter\\boomplay\\src\\uploads\\videos\\");
    }

    @Bean
    public WebMvcConfigurer corsConfigurer() {
        return new WebMvcConfigurer() {
            @Override
            public void addCorsMappings(CorsRegistry registry) {
                // Appliquer CORS aux chemins API
                registry.addMapping("/api/**")
                        .allowedOrigins("*") // Remplacez par l'origine Flutter
                        .allowedMethods("GET", "POST", "PUT", "DELETE")
                        .allowedHeaders("*")
                        .allowCredentials(false);

                // Appliquer CORS aux fichiers musicaux si nécessaire
                registry.addMapping("/musics/**")
                        .allowedOrigins("*") // Remplacez par l'origine Flutter
                        .allowedMethods("GET", "POST")
                        .allowedHeaders("*")
                        .allowCredentials(false);

                // Appliquer CORS aux fichiers vidéo si nécessaire
                registry.addMapping("/videos/**")
                        .allowedOrigins("*") // Remplacez par l'origine Flutter
                        .allowedMethods("GET")
                        .allowedHeaders("*")
                        .allowCredentials(false);
            }
        };
    }
}
