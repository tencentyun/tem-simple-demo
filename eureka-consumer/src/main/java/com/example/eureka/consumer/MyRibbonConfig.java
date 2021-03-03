package com.example.eureka.consumer;

import com.netflix.client.config.IClientConfig;
import com.netflix.loadbalancer.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;

public class MyRibbonConfig {
    @Autowired
    IClientConfig ribbonClientConfig;

//    Don't use this because it calls `/` of upstream to determine if it's UP
//    @Bean
//    public IPing ribbonPing(IClientConfig config) {
//        return new PingUrl();
//    }

    @Bean
    public IRule ribbonRule(IClientConfig config) {
        return new RoundRobinRule();
    }
}
