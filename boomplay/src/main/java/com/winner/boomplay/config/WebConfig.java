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
        // Configurer le gestionnaire de ressources pour servir les fichiers depuis
        // votre dossier
        registry.addResourceHandler("/musics/**")
                .addResourceLocations(
                        "file:C:/Users/jerome.gbossa/Desktop/Highfive-G4/Developpement-web/SPRING/BoomplayApp/boomplay/src/uploads/musics/");

    }

    @Bean
    public WebMvcConfigurer corsConfigurer() {
        return new WebMvcConfigurer() {
            @Override
            public void addCorsMappings(CorsRegistry registry) {
                registry.addMapping("/musics/**") // Appliquer CORS aux fichiers musicaux
                        .allowedOrigins("*") // Remplacez par l'origine de votre application Flutter
                        .allowedMethods("GET","POST","PUT","DELETE")
                        .allowedHeaders("*")
                        .allowCredentials(false);
            }
        };
    }
}
