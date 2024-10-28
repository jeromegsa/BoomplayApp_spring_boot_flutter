package com.winner.boomplay;

// import com.winner.boomplay.services.DataGeneratorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class BoomplayApplication  {

    @Autowired
    // private DataGeneratorService dataGeneratorService;

    public static void main(String[] args) {
        SpringApplication.run(BoomplayApplication.class, args);
    }

    // @Override
    // public void run(String... args) throws Exception {
    //     // dataGeneratorService.generateFakeData(10, 5, 5);
    // }
}
