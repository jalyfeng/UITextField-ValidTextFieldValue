//
//  UITextField+Valid.h
//  JAEnrollmentDemo
//
//  Created by jaly on 15/12/10.
//  Copyright © 2015年 org.jaly. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,TextFieldType){
    PhoneNumber,
    Email,
    Letter
};

@interface UITextField (ValidTextFieldValue)<UITextFieldDelegate>

@property (assign,nonatomic) TextFieldType textFieldType;
@property (assign,nonatomic) NSInteger textMinLength;
@property (assign,nonatomic) NSInteger textMaxLength;

@property (strong,nonatomic) NSString *typeError;
@property (strong,nonatomic) NSString *lengthError;
@property (strong,nonatomic) NSString *nilError;

@property (weak,nonatomic) id<UITextFieldDelegate> newDelegate;





/**
 *  初始化验证
 */
-(void)initializeValid;

-(void)setTextFieldType:(TextFieldType)textFieldType typeError:(NSString *)typeError;
-(void)setTextMinLength:(NSInteger)textMinLength textMaxLength:(NSInteger)textMaxLength lengthError:(NSString *)lengthError;
-(void)setNilError:(NSString *)nilError;

-(NSString *)validTextField;



@end

@interface NSString (ValidRegex)

-(BOOL)isValidateEmail;
-(BOOL) isValidateMobile;
-(BOOL) isValidateLetter;
-(BOOL)isValidWithRegex:(NSString *)regex;


@end