package com.coffeetasting.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityCustomizer;
import org.springframework.security.web.firewall.HttpFirewall;

@Configuration
public class WebSecurityConfiguration implements WebSecurityCustomizer {

    @Autowired
    private HttpFirewall httpFirewall;

    @Override
    public void customize(WebSecurity web) {
        web.httpFirewall(httpFirewall);
    }
}