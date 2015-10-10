//
//  KKLocalTool.h
//  小团购
//
//  Created by Imanol on 15/10/10.
//  Copyright (c) 2015年 Imanol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KKSingleton.h"
#define KKHistoryDealsFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"history_deals.data"]

@class KKDeal;
@interface KKLocalTool : NSObject
KKSingletonH(LocalTool)
@property (strong, nonatomic,readonly) NSMutableArray *historyArray;
-(void)saveHistoryDeal:(KKDeal *)deal;

@end
