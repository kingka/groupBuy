//
//  KKMetaDataTool.m
//  小团购
//
//  Created by Imanol on 15/9/22.
//  Copyright (c) 2015年 Imanol. All rights reserved.
//

#import "KKMetaDataTool.h"
#import "KKCategory.h"
#import "KKCity.h"
#import "KKCityGroup.h"
#import "KKRegion.h"
#import "KKSort.h"
#import "MJExtension.h"

@interface KKMetaDataTool (){
    
    /** 所有的分类 */
    NSArray *_categories;
    /** 所有的城市 */
    NSArray *_cities;
    /** 所有的城市组 */
    NSArray *_cityGroups;
    /** 所有的排序 */
    NSArray *_sorts;
}

@end

@implementation KKMetaDataTool
KKSingletonM(MetaDataTool);

-(NSArray *)categories{
    
    if(_categories == nil){
        
        _categories = [KKCategory objectArrayWithFilename:@"categories.plist"];
    }
    return _categories;
}



- (NSArray *)cityGroups
{
    if (!_cityGroups) {
        _cityGroups = [KKCityGroup objectArrayWithFilename:@"cityGroups.plist"];
    }
    return _cityGroups;
}

- (NSArray *)cities
{
    if (!_cities) {
        _cities = [KKCity objectArrayWithFilename:@"cities.plist"];
    }
    return _cities;
}

- (NSArray *)sorts
{
    if (!_sorts) {
        _sorts = [KKSort objectArrayWithFilename:@"sorts.plist"];
    }
    return _sorts;
}

@end
