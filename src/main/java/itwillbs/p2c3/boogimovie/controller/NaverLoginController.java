package itwillbs.p2c3.boogimovie.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class NaverLoginController {

    private String clientId = "YYIJQmFYT8uB2h0xYs1o";
    private String clientSecret = "2Ey9itLWp0";
    private String redirectURI = "http://localhost:8081/test2/NaverLoginCallback";
    
    @RequestMapping("NaverLoginCallback")
    public String naverLoginCallback(@RequestParam(required = false) String code, @RequestParam(required = false) String state, HttpSession session, Model model) {
        String apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code&client_id="
                        + clientId + "&client_secret=" + clientSecret + "&code=" + code + "&state=" + state;
        
        String accessToken = "";
        String refreshToken = "";

        try {
            URL url = new URL(apiURL);
            HttpURLConnection con = (HttpURLConnection)url.openConnection();
            con.setRequestMethod("GET");
            int responseCode = con.getResponseCode();
            BufferedReader br;
            if(responseCode == 200) { // 정상 호출
                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            } else {  // 에러 발생
                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
            }
            String inputLine;
            StringBuffer responseBuffer = new StringBuffer();
            while ((inputLine = br.readLine()) != null) {
                responseBuffer.append(inputLine);
            }
            br.close();
            JSONObject json = new JSONObject(responseBuffer.toString());
            accessToken = json.getString("access_token");
            refreshToken = json.getString("refresh_token");
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (!accessToken.isEmpty()) {
            String header = "Bearer " + accessToken; // Bearer 다음에 공백 추가
            try {
                String apiURLProfile = "https://openapi.naver.com/v1/nid/me";
                URL url = new URL(apiURLProfile);
                HttpURLConnection con = (HttpURLConnection)url.openConnection();
                con.setRequestMethod("GET");
                con.setRequestProperty("Authorization", header);
                int responseCode = con.getResponseCode();
                BufferedReader br;
                if(responseCode == 200) {
                    br = new BufferedReader(new InputStreamReader(con.getInputStream()));
                } else {
                    br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
                }
                String inputLine;
                StringBuffer responseBuffer = new StringBuffer();
                while ((inputLine = br.readLine()) != null) {
                    responseBuffer.append(inputLine);
                }
                br.close();
                JSONObject json = new JSONObject(responseBuffer.toString());
                JSONObject responseObj = json.getJSONObject("response");
                String email = responseObj.getString("email");
                String name = responseObj.getString("name");
                String profile_image = responseObj.getString("profile_image");
                	
                // 세션에 사용자 정보 저장
                session.setAttribute("email", email);
                session.setAttribute("name", name);
                session.setAttribute("profile_image", profile_image);
                session.setAttribute("sId", name);

                return "redirect://"; 
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        session.setAttribute("sId", "김아무개");
        return "redirect://";
    }
}