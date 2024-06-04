package itwillbs.p2c3.boogimovie.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class PhoneAuthService {
    private static final String API_KEY = "3531856454755108";
    private static final String REQUEST_URL = "https://api.portone.io/certifications/imp00262041";
    private static final String VERIFY_URL = "https://api.portone.io/certifications/verify";

    public Map<String, Object> requestAuth(String phone, String name, String birth, int gender, String carrier) {
        RestTemplate restTemplate = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.set("Authorization", API_KEY);

        Map<String, Object> body = new HashMap<>();
        body.put("merchant_uid", "order_id_" + System.currentTimeMillis());
        body.put("company", "boogimovie");
        body.put("phone", phone);
        body.put("name", name);
        body.put("birth", birth);
        body.put("gender", gender);
        body.put("carrier", carrier);
        body.put("auth_type", "sms");

        HttpEntity<Map<String, Object>> entity = new HttpEntity<>(body, headers);

        ResponseEntity<Map> response = restTemplate.exchange(REQUEST_URL, HttpMethod.POST, entity, Map.class);

        return response.getBody();
    }

    public Map<String, Object> verifyAuth(String impUid, String certification) {
        RestTemplate restTemplate = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.set("Authorization", API_KEY);

        Map<String, Object> body = new HashMap<>();
        body.put("imp_uid", impUid);
        body.put("certification", certification);

        HttpEntity<Map<String, Object>> entity = new HttpEntity<>(body, headers);

        ResponseEntity<Map> response = restTemplate.exchange(VERIFY_URL, HttpMethod.POST, entity, Map.class);

        return response.getBody();
    }

}
