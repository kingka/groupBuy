//
//  KKSort.h
//  小团购
//
//  Created by Imanol on 15/9/22.
//  Copyright (c) 2015年 Imanol. All rights reserved.
//

#import <Foundation/Foundation.h>

/* 1:默认，2:价格低优先，3:价格高优先，4:购买人数多优先，5:最新发布优先，6:即将结束优先，7:离经纬度坐标距离近优先 */
typedef enum {
    KKSortValueDefault = 1, // 默认排序
    KKSortValueLowPrice, // 价格最低
    KKSortValueHighPrice, // 价格最高
    KKSortValuePopular, // 人气最高
    KKSortValueLatest, // 最新发布
    KKSortValueOver, // 即将结束
    KKSortValueClosest // 离我最近
} KKSortValue;


@interface KKSort : NSObject


@property (assign, nonatomic) int value;
@property (copy, nonatomic) NSString *label;
@end
