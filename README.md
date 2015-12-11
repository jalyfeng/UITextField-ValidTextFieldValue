

# UITextField-ValidTextFieldValue

![](https://avatars1.githubusercontent.com/u/4318332?v=3&s=460)

![](https://img.shields.io/github/stars/jaly19870729/UITextField-ValidTextFieldValue-.svg) ![](https://img.shields.io/github/forks/jaly19870729/UITextField-ValidTextFieldValue-.svg) ![](https://img.shields.io/github/tag/jaly19870729/UITextField-ValidTextFieldValue-.svg) ![](https://img.shields.io/github/release/jaly19870729/UITextField-ValidTextFieldValue-.svg) ![](https://img.shields.io/github/issues/jaly19870729/UITextField-ValidTextFieldValue-.svg)
### 主要特性

- 对UITextField添加自身验证；
- 现在支持的验证有手机号、邮箱、字母数字、长度限制；
- 不影响UITextField本身delegate功能；


## <a id="UITextField+ValidTextFieldValue.h"></a>UITextField+ValidTextFieldValue.h
```objc
/** 需要验证 必须先调用初始化方法 */
-(void)initializeValid;
/** 设置验证类型和失败信息 */
-(void)setTextFieldType:(TextFieldType)textFieldType typeError:(NSString *)typeError;
/** 设置最小最大长度，以及验证失败信息 */
-(void)setTextMinLength:(NSInteger)textMinLength textMaxLength:(NSInteger)textMaxLength lengthError:(NSString *)lengthError;
/** 设置为空的失败信息 */
-(void)setNilError:(NSString *)nilError;
/** 返回验证结果 */
-(NSString *)validTextField;
```
