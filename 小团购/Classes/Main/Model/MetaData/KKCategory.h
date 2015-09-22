//
//  KKCategory.h
//  小团购
//
//  Created by Imanol on 15/9/22.
//  Copyright (c) 2015年 Imanol. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KKCategory : NSObject
/** 类别名称 */
@property (copy, nonatomic) NSString *name;
/** 大图标 */
@property (copy, nonatomic) NSString *icon;
/** 大图标(高亮) */
@property (copy, nonatomic) NSString *highlighted_icon;
/** 小图标 */
@property (copy, nonatomic) NSString *small_icon;
/** 小图标(高亮) */
@property (copy, nonatomic) NSString *small_highlighted_icon;
/** 子类别 */
@property (strong, nonatomic) NSArray *subcategories;
@end
