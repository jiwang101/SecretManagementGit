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
