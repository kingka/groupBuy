//
//  KKDealTool.h
//  小团购
//
//  Created by Imanol on 15/9/16.
//  Copyright (c) 2015年 Imanol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KKFindDealParam.h"
#import "KKFindDealResult.h"
#import "KKGetSingleDealParam.h"
#import "KKGetSingleDealResult.h"

@interface KKDealTool : NSObject

+(void)findDeals:(KKFindDealParam* )params success:(void(^)(KKFindDealResult *result))success failure:(void(^)(NSError *error))failure;


+(void)getSingleDeals:(KKGetSingleDealParam* )params success:(void(^)(KKGetSingleDealResult *result))success failure:(void(^)(NSError *error))failure;
@end
