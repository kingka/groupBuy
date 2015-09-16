//
//  KKDealTool.h
//  小团购
//
//  Created by Imanol on 15/9/16.
//  Copyright (c) 2015年 Imanol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KKDealParam.h"
#import "KKDealResult.h"

@interface KKDealTool : NSObject

+(void)requst:(NSString*)url params:(KKDealParam* )params success:(void(^)(KKDealResult *result))success failure:(void(^)(NSError *error))failure;
@end
