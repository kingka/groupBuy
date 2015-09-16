//
//  KKDealTool.m
//  小团购
//
//  Created by Imanol on 15/9/16.
//  Copyright (c) 2015年 Imanol. All rights reserved.
//

#import "KKDealTool.h"
#import "KKAPITool.h"
#import "MJExtension.h"

@implementation KKDealTool

+(void)requst:(NSString *)url params:(KKDealParam *)params success:(void (^)(KKDealResult *))success failure:(void (^)(NSError *))failure{
    
    KKAPITool *tool = [KKAPITool shareKKAPITool];
    [tool requset:url params:@"" success:^(id json) {
        
    } failure:^(NSError *error) {
        
    }];
}
@end
