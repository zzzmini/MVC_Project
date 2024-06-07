package kr.co.zzz.jspTest;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class CarDto {
	private String number;
	private String model;
	private int engine;
}
