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
#import "KKDealsConst.h"

@interface KKMetaDataTool (){
    
    /** 所有的分类 */
    NSArray *_categories;
    /** 所有的城市 */
    NSArray *_cities;
    /** 所有的排序 */
    NSArray *_sorts;
}

@property(strong, nonatomic)NSMutableArray *selectedCityNames;
@end

@implementation KKMetaDataTool
KKSingletonM(MetaDataTool);

- (NSMutableArray *)selectedCityNames
{
    if (!_selectedCityNames) {
        _selectedCityNames = [NSMutableArray arrayWithContentsOfFile:KKSelectedCityNamesFile];
        NSLog(@"cityNames:%@",_selectedCityNames);
        if (!_selectedCityNames) {
            _selectedCityNames = [NSMutableArray array];
        }
    }
    return _selectedCityNames;
}

-(NSArray *)categories{
    
    if(_categories == nil){
        
        _categories = [KKCategory objectArrayWithFilename:@"categories.plist"];
    }
    return _categories;
}



- (NSArray *)cityGroups
{
    NSMutableArray *cityGroups = [NSMutableArray array];
    //
    if(self.selectedCityNames.count){
    
        KKCityGroup *lastSelectedGroup = [[KKCityGroup alloc]init];
        lastSelectedGroup.title = @"最近";
        lastSelectedGroup.cities = self.selectedCityNames;
        [cityGroups addObject:lastSelectedGroup];
    }
   
    //plist
    NSArray *plistCityGroups = [KKCityGroup objectArrayWithFilename:@"cityGroups.plist"];
    [cityGroups addObjectsFromArray:plistCityGroups];

    return cityGroups;
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

-(KKCity *)cityWithName:(NSString *)name{
    
    for(KKCity *city in self.cities){
        
        if([city.name isEqualToString:name]){
            
            return city;
        }
    }
    return nil;
}

-(void)saveSelectedCityNames:(NSString *)cityName{
    
    [self.selectedCityNames removeObject:cityName];
    [self.selectedCityNames insertObject:cityName atIndex:0];
    
    [self.selectedCityNames writeToFile:KKSelectedCityNamesFile atomically:YES];

}

-(void)saveSelectedSort:(KKSort *)sort{
    
    if (sort == nil) return;
    [NSKeyedArchiver  archiveRootObject:sort toFile:KKSelectedSortsFile];
}

-(void)saveSelectedRegion:(KKRegion *)region{

    if (region == nil) return;
    [NSKeyedArchiver  archiveRootObject:region toFile:KKSelectedRegionsFile];
}

-(void)saveSelectedCategory:(KKCategory *)category{

    if (category == nil) return;
    [NSKeyedArchiver  archiveRootObject:category toFile:KKSelectedCategoriesFile];
}

-(KKCity *)selectedCity{
    
    NSString *cityName = [self.selectedCityNames firstObject];
    KKCity *city = [self cityWithName:cityName];
    if(city == nil){
        
        city = [self cityWithName:@"深圳"];
    }
    return city;
}

-(KKSort *)selectedSort{
    
    KKSort *sort = [NSKeyedUnarchiver unarchiveObjectWithFile:KKSelectedSortsFile];
    if (sort == nil) {
        //if no then set default value
        sort = [self.sorts firstObject];
    }
    
    return sort;
}

@end
