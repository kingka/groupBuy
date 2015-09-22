//
//  KKGetSingleDealResult.m
//  小团购
//
//  Created by Imanol on 15/9/17.
//  Copyright (c) 2015年 Imanol. All rights reserved.
//

#import "KKGetSingleDealResult.h"
#import "MJExtension.h"
#import "KKDeal.h"
@implementation KKGetSingleDealResult

+(NSDictionary *)objectClassInArray{
    return @{@"deals" : [KKDeal class]};
}
@end
