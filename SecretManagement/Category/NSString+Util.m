//
//  NSString+Util.m
//  GoGo
//
//  Created by GuoChengHao on 14-4-21.
//  Copyright (c) 2014年 Maxicn. All rights reserved.
//

#import "NSString+Util.h"
#import "SystemRelate.h"
#import <CommonCrypto/CommonDigest.h>
#import <Security/Security.h>
#import <Foundation/Foundation.h>

@implementation NSString (Util)

+ (BOOL)isBlankString:(NSString *)string {
    
    if ( ![string isKindOfClass:[NSString class]]) {
        return YES;
    }
    
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    if ([string isEqualToString:@"<null>"]) {
        return YES;
    }
    if ([string isEqualToString:@"null"]) {
        return YES;
    }
    if ([string isEqualToString:@"(null)"]) {
        return YES;
    }
    return NO;
}

- (BOOL)validateMobile//:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    //NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    NSString *MOBILE = @"^(1)\\d{10}$";
    
    //    /**
    //     10         * 中国移动：China Mobile
    //     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
    //     12         */
    //    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    //    /**
    //     15         * 中国联通：China Unicom
    //     16         * 130,131,132,152,155,156,185,186
    //     17         */
    //    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    //    /**
    //     20         * 中国电信：China Telecom
    //     21         * 133,1349,153,180,189
    //     22         */
    //    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    //    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})-\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    //    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    //    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    //    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    //    NSPredicate *regextestphs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    
    if (([regextestmobile evaluateWithObject:self] == YES))
        //        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        //        || ([regextestct evaluateWithObject:mobileNum] == YES)
        //        || ([regextestcu evaluateWithObject:mobileNum] == YES)
        //        || ([regextestphs evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    } else {
        return NO;
    }
}

+ (NSString *)toJSONString:(id)theData {
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if ([jsonData length] > 0 && error == nil){
        return [[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding] stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    }else{
        return nil;
    }
}

- (id)JSONValue
{
    NSData* data = [self dataUsingEncoding:NSUTF8StringEncoding];
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}

+ (BOOL)validateIDCardNumber:(NSString *)value {
    
    if (![value isKindOfClass:[NSString class]]) {
        return NO;
    }
    
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSInteger length = 0;
    
    if (!value) {
        
        return NO;
        
    } else {
        
        length = value.length;
        
        
        
        if (length != 15 && length !=18) {
            
            return NO;
            
        }
        
    }
    
    // 省份代码
    
    NSArray *areasArray =@[@"11", @"12", @"13", @"14", @"15", @"21", @"22", @"23", @"31", @"32", @"33", @"34", @"35", @"36", @"37", @"41", @"42", @"43", @"44", @"45", @"46", @"50", @"51", @"52", @"53", @"54", @"61", @"62", @"63", @"64", @"65", @"71", @"81", @"82", @"91"];
    
    
    
    NSString *valueStart2 = [value substringToIndex:2];
    
    BOOL areaFlag = NO;
    
    for (NSString *areaCode in areasArray) {
        
        if ([areaCode isEqualToString:valueStart2]) {
            
            areaFlag =YES;
            
            break;
            
        }
        
    }
    
    
    if (!areaFlag) {
        
        return false;
        
    }
    
    
    
    
    
    NSRegularExpression *regularExpression;
    
    NSUInteger numberofMatch;
    
    
    
    int year = 0;
    
    switch (length) {
            
        case 15:
            
            year = [value substringWithRange:NSMakeRange(6,2)].intValue +1900;
            
            
            
            if (year % 4 ==0 || (year % 100 ==0 && year % 4 ==0)) {
                
                
                
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"
                                     
                                                                         options:NSRegularExpressionCaseInsensitive
                                     
                                                                           error:nil];// 测试出生日期的合法性
                
            }else {
                
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"
                                     
                                                                         options:NSRegularExpressionCaseInsensitive
                                     
                                                                           error:nil];// 测试出生日期的合法性
                
            }
            
            numberofMatch = [regularExpression numberOfMatchesInString:value
                             
                                                               options:NSMatchingReportProgress
                             
                                                                 range:NSMakeRange(0, value.length)];
            
            
            
            if(numberofMatch > 0) {
                
                return YES;
                
            }else {
                
                return NO;
                
            }
            
        case 18:
            
            
            year = [value substringWithRange:NSMakeRange(6,4)].intValue;
            
            if (year % 4 ==0 || (year % 100 ==0 && year % 4 ==0)) {
                
                
                
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$"
                                     
                                                                         options:NSRegularExpressionCaseInsensitive
                                     
                                                                           error:nil];// 测试出生日期的合法性
                
            }else {
                
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$"
                                     
                                                                         options:NSRegularExpressionCaseInsensitive
                                     
                                                                           error:nil];// 测试出生日期的合法性
                
            }
            
            numberofMatch = [regularExpression numberOfMatchesInString:value
                             
                                                               options:NSMatchingReportProgress
                             
                                                                 range:NSMakeRange(0, value.length)];
            
            
            
            
            
            
            
            if(numberofMatch > 0) {
                
                int S = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7 + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9 + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10 + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5 + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8 + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4 + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2 + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6 + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
                
                int Y = S % 11;
                
                NSString *M = @"F";
                
                NSString *JYM = @"10X98765432";
                
                M = [JYM substringWithRange:NSMakeRange(Y,1)]; // 判断校验位
                
                if ([M isEqualToString:[value substringWithRange:NSMakeRange(17,1)].uppercaseString]) {
                    
                    return YES;// 检测ID的校验位
                    
                }else {
                    
                    return NO;
                    
                }
                
                
            }else {
                
                return NO;
                
            }
            
        default:
            
            return false;
            
    }
    
}


