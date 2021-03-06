//
//  KKMetaDataTool.h
//  小团购
//
//  Created by Imanol on 15/9/22.
//  Copyright (c) 2015年 Imanol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KKSingleton.h"
#import "KKCity.h"
@class KKSort;
@class KKRegion;
@class KKCategory;
@interface KKMetaDataTool : NSObject
KKSingletonH(MetaDataTool)

/**
 *  所有的分类
 */
@property (strong, nonatomic, readonly) NSArray *categories;
/**
 *  所有的城市
 */
@property (strong, nonatomic, readonly) NSArray *cities;
/**
 *  所有的城市组
 */
@property (strong, nonatomic, readonly) NSArray *cityGroups;
/**
 *  所有的排序
 */
@property (strong, nonatomic, readonly) NSArray *sorts;

-(KKCity*)cityWithName:(NSString *)name;

-(void)saveSelectedCityNames:(NSString*)cityName;
-(void)saveSelectedSort:(KKSort*)sort;
-(void)saveSelectedRegion:(KKRegion*)region;
-(void)saveSelectedCategory:(KKCategory*)category;

-(KKSort *)selectedSort;
-(KKRegion *)selectedRegion;
-(KKCategory *)selectedCategory;
-(KKCity *)selectedCity;
@end
