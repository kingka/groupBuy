//
//  KKDeal.m
//  小团购
//
//  Created by Imanol on 15/9/16.
//  Copyright (c) 2015年 Imanol. All rights reserved.
//

#import "KKDeal.h"
#import "KKBusiness.h"
#import "MJExtension.h"

@implementation KKDeal
MJCodingImplementation

+(NSDictionary *)objectClassInArray{
    return @{@"businesses" : [KKBusiness class]};
}

+(NSDictionary *)replacedKeyFromPropertyName{
    return @{@"desc" : @"description"};
}

-(BOOL)isEqual:(KKDeal *)other{

    return [self.deal_id isEqualToString:other.deal_id];
}
@end
