//
//  NSString+Util.h
//  GoGo
//
//  Created by GuoChengHao on 14-4-21.
//  Copyright (c) 2014年 Maxicn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Util)
/**
 判断字符串是否为空
 */
+(BOOL) isBlankString:(NSString *)string;

/**
 判断是否为可用电话号码
 */
- (BOOL)validateMobile;//:(NSString *)mobileNum;

/**
 * 把数组字典等转成json字符串
 */
+ (NSString *)toJSONString:(id)theData;

/**
 * 把json字符串转成数组或字典
 */
- (id)JSONValue;


/**
 * 验证身份证号码
 */
+ (BOOL)validateIDCardNumber:(NSString *)value;

//限制只验证18位置
+ (BOOL)validateIDCardNumberLimitLength_18:(NSString *)value;

/**
 * 验证港澳台通行证
 */
+ (BOOL)validateHKIDCardNumber:(NSString *)value;

/**
 * 验证台湾通行证
 */
+ (BOOL)validateTWIDCardNumber:(NSString *)value;

/**
 *	@brief	验证登录密码
 *
 *	@param 	value 	值
 *  @param 	mobile 	账号
 *	@return	yes为通过
 */
+ (NSString *)validLoginPwd:(NSString *)value andMobile:(NSString *)mobile;

/**
 * @brief 验证支付密码
 * @param pwd 支付密码
 * @return 4、合法
 *
 *
 */
+ (NSInteger)appValidPaymentPwd:(NSString *)pwd;

//设置字体大小的接口
+ (NSMutableAttributedString *)nameFont:(UIFont *)font name:(NSString *)name string:(NSString *)string;

//设置名字为制定颜色的接口
+ (NSMutableAttributedString *)nameColor:(UIColor *)color name:(NSString *)name string:(NSString *)string;

/**
 *	@brief	32位md5加密
 *
 *	@return	md5加密串
 */
- (NSString *)MD5;


/**
 *	@brief	 RSA 加密
 *   publicKey 公钥
 *	@return	 RSA加密串
 */
-(NSString*)RSA:(NSString *)publicKey;

/**
 *	@brief	保留小数有效位
 *
 *	@param 	stringFloat 	原数字
 *
 *	@return	去掉0后的数
 */
+ (NSString *)changeFloat:(NSString *)stringFloat;


/* 判断字符串是否是数字 */
- (BOOL)isNumber ;

/* URL编码 */
- (NSString *)urlEncode;

/* 控制string不为nil */
+(NSString*)beNotEmpty:(id)str;


//自动计算文本宽度
+ (CGSize)sizeWidthWithString:(NSString *)string font:(UIFont *)font constraintHeight:(CGFloat)constraintHeight;

//自动计算文本高度
+ (CGSize)sizeHeightWithString:(NSString *)string font:(UIFont *)font constraintWidth:(CGFloat)constraintWidth;

//添加四颗星的手机号
+ (NSString *)fourStarMobilePhoneFromOrign:(NSString *)orignMobil;

// 判定是否为表情字符
+ (BOOL)stringContainsEmoji:(NSString *)string;
@end
