package com.eland.ngoc.common.model;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
public @interface Value {
	
	String value() default "";
	
	int min() default Integer.MIN_VALUE;
	
	int max() default Integer.MAX_VALUE;
	
	int length() default Integer.MAX_VALUE;
	
	boolean required() default false;
	
	boolean numberYn() default false;
	
	boolean onlyNum() default false;

}
