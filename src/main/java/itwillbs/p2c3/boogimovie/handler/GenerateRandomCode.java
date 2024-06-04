package itwillbs.p2c3.boogimovie.handler;

import org.apache.commons.lang3.RandomStringUtils;

// 특정 길이의 난수 생성에 사용할 클래스 정의
public class GenerateRandomCode {
	// 난수 생성하여 문자열로 리턴할 getRandomCode() 메서드 정의
	// => 파라미터 : 난수 길이(정수)   리턴타입 : String
	// => 인스턴스 생성없이 즉시 호출 가능하도록 static 메서드로 선언
	public static String getRandomCode(int length) {
		// [ 난수 생성 방법 ]
		// 1. java.util.Random 클래스 활용
		// 5자리 정수(0 ~ 99999)로 된 난수 생성
//		Random r = new Random();
//		int rNum = r.nextInt(100000);
		
		// 2. java.security.SecureRandom 클래스 활용
		// => Random 클래스의 의사 난수로 인한 보안 취약점을 해결하기 위해 만들어진 클래스
		// => Random 클래스와 기본 사용법 동일함
//		SecureRandom r = new SecureRandom();
//		int rNum = r.nextInt(100000);
		
		// 5자리 정수 난수 발생 후 문자열로 변환
		// => 5자리 미만의 정수의 경우 5자리 형태로 변환하여 변환 필요(앞자리 0으로 채움)
//		String strNum = String.format("%05d", rNum);
		// ----------------------------------------------------------------------------------
		// 5자리의 난수(알파벳 대문자, 소문자, 숫자 조합) 생성
		// 1) 난수에 사용될 데이터를 char 배열로 생성(ex. 대문자 10개, 소문자 10개, 숫자 10개 = 30개)
//		char[] randomCodePiece = {
//			'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J',
//			'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j',
//			'0', '1', '2', '3', '4', '5', '6', '7', '8', '9'
//		};
//		String strNum = "";
//
//		
//		for(int i = 0 ; i <length; i++) {
//			SecureRandom r = new SecureRandom();
//			int rNum = r.nextInt(randomCodePiece.length);
//			strNum += randomCodePiece[rNum] + "";
//		}
//		
//		
//		System.out.println(strNum);
		
		return RandomStringUtils.randomAlphanumeric(length);
		
		
		
		
	}
}












