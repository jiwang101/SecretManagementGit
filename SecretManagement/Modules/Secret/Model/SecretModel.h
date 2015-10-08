//
//  SecretModel.h
//  SecretManagement
//
//  Created by ssf-xiong on 15/9/30.
//  Copyright (c) 2015年 ssf-xiong. All rights reserved.
//

#import "JSONModel.h"

@interface SecretModel : JSONModel
/**
 *  图片
 */
@property (nonatomic, strong) NSString *imageName;
/**
 *  标题
 */
@property (nonatomic, strong) NSString *titleString;
/**
 *  描述
 */
@property (nonatomic, strong) NSString *detailString;
/**
 *  秘密
 */
@property (nonatomic, strong) NSString *secretString;

/**
 *  获取容量列表
 *
 *  @param success 返回数据集合
 *  @param failure 错误信息
 */
+ (void)getSecretListSuccess:(void (^)(NSArray *secretList))success failure:(void (^)(NSError *error))failure;

/**
 *  读取安全Key
 *
 *  @param success 返回安全KEY
 *  @param failure 错误信息
 */
+ (void)getSecretSafeKey:(void (^)(NSString *safeKey))success failure:(void (^)(NSError *error))failure;

/**
 *  更新安全Key
 *
 *  @param safeKey 安全Key
 *  @param success 是否成功
 *  @param failure 错误信息
 */
+ (void)updateSafeKey:(NSString *)safeKey success:(void (^)(BOOL isSuccess))success failure:(void (^)(NSError *error))failure;

/**
 *  更新秘密
 *
 *  @param secret  秘密内容
 *  @param success 是否成功
 *  @param failure 错误信息
 */
+ (void)updateSecret:(SecretModel *)secret success:(void (^)(BOOL isSuccess))success failure:(void (^)(NSError *error))failure;

/**
 *  检查秘密标题是否存在
 *
 *  @param secretKey 秘密标题
 *
 *  @return yes 存在 no 不存在
 */
+ (BOOL)checkSecret:(NSString *)secretKey;
@end
