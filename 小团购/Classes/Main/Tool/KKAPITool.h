//
//  KKAPITool.h
//  小团购
//
//  Created by Imanol on 15/9/16.
//  Copyright (c) 2015年 Imanol. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KKAPITool : NSObject<NSCopying>
-(void)requset:(NSString*)url params:(NSDictionary*)params  success:(void(^)(id json))success failure:(void(^)(NSError *error))failure;

+(instancetype)shareKKAPITool;
@end
