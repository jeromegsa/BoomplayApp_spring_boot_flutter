package com.winner.boomplay.controllers;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.winner.boomplay.models.DataDTO;
import com.winner.boomplay.services.DataService;

@RestController
@RequestMapping("/api/data")
@CrossOrigin
public class DataController {

    private final DataService dataService;

    public DataController(DataService dataService) {
        this.dataService = dataService;
    }

    @GetMapping("/all")
    public DataDTO getAllData() {
        return dataService.getAllData();
    }
}
