//
//  KKGetSingleDealResult.h
//  小团购
//
//  Created by Imanol on 15/9/17.
//  Copyright (c) 2015年 Imanol. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KKGetSingleDealResult : NSObject
/** 本次API访问所获取的单页团购数量 */
@property (assign, nonatomic) int count;
/** 所有的团购 */
@property (strong, nonatomic) NSArray *deals;
@end
