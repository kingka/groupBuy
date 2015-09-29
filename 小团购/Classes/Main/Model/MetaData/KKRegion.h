//
//  KKRegion.h
//  小团购
//
//  Created by Imanol on 15/9/22.
//  Copyright (c) 2015年 Imanol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KKDropDownMenu.h"

@interface KKRegion : NSObject<KKDropDownMenuItem>
/** 区域名称 */
@property (copy, nonatomic) NSString *name;
/** 子区域 */
@property (strong, nonatomic) NSArray *subregions;

@end
