# UITextField-ValidTextFieldValue-

##-(void)initializeValid;
### 需要验证 必须先调用初始化方法

## -(void)setTextFieldType:(TextFieldType)textFieldType typeError:(NSString *)typeError;
### 设置验证类型和失败信息

##-(void)setTextMinLength:(NSInteger)textMinLength textMaxLength:(NSInteger)textMaxLength lengthError:(NSString *)lengthError;
###设置最小最大长度，以及验证失败信息

##-(void)setNilError:(NSString *)nilError;
###设置为空的失败信息

##-(NSString *)validTextField;
###返回验证结果