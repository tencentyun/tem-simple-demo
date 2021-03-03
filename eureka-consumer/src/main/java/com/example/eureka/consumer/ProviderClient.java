package com.example.eureka.consumer;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@FeignClient("eureka-provider")
public interface ProviderClient {
    @RequestMapping(method = RequestMethod.GET, value = "/ping")
    String ping();
}
