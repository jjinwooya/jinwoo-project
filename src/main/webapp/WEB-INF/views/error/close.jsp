<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<script>
    // 현재 창을 닫는 JavaScript 코드
    alert("${msg}");
    if (window.opener && !window.opener.closed) {
        window.opener.refreshParent();
    }
    
    window.close();
</script>
</body>
</html>