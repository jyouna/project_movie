package com.itwillbs.project_movie.handler;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;


// 시스템 상에서 발생 가능한 예외(HTTP 4xx 에러 제외)를 처리하는 전용 핸들러 정의
// => 예외 처리 핸들러 클래스 정의 시 클래스 선언부 상단에 @ControllerAdvice 어노테이션 지정
@ControllerAdvice
public class MyExceptionHandler {
	// 예외 처리를 수행하기 위한 메서드 정의
	// => 메서드 선언부 상단에 @ExceptionHandler 어노테이션 지정
	// => 기본 문법 : @ExceptionHandler(예외처리클래스명.class)
	//                public 리턴타입 메서드명(예외처리클래스명 변수명) {}
	//                => 메서드명은 무관
	//                => 리턴타입은 뷰페이지로 포워딩할 경우 String
	//                => 메서드 파라미터는 예외 발생 시 예외 객체를 전달받을 변수 선언
	// => try~catch 문에서 catch 블럭 역할을 수행함
	@ExceptionHandler(Exception.class) // 전체 예외를 하나로 묶어 처리하기 위해 Exception 클래스 지정
	public String exceptionHandler(Exception e) {
		System.out.println("----------------------------------------------------");
		System.out.println("exceptionHandler 메서드에서 예외 처리!");
		System.out.println("----------------------------------------------------");

		
		// 개발자는 콘솔에서 예외를 확인해야하므로 예외 메세지를 출력
		e.printStackTrace();
		
		// 예외 발생 시 사용자에게 응답으로 전송할 뷰페이지 지정(error_exception.jsp)
		// => 컨트롤러에서 포워딩하는 방법과 동일함
		return "result/error_exception";
	}
	
}











