<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<html>
<head>
    <title>부기무비 휴대폰 인증</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <h2>Phone Authentication</h2>
    <form id="authForm">
        Phone: <input type="text" id="phone" name="phone"><br>
        Name: <input type="text" id="name" name="name"><br>
        Birth: <input type="text" id="birth" name="birth"><br>
        Gender: <input type="radio" id="male" name="gender" value="1"> Male
        <input type="radio" id="female" name="gender" value="0"> Female<br>
        Carrier: <select id="carrier" name="carrier">
            <option value="SKT">SKT</option>
            <option value="KT">KT</option>
            <option value="LGT">LGT</option>
        </select><br>
        <button type="button" onclick="requestAuth()">Request Auth</button>
    </form>

    <form id="verifyForm" style="display: none;">
        ImpUid: <input type="text" id="impUid" name="impUid"><br>
        Certification: <input type="text" id="certification" name="certification"><br>
        <button type="button" onclick="verifyAuth()">Verify Auth</button>
    </form>

    <script>
        function requestAuth() {
            $.post("requestAuth", $("#authForm").serialize(), function(data) {
                if (data) {
                    alert("Authentication request sent. Please check your phone.");
                    $("#verifyForm").show();
                    $("#impUid").val(data.imp_uid); // 응답에서 imp_uid를 설정
                } else {
                    alert("Authentication request failed.");
                }
            });
        }

        function verifyAuth() {
            $.post("verifyAuth", $("#verifyForm").serialize(), function(data) {
                if (data) {
                    alert("Authentication verified.");
                } else {
                    alert("Authentication verification failed.");
                }
            });
        }
    </script>
</body>
</html>
