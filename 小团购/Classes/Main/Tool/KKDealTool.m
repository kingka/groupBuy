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

+(void)findDeals:(KKFindDealParam *)params success:(void (^)(KKFindDealResult *))success failure:(void (^)(NSError *))failure{
    
    KKAPITool *tool = [KKAPITool shareKKAPITool];
    [tool requset:@"v1/deal/find_deals" params:params.keyValues success:^(id json) {
        if(success){
            KKFindDealResult *dealResult = [KKFindDealResult objectWithKeyValues:json];
            success(dealResult);
        }
        
    } failure:^(NSError *error) {
        
    }];
}
@end
