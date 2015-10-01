//
//  KKCitiesResultController.m
//  小团购
//
//  Created by Imanol on 10/1/15.
//  Copyright (c) 2015 Imanol. All rights reserved.
//

#import "KKCitiesResultController.h"
#import "KKDealsConst.h"

@interface KKCitiesResultController ()

@property (strong, nonatomic)NSArray *resultCities;
@end

@implementation KKCitiesResultController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(NSArray *)resultCities{
//    
//    if(_resultCities == nil){
//        
//        self.resultCities = [NSArray array];
//    }
//    
//    return _resultCities;
//}
-(void)setSearchText:(NSString *)searchText{
    
    _searchText = searchText;
    
//    for(KKCity *city in self.cities){
//        BOOL condiction1 = [city.pinYin rangeOfString:searchText].length>0;
//        BOOL condiction2 = [city.name rangeOfString:searchText].length>0;
//        BOOL condiction3 = [city.pinYinHead rangeOfString:searchText].length>0;
//        
//        if(condiction1 || condiction2 || condiction3){
//            
//            [self.resultCities addObject:city];
//        }
//    }
    NSString *lowerText = searchText.lowercaseString;
    //第二种查询方法 ：NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name.lowercaseString contains %@ or pinYin.lowercaseString contains %@ or pinYinHead.lowercaseString contains %@",lowerText,lowerText,lowerText];
    //这里取到的是city 模型
    self.resultCities = [self.cities filteredArrayUsingPredicate:predicate];
    [self.tableView reloadData];
    
}

-(NSArray *)cities{
    
    if(_cities == nil){
        
        self.cities = [KKMetaDataTool sharedMetaDataTool].cities;
    }
    return _cities;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return  self.resultCities.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID =@"kkresultcity";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil){
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    KKCity *city = self.resultCities[indexPath.row];
    cell.textLabel.text = city.name;
    
    return cell;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return [NSString stringWithFormat:@"共有%lu个搜索结果", (unsigned long)self.resultCities.count];
}

#pragma mark - tableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    KKCity *city = self.resultCities[indexPath.row];
    [KKNotificationCenter postNotificationName:KKCityDidSelectNotification object:nil userInfo:@{KKSelectedCity:city}];
}

@end
