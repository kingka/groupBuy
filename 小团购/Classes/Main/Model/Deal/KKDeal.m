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

- (NSNumber *)dealNumber:(NSNumber *)sourceNumber
{
    NSString *str = [sourceNumber description];
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^\\d+\\.\\d{2}" options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSArray *results = [regex matchesInString:str options:NSMatchingReportCompletion range:NSMakeRange(0, str.length)];
    
    for (NSTextCheckingResult *result in results) {
        NSLog(@"%@", [str substringWithRange:result.range]);
    }
    
    // 小数点的位置
    NSUInteger dotIndex = [str rangeOfString:@"."].location;
    if (dotIndex != NSNotFound && str.length - dotIndex > 2) { // 小数超过2位
        str = [str substringToIndex:dotIndex + 3];
    }
    
    NSNumberFormatter *fmt = [[NSNumberFormatter alloc] init];
    return [fmt numberFromString:str];
}
-(void)setCurrent_price:(NSNumber *)current_price{
    
    _current_price = [self dealNumber:current_price];
}

-(void)setList_price:(NSNumber *)list_price{
    
    _list_price = [self dealNumber:list_price];
}
@end
