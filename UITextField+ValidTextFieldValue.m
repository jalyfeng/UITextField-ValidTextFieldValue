//
//  UITextField+Valid.m
//  JAEnrollmentDemo
//
//  Created by jaly on 15/12/10.
//  Copyright © 2015年 org.jaly. All rights reserved.
//

#import "UITextField+ValidTextFieldValue.h"
#import <objc/runtime.h> 


@implementation UITextField (ValidTextFieldValue)

static char TextFieldTypeKey;
static char TextMinLengthKey;
static char TextMaxLengthKey;
static char TextTypeErrorKey;
static char TextLengthErrorKey;
static char TextNilErrorKey;
static char TextNewDelegateKey;

@dynamic newDelegate;


-(void)initializeValid{
    self.delegate=self;
    self.textMinLength=-1;
    self.textMaxLength=-1;
    [self addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
}

-(void)setTextFieldType:(TextFieldType)textFieldType{
    objc_setAssociatedObject(self, &TextFieldTypeKey, @(textFieldType), OBJC_ASSOCIATION_ASSIGN);
}

-(TextFieldType)textFieldType{
    return [objc_getAssociatedObject(self, &TextFieldTypeKey) integerValue];
}

-(void)setTextMinLength:(NSInteger)textMinLength{
    objc_setAssociatedObject(self, &TextMinLengthKey, @(textMinLength), OBJC_ASSOCIATION_ASSIGN);
}

-(NSInteger)textMinLength{
    return [objc_getAssociatedObject(self, &TextMinLengthKey) integerValue];
}

-(void)setTextMaxLength:(NSInteger)textMaxLength{
    objc_setAssociatedObject(self, &TextMaxLengthKey, @(textMaxLength), OBJC_ASSOCIATION_ASSIGN);
}

-(NSInteger)textMaxLength{
    return [objc_getAssociatedObject(self, &TextMaxLengthKey) integerValue];
}

-(void)setTypeError:(NSString *)typeError{
    objc_setAssociatedObject(self, &TextTypeErrorKey, typeError, OBJC_ASSOCIATION_ASSIGN);
}

-(NSString *)typeError{
    return objc_getAssociatedObject(self, &TextTypeErrorKey);
}

-(void)setLengthError:(NSString *)lengthError{
    objc_setAssociatedObject(self, &TextLengthErrorKey, lengthError, OBJC_ASSOCIATION_ASSIGN);
}

-(NSString *)lengthError{
    return objc_getAssociatedObject(self, &TextLengthErrorKey);
}

-(void)setNilError:(NSString *)nilError{
    objc_setAssociatedObject(self, &TextNilErrorKey, nilError, OBJC_ASSOCIATION_ASSIGN);
}

-(NSString *)nilError{
    return objc_getAssociatedObject(self, &TextNilErrorKey);
}

-(void)setDelegate:(id<UITextFieldDelegate>)delegate{
    if(delegate==self){
        [self setValue:delegate forKeyPath:@"_delegate"];
        return;
    }
    self.newDelegate=delegate;
}

-(void)setNewDelegate:(id<UITextFieldDelegate>)newDelegate{
    objc_setAssociatedObject(self, &TextNewDelegateKey, newDelegate, OBJC_ASSOCIATION_ASSIGN);
}

-(id<UITextFieldDelegate>)newDelegate{
    return objc_getAssociatedObject(self, &TextNewDelegateKey);
}

-(void)setTextFieldType:(TextFieldType)textFieldType typeError:(NSString *)typeError{
    self.textFieldType=textFieldType;
    self.typeError=typeError;
}

-(void)setTextMinLength:(NSInteger)textMinLength textMaxLength:(NSInteger)textMaxLength lengthError:(NSString *)lengthError{
    self.textMinLength=textMinLength;
    self.textMaxLength=textMaxLength;
    self.lengthError=lengthError;
}

-(NSString *)validTextFieldType{
    switch (self.textFieldType) {
        case PhoneNumber:
            return ![self.text isValidateMobile]?(self.typeError?self.typeError:@"手机格式不正确"):nil;
        case Email:
            return ![self.text isValidateEmail]?(self.typeError?self.typeError:@"邮箱格式不对"):nil;
        case Letter:
            return ![self.text isValidateLetter]?(self.typeError?self.typeError:@"字符格式不对"):nil;
    }
    return NO;
}

-(NSString *)validTextField{
    if(self.text.length<=0 && self.nilError){
        return self.nilError;
    }
    if(self.text.length>=self.textMinLength && self.text.length<=self.textMaxLength){
        return [self validTextFieldType];
    }
    return self.lengthError?self.lengthError:[NSString stringWithFormat:@"长度为%d-%d",(int)self.textMinLength,(int)self.textMaxLength];
}

#pragma mark - UITextFieldDelegate
-(void)textFieldChanged:(UITextField *)textField{
    if(textField && textField.text && self.textMaxLength!=-1  && textField.text.length>self.textMaxLength){
        textField.text=[textField.text substringToIndex:self.textMaxLength];
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if(self.newDelegate && [self.newDelegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]){
        if([self.newDelegate textField:textField shouldChangeCharactersInRange:range replacementString:string]){
            if(self.textMaxLength!=-1 && range.location>=self.textMaxLength){
                return NO;
            }
            return YES;
        }else{
            return NO;
        }
    }else{
        if(self.textMaxLength!=-1 && range.location>=self.textMaxLength){
            return NO;
        }
        return YES;
    }
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if(self.newDelegate && [self.newDelegate respondsToSelector:@selector(textFieldShouldBeginEditing:)]){
        return [self.newDelegate textFieldShouldBeginEditing:textField];
    }
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if(self.newDelegate && [self.newDelegate respondsToSelector:@selector(textFieldDidBeginEditing:)]){
        [self.newDelegate textFieldDidBeginEditing:textField];
    }
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if(self.newDelegate && [self.newDelegate respondsToSelector:@selector(textFieldShouldEndEditing:)]){
        return [self.newDelegate textFieldShouldEndEditing:textField];
    }
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if(self.newDelegate && [self.newDelegate respondsToSelector:@selector(textFieldDidEndEditing:)]){
        [self.newDelegate textFieldDidEndEditing:textField];
    }
}


- (BOOL)textFieldShouldClear:(UITextField *)textField{
    if(self.newDelegate && [self.newDelegate respondsToSelector:@selector(textFieldShouldClear:)]){
        return [self.newDelegate textFieldShouldClear:textField];
    }
    return NO;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(self.newDelegate && [self.newDelegate respondsToSelector:@selector(textFieldShouldReturn:)]){
        return [self.newDelegate textFieldShouldReturn:textField];
    }
    return NO;
}


@end

@implementation NSString (ValidRegex)

/*邮箱验证 MODIFIED BY HELENSONG*/
-(BOOL)isValidateEmail{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    return [self isValidWithRegex:emailRegex];
}

/*手机号码验证 MODIFIED BY HELENSONG*/
-(BOOL) isValidateMobile{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    return [self isValidWithRegex:phoneRegex];
}

-(BOOL) isValidateLetter{
    NSString *letterRegex=@"[A-Z0-9a-z]+";
    return [self isValidWithRegex:letterRegex];
}

-(BOOL)isValidWithRegex:(NSString *)regex{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:self];
}



@end