+(BOOL)validateHKIDCardNumber:(NSString *)value {
    
    // 不能是纯字母
    if ([[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^[a-zA-Z]+$"] evaluateWithObject:value]){
        return NO;
    }
    // 15 个字符
    if (![[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^.{1,15}$"] evaluateWithObject:value]){
        return NO;
    }
    // 只能是数字和字母
    if (![[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^[a-zA-Z0-9]+$"] evaluateWithObject:value]){
        return NO;
    }
    return YES;
}

//8位或10位，纯数字
+(BOOL)validateTWIDCardNumber:(NSString *)value {
    // 不能是纯字母
    if ([[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^[a-zA-Z]+$"] evaluateWithObject:value]){
        return NO;
    }
    // 15 个字符
    if (![[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^.{15}$"] evaluateWithObject:value]){
        return NO;
    }
    // 只能是数字和字母
    if (![[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^[a-zA-Z0-9]+$"] evaluateWithObject:value]){
        return NO;
    }
    return YES;
}

+(NSString *)validLoginPwd:(NSString *)value andMobile:(NSString *)mobile{

    // 6-20 个字符
    if (![[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^.{6,20}$"] evaluateWithObject:value]){
        return @"登录密码必须6至20位字母、数字或者符号组合";
    }
    // 不能是纯数字
    if ([[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^\\d+$"] evaluateWithObject:value]){
        return @"登录密码不能是纯数字、纯字母或者纯符号";
    }
    // 不能是纯字母
    if ([[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^[a-zA-Z]+$"] evaluateWithObject:value]){
        return @"登录密码不能是纯数字、纯字母或者纯符号";
    }
    // 不能是纯符号
    if ([[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^[\\W_]+$"] evaluateWithObject:value]){
        return @"登录密码不能是纯数字、纯字母或者纯符号";
    }
    // 登录密码首尾不能为空格
//    if ([value hasPrefix:@" "] || [value hasSuffix:@" "]){
//        return @"登录密码首尾不能为空格";
//    }
    // 登录密码不能包含空格
    if (![[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^[^\\s]+$"] evaluateWithObject:value]) {
        return @"登录密码不能包含空格";
    }
    // 密码中不能包含有连续四位及以上重复字符，字母不区分大小写；（如：8888、AAAA、$$$$等）
    if ([[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @".*(.)\\1{3,}.*"] evaluateWithObject:[value lowercaseString]]){
        return @"登录密码不能包含四位重复数字、字母或符号";
    }
    // 不能将帐号名作为密码的一部分存在于密码，帐号密码也不能一样
    if ([value isEqualToString:mobile] || ([value rangeOfString:mobile].location != NSNotFound)) {
        return @"登录密码不能包含账号信息";
    }
//    // 常用禁忌词不区分大小写不能作为密码的一部分存在于密码中
//    if ([[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @".*(admin|pass).*"] evaluateWithObject:value]){
//        return @"";
//    }

    // 不能包含有连续四位及以上顺序(或逆序)数字或字母；（如：1234、abcd等）
    int asc = 1;
    int desc = 1;
    int lastChar = [value characterAtIndex:0];
    for (int i = 1; i < value.length ; i++) {
        int currentChar = [value characterAtIndex:i];
        if (![[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^[a-zA-Z0-9]+$"] evaluateWithObject:[value substringWithRange:NSMakeRange(i, 1)]]) {
            asc = 0;
            desc = 0;
        } else if (lastChar == currentChar - 1) {
            asc++;
            desc = 1;
        } else if (lastChar == currentChar + 1) {
            desc++;
            asc = 1;
        } else {
            asc = 1;
            desc = 1;
        }
        
        if (asc >= 4 || desc >= 4) {
            return @"登录密码不能包含四位连续数字、字母";
        }
        lastChar = currentChar;
    }
    
    
    return nil;
}

//支付密码设置规则：支付密码为6位数字，不能包含有连续4位及以上顺序或逆序的数字，给出提醒；
+ (NSInteger)appValidPaymentPwd:(NSString *)pwd
{
    //6位
    if(pwd.length!= 6)
    {
        return 1;
    }
    
    // 密码中不能包含有连续四位及以上重复字符，字母不区分大小写；（如：8888、AAAA、$$$$等）
    if ([[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @".*(.)\\1{3,}.*"] evaluateWithObject:[pwd lowercaseString]])
    {
        return 2;
    }

    
    // 不能包含有连续四位及以上顺序(或逆序)数字或字母；（如：1234、abcd等）
    int asc = 1;
    int desc = 1;
    int lastChar = [pwd characterAtIndex:0];
    for (int i = 1; i < pwd.length ; i++) {
        int currentChar = [pwd characterAtIndex:i];
        if (![[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^[a-zA-Z0-9]+$"] evaluateWithObject:[pwd substringWithRange:NSMakeRange(i, 1)]]) {
            asc = 0;
            desc = 0;
        } else if (lastChar == currentChar - 1) {
            asc++;
            desc = 1;
        } else if (lastChar == currentChar + 1) {
            desc++;
            asc = 1;
        } else {
            asc = 1;
            desc = 1;
        }
        
        if (asc >= 4 || desc >= 4) {
            return 3;
        }
        lastChar = currentChar;
    }
    return 4;
}

+ (NSMutableAttributedString *)nameFont:(UIFont *)font name:(NSString *)name string:(NSString *)string;
{
    NSMutableAttributedString *fontString=[[NSMutableAttributedString alloc]initWithString:string];
    if ([name isKindOfClass:[NSString class]]) {
        NSRange rang=[string rangeOfString:name];
        [fontString addAttribute:NSFontAttributeName value:font range:rang];
    }
    return fontString;
}
+ (NSMutableAttributedString *)nameColor:(UIColor *)color name:(NSString *)name string:(NSString *)string
{
    NSMutableAttributedString *retStr = [[NSMutableAttributedString alloc] initWithString:string];
    if ([name isKindOfClass:[NSString class]]) {
        NSRange range = [string rangeOfString:name];
        [retStr addAttribute:NSForegroundColorAttributeName value:color range:range];
    }
    return retStr;
    
}

//32位MD5加密方式
- (NSString*)MD5
{
    // Create pointer to the string as UTF8
    const char *ptr = [self UTF8String];
    
    // Create byte array of unsigned chars
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    
    // Create 16 byte MD5 hash value, store in buffer
    CC_MD5(ptr,(CC_LONG)strlen(ptr), md5Buffer);
    
    // Convert MD5 value in the buffer to NSString of hex values
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x",md5Buffer[i]];
    
    return output;
}

// RSA 加密
-(NSString*)RSA:(NSString *)publicKey{

    NSData *publickKeyData = [publicKey dataUsingEncoding:NSUTF8StringEncoding];
    NSData *plainTextBytes = [self dataUsingEncoding:NSUTF8StringEncoding]; // 要加密的文字
    
    SecCertificateRef pubKeyCertificate = SecCertificateCreateWithData(kCFAllocatorDefault, (__bridge CFDataRef)publickKeyData);
    
    SecPolicyRef Policy = SecPolicyCreateBasicX509();
    SecTrustRef myTrust;
    OSStatus status = SecTrustCreateWithCertificates(pubKeyCertificate,Policy,&myTrust);
    SecTrustResultType trustResult;
    if (status == noErr) {
        status = SecTrustEvaluate(myTrust, &trustResult);
    }
    
    SecKeyRef pubKeyRef = SecTrustCopyPublicKey(myTrust);
    
    
    size_t cipherBufferSize = SecKeyGetBlockSize(pubKeyRef);
    uint8_t *cipherBuffer = NULL;
    
    cipherBuffer = malloc(cipherBufferSize * sizeof(uint8_t));
    memset((void *)cipherBuffer, 0*0, cipherBufferSize);
    

    unsigned long blockSize = cipherBufferSize-11;  // 这个地方比较重要是加密数组长度
    int numBlock = (int)ceil([plainTextBytes length] / (double)blockSize);
    NSMutableData *encryptedData = [[NSMutableData alloc] init];
    for (int i=0; i<numBlock; i++) {
        unsigned long bufferSize = MIN(blockSize,[plainTextBytes length]-i*blockSize);
        NSData *buffer = [plainTextBytes subdataWithRange:NSMakeRange(i * blockSize, bufferSize)];
        OSStatus status = SecKeyEncrypt(pubKeyRef,
                                        kSecPaddingPKCS1,
                                        (const uint8_t *)[buffer bytes],
                                        [buffer length],
                                        cipherBuffer,
                                        &cipherBufferSize);
        if (status == noErr)
        {
            NSData *encryptedBytes = [[NSData alloc] initWithBytes:(const void *)cipherBuffer length:cipherBufferSize];
            [encryptedData appendData:encryptedBytes];
        }
        else
        {
            return nil;
        }
    }
    if (cipherBuffer)
    {
        free(cipherBuffer);
    }  
    NSString *encrypotoResult=[NSString stringWithFormat:@"%@",[encryptedData base64Encoding]];
    return encrypotoResult;
}

//金额输入规范
+ (NSString *)menoyRule:(NSString *)text
{
    //金额不能大于8位 不能输入两个小数点 小数点后面保留2位
    NSString *resultStr = @"";
    if (text.length > 8) {
        resultStr = [text substringToIndex:text.length - 1];
        return resultStr;
    }
    NSArray *array = [text componentsSeparatedByString:@"."];
    if (array.count > 2) {
        //如果有多个小数点 删除前面的小数点
        NSInteger location = [text rangeOfString:@"."].location;
        NSString *temp = [NSString stringWithFormat:@"%@%@",[text substringToIndex:location],[text substringFromIndex:location + 1]];
        resultStr = temp;
    }
    else if (array.count == 2){
        //        NSString *firstArm = [array firstObject];
        NSString *lastArm = [array lastObject];
        if (lastArm.length > 2) {
            resultStr = [text substringToIndex:text.length - 1];
        }
    }
    return resultStr;
}

//保留小数有效位
+ (NSString *)changeFloat:(NSString *)stringFloat
{
    const char *floatChars = [stringFloat UTF8String];
    NSUInteger length = [stringFloat length];
    NSUInteger zeroLength = 0;
    int i = length-1;
    for(; i>=0; i--)
    {
        if(floatChars[i] == '0'/*0x30*/) {
            zeroLength++;
        } else {
            if(floatChars[i] == '.')
                i--;
            break;
        }
    }
    NSString *returnString;
    if(i == -1) {
        returnString = @"0";
    } else {
        returnString = [stringFloat substringToIndex:i+1];
    }
    return returnString;
}

- (NSString *) trimming {
    return [self stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
}

- (BOOL)isNumber {
    if ([[self stringByTrimmingCharactersInSet: [NSCharacterSet decimalDigitCharacterSet]]trimming].length >0) {
        return NO;
    }else{
        return YES;
    }
}

- (NSString *)urlEncode
{
    NSMutableString *output = [NSMutableString string];
    const unsigned char *source = (const unsigned char *)[self UTF8String];
    int sourceLen = (int)strlen((const char *)source);
    for(int i = 0; i < sourceLen; ++i)
    {
        const unsigned char thisChar = source[i];
        
        if(thisChar == ' ')
        {
            [output appendString:@"+"];
        }
        else if(thisChar == '.' || thisChar == '-' || thisChar == '_' || thisChar == '~' || (thisChar >= 'a' && thisChar <= 'z') || (thisChar >= 'A' && thisChar <= 'Z') || (thisChar >= '0' && thisChar <= '9'))
        {
            [output appendFormat:@"%c", thisChar];
        }
        else
        {
            [output appendFormat:@"%%%02X", thisChar];
        }
    }
    
    return output;
}


+ (BOOL)validateIDCardNumberLimitLength_18:(NSString *)value {
    
    if (![value isKindOfClass:[NSString class]]) {
        return NO;
    }
    
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSInteger length = 0;
    
    if (!value) {
        
        return NO;
        
    } else {
        
        length = value.length;
        
        
        
        if ( length !=18) {
            
            return NO;
            
        }
        
    }
    
    // 省份代码
    
    NSArray *areasArray =@[@"11", @"12", @"13", @"14", @"15", @"21", @"22", @"23", @"31", @"32", @"33", @"34", @"35", @"36", @"37", @"41", @"42", @"43", @"44", @"45", @"46", @"50", @"51", @"52", @"53", @"54", @"61", @"62", @"63", @"64", @"65", @"71", @"81", @"82", @"91"];
    
    
    
    NSString *valueStart2 = [value substringToIndex:2];
    
    BOOL areaFlag = NO;
    
    for (NSString *areaCode in areasArray) {
        
        if ([areaCode isEqualToString:valueStart2]) {
            
            areaFlag =YES;
            
            break;
            
        }
        
    }
    
    
    
    if (!areaFlag) {
        
        return false;
        
    }
    
    
    
    
    
    NSRegularExpression *regularExpression;
    
    NSUInteger numberofMatch;
    
    
    
    int year = 0;
    
    switch (length) {
            
        case 15:
            
            year = [value substringWithRange:NSMakeRange(6,2)].intValue +1900;
            
            
            
            if (year % 4 ==0 || (year % 100 ==0 && year % 4 ==0)) {
                
                
                
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"
                                     
                                                                         options:NSRegularExpressionCaseInsensitive
                                     
                                                                           error:nil];// 测试出生日期的合法性
                
            }else {
                
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"
                                     
                                                                         options:NSRegularExpressionCaseInsensitive
                                     
                                                                           error:nil];// 测试出生日期的合法性
                
            }
            
            numberofMatch = [regularExpression numberOfMatchesInString:value
                             
                                                               options:NSMatchingReportProgress
                             
                                                                 range:NSMakeRange(0, value.length)];
            
            
            
            if(numberofMatch > 0) {
                
                return YES;
                
            }else {
                
                return NO;
                
            }
            
        case 18:
            
            
            year = [value substringWithRange:NSMakeRange(6,4)].intValue;
            
            if (year % 4 ==0 || (year % 100 ==0 && year % 4 ==0)) {
                
                
                
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$"
                                     
                                                                         options:NSRegularExpressionCaseInsensitive
                                     
                                                                           error:nil];// 测试出生日期的合法性
                
            }else {
                
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$"
                                     
                                                                         options:NSRegularExpressionCaseInsensitive
                                     
                                                                           error:nil];// 测试出生日期的合法性
                
            }
            
            numberofMatch = [regularExpression numberOfMatchesInString:value
                             
                                                               options:NSMatchingReportProgress
                             
                                                                 range:NSMakeRange(0, value.length)];
            
            
            
            
            
            
            
            if(numberofMatch > 0) {
                
                int S = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7 + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9 + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10 + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5 + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8 + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4 + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2 + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6 + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
                
                int Y = S % 11;
                
                NSString *M = @"F";
                
                NSString *JYM = @"10X98765432";
                
                M = [JYM substringWithRange:NSMakeRange(Y,1)]; // 判断校验位
                
                if ([M isEqualToString:[value substringWithRange:NSMakeRange(17,1)].uppercaseString]) {
                    
                    return YES;// 检测ID的校验位
                    
                }else {
                    
                    return NO;
                    
                }
                
                
            }else {
                
                return NO;
                
            }
            
        default:
            
            return false;
            
    }
    
}

+(NSString*)beNotEmpty:(id)string{
    if ([string isKindOfClass:[NSString class]]) {
        if (string == nil || string == NULL ||
            [string isEqualToString:@"<null>"] ||
            [string isEqualToString:@"null"] ||
            [string isEqualToString:@"(null)"])
        {
            return @"";
        }
    }
    return string;
}


//自动计算文本宽度
+ (CGSize)sizeWidthWithString:(NSString *)string font:(UIFont *)font constraintHeight:(CGFloat)constraintHeight{
    CGSize linesSz;
    if (IS_IOS7LATER) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
        NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
        
        linesSz = [string boundingRectWithSize:CGSizeMake(MAXFLOAT, constraintHeight)
                                       options:NSStringDrawingUsesLineFragmentOrigin
                                    attributes:attributes context:nil].size;
    }else {
        
        linesSz = [string sizeWithFont:font constrainedToSize:CGSizeMake(MAXFLOAT, constraintHeight) lineBreakMode:NSLineBreakByCharWrapping];
    }
    
    return linesSz;
}

//自动计算文本高度
+ (CGSize)sizeHeightWithString:(NSString *)string font:(UIFont *)font constraintWidth:(CGFloat)constraintWidth{
    CGSize linesSz;
    if (IS_IOS7LATER) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
        NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
        
        linesSz = [string boundingRectWithSize:CGSizeMake(constraintWidth, MAXFLOAT)
                                       options:NSStringDrawingUsesLineFragmentOrigin
                                    attributes:attributes context:nil].size;
    }else {
        
        linesSz = [string sizeWithFont:font constrainedToSize:CGSizeMake(constraintWidth, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
    }
    
    return linesSz;
}



+ (NSString *)fourStarMobilePhoneFromOrign:(NSString *)orignMobil
{
    NSString *tempString = [orignMobil  stringByReplacingCharactersInRange:NSMakeRange(orignMobil.length-8,4) withString:@"****"];
    return tempString;
}

// 判定是否为表情字符
+ (BOOL)stringContainsEmoji:(NSString *)string {
    if ([NSString isBlankString:string]) return NO;
    NSString *subString;
    if (string.length>2) {
        subString = [string substringWithRange:NSMakeRange(string.length-2, 2)];
    } else {
        subString = string;
    }
    BOOL returnValue = NO;
    const unichar hs = [subString characterAtIndex:0];
    if (0xd800 <= hs && hs <= 0xdbff) {
        if (subString.length > 1) {
            const unichar ls = [subString characterAtIndex:1];
            const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
            if (0x1d000 <= uc && uc <= 0x1f77f) {
                returnValue = YES;
            }
        }
    }
    else if (subString.length > 1) {
        const unichar ls = [subString characterAtIndex:1];
        if (0xd800 <= ls && ls <= 0xdbff) {
            returnValue = NO;
        } else {
            returnValue = YES;
        }
    }
    else {
        if (0x2100 <= hs && hs <= 0x27ff) {
            returnValue = YES;
        } else if (0x2B05 <= hs && hs <= 0x2b07) {
            returnValue = YES;
        } else if (0x2934 <= hs && hs <= 0x2935) {
            returnValue = YES;
        } else if (0x3297 <= hs && hs <= 0x3299) {
            returnValue = YES;
        } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
            returnValue = YES;
        }
    }
    return returnValue;
}
@end
