//
//  SecretModel.m
//  SecretManagement
//
//  Created by ssf-xiong on 15/9/30.
//  Copyright (c) 2015年 ssf-xiong. All rights reserved.
//

#import "SecretModel.h"
#import "ConstantDefined.h"
#import <UICKeyChainStore.h>
#import "NSString+Util.h"

static NSString *DEFAULT_SERVICE = @"SecretService";
@implementation SecretModel
+ (void)getSecretListSuccess:(void (^)(NSArray *secretList))success failure:(void (^)(NSError *error))failure{
//    [UICKeyChainStore removeAllItemsForService:DEFAULT_SERVICE];
    NSError *error = nil;
    NSString *secretsString = [UICKeyChainStore stringForKey:kSecretList service:DEFAULT_SERVICE error:&error];
    if (error) {
        if (failure) {
            failure(error);
        }
    }else{
        NSArray *secrets = [secretsString componentsSeparatedByString:@"|"];
        NSMutableArray *secretList = [NSMutableArray array];
        for (NSString *secretKey in secrets) {
            NSError *secretError = nil;
            NSString *secretString = [UICKeyChainStore stringForKey:secretKey service:DEFAULT_SERVICE error:&secretError];
            if (!secretError) {
                NSError *secretJsonError = nil;
                SecretModel *model = [[SecretModel alloc] initWithString:secretString error:&secretJsonError];
                if (!secretJsonError) {
                    [secretList addObject:model];
                }
            }
        }
        success(secretList);
    }
}
+ (NSString *)getSecretSafeKey{
    NSError *error = nil;
    NSString *secretsString = [UICKeyChainStore stringForKey:kSecretSafeKey service:DEFAULT_SERVICE error:&error];
    return secretsString;
}
+ (void)updateSafeKey:(NSString *)safeKey success:(void (^)(BOOL))success failure:(void (^)(NSError *))failure{
    NSError *error = nil;
    BOOL isSuccess = [UICKeyChainStore setString:safeKey forKey:kSecretSafeKey service:DEFAULT_SERVICE error:&error];
    if (error) {
        if (failure) {
            failure(error);
        }
    }else{
        success(isSuccess);
    }
}
+(void)updateSecret:(SecretModel *)secret success:(void (^)(BOOL))success failure:(void (^)(NSError *))failure{
    NSError *error = nil;
    //先保存内容 再保存列表
    BOOL isSuccess = [UICKeyChainStore setString:[secret toJSONString] forKey:[secret.titleString MD5] service:DEFAULT_SERVICE error:&error];
    if (error) {
        if (failure) {
            failure(error);
        }
    }else{
        if (isSuccess) {
            //判断列表是否已经存在
            BOOL isHave = [self checkSecret:secret.titleString];
            if (!isHave) {
                //如果不存在 添加到末尾
                NSString *secretsString = [UICKeyChainStore stringForKey:kSecretList service:DEFAULT_SERVICE error:nil];
                NSString *newSecretsString = [NSString stringWithFormat:@"%@|%@",secretsString,[secret.titleString MD5]];
                if ([newSecretsString hasPrefix:@"|"]) {
                    newSecretsString = [newSecretsString substringFromIndex:1];
                }
                isSuccess = [UICKeyChainStore setString:newSecretsString forKey:kSecretList service:DEFAULT_SERVICE error:&error];
            }
            
        }
        success(isSuccess);
    }
}
+ (void)deleteSecret:(SecretModel *)secret success:(void (^)(BOOL))success failure:(void (^)(NSError *))failure{
    NSString *secretsString = [UICKeyChainStore stringForKey:kSecretList service:DEFAULT_SERVICE error:nil];
    secretsString = [secretsString stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"|%@",[secret.titleString MD5]] withString:@""];
    secretsString = [secretsString stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@|",[secret.titleString MD5]] withString:@""];
    
    NSError *error = nil;
    BOOL isSuccess = [UICKeyChainStore setString:@"" forKey:[secret.titleString MD5] service:DEFAULT_SERVICE error:&error];
    if (error) {
        if (failure) {
            failure(error);
        }
    }else{
        if (success) {
            success(isSuccess);
        }
    }

}
+(BOOL)checkSecret:(NSString *)secretKey{
    BOOL isHave = NO;
    NSString *secretsString = [UICKeyChainStore stringForKey:kSecretList service:DEFAULT_SERVICE error:nil];
    for (NSString *secrets in [secretsString componentsSeparatedByString:@"|"]) {
        if ([secrets isEqualToString:[secretKey MD5]]) {
            isHave = YES;
            break;
        }
    }
    return isHave;
}

#pragma mark - private
- (NSError *)formatError:(NSUInteger)code message:(NSString *)message{
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    [userInfo setObject:message forKey:NSLocalizedFailureReasonErrorKey];
    NSError *formattedError = [[NSError alloc] initWithDomain:NSOSStatusErrorDomain code:code userInfo:userInfo];
    return formattedError;
}
+(NSArray *)getSecretList{
    //    [UICKeyChainStore stringForKey:mobile service:DEFAULT_SERVICE error:&error];
    //    [UICKeyChainStore setString:[passModel toJSONString] forKey:mobile service:DEFAULT_SERVICE error:&error];
    //    [UserDataModel arrayOfModelsFromDictionaries:array error:&error];
    return nil;
}
@end
