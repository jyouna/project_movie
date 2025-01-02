package com.itwillbs.project_movie.handler;

import java.security.SecureRandom;
import java.util.Random;

import org.apache.commons.lang3.RandomStringUtils;

// 특정 길이의 난수 생성에 사용할 GenerateRandomCode 클래스 정의
public class GenerateRandomCode {

	// 난수 생성 후 문자열로 리턴할 getRandomCode() 메서드 정의
	// => 파라미터 : 난수 길이(정수)   리턴타입 : String
	// => 인스턴스 생성없이 즉시 호출 가능하도록 static 메서드로 정의
	public static String getRandomCode(int length) {
		// [ 난수 생성 방법 ]
		// 1. java.util.Random 클래스 활용(또는 java.lang.Math 클래스의 random() 메서드 활용)
		// ex) 5자리 정수(0 ~ 99999) 로 된 난수 생성
//		Random r = new Random();
//		int rNum = r.nextInt(100000); // 0 ~ 99999(100000 - 1) 난수 생성
		
		// 파라미터로 전달받은 length 값을 자릿수로 활용
		// => 10 ^ length 형태로 연산을 통해 출력할 자릿수 지정 가능
//		int rNum = r.nextInt(10 ^ length); // 10 의 length 승까지의 난수 생성
		// => ex. length = 5 일 때 10 의 5승
		// => 주의! 10 ^ length 형태로 연산식을 지정 시 ^ 연산자가 비트 단위 논리연산자 XOR 로 취급됨
		//    2진수 10과 2진수 length 값의 비트 단위 XOR 연산 결과값이 적용되므로 다른 값으로 연산됨
		// => 결론! x ^ y 연산을 수행하기 위해서는 Math.pow() 메서드를 활용해야한다!
		//    (기본 문법 : double Math.pow(double, double))
//		int rNum = r.nextInt((int)Math.pow(10, length));
//		System.out.println("생성된 난수 : " + rNum);
		// =======================================================================================
		// 2. Random 클래스의 보안 취약점을 해결하기 위해 제공되는 SecureRandom 클래스 활용
		//    => 사용법은 Random 클래스와 동일
//		SecureRandom sr = new SecureRandom();
//		int rNum = sr.nextInt((int)Math.pow(10, length));
//		System.out.println("생성된 난수 : " + rNum);
		// ---------------------------------------------------------------------------------------
		// 생성된 난수가 x자리 미만일 경우 모자라는 자릿수는 생략하고 실제 숫자만 표기함
		// => 이유 : 정수 앞에 0 채울 경우 맨 앞자리가 0인 정수는 8진수로 취급되기 때문
		// 따라서, 문자열로 변환하여 문자열 포맷팅을 통해 앞자리 빈자리에 0 채우도록 변경
//		System.out.println("생성된 난수 : " + String.format("%05d", rNum));
//		System.out.println("생성된 난수 : " + String.format("%0" + length + "d", rNum));
		// =======================================================================================
		// 3. 난수 생성에 관한 다양한 기능을 제공하는 외부 라이브러리 활용
		// => Apache 의 commons-lang3 라이브러리 추가하여 RandomXXX 클래스 활용
		// => RandomStringUtils.randomAlphanumeric() 메서드를 호출하여
		//    지정된 길이의 알파벳&정수 조합을 문자열로 생성하여 리턴
		// => 단, 대부분의 메서드는 deprecated 처리됨. secure() 등의 다른 메서드 권장됨
//		System.out.println("생성된 난수 : " + RandomStringUtils.randomAlphanumeric(length));
		
		return RandomStringUtils.randomAlphanumeric(length);
	}
	
}















