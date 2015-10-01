//
//  KKCitiesController.m
//  小团购
//
//  Created by Imanol on 9/30/15.
//  Copyright (c) 2015 Imanol. All rights reserved.
//

#import "KKCitiesController.h"
#import "KKCitiesResultController.h"
#import "UIView+AutoLayout.h"
#import "KKMetaDataTool.h"
#import "KKCityGroup.h"
#import "KKDealsConst.h"

@interface KKCitiesController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
- (IBAction)closeClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) KKCitiesResultController *citiesVC;
@property (copy, nonatomic) NSArray *cityGroups;

@end

@implementation KKCitiesController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.sectionIndexColor = [UIColor blackColor];
}

- (IBAction)closeClick:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - lazyLoading

-(NSArray *)cityGroups{
    
    if(_cityGroups== nil){
        
        self.cityGroups = [KKMetaDataTool sharedMetaDataTool].cityGroups;
    }
    
    return _cityGroups;
}

-(KKCitiesResultController *)citiesVC{
    
    if(_citiesVC == nil){
        
        KKCitiesResultController *citiesVC = [[KKCitiesResultController alloc]init];
        self.citiesVC = citiesVC;
        [self addChildViewController:citiesVC];
    }
    
    return _citiesVC;
}

#pragma mark - searchBarDelegate
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{

    searchBar.backgroundImage = [UIImage imageNamed:@"bg_login_textfield_hl"];
    searchBar.showsCancelButton = YES;
    self.navBarTopLc.constant = -62;
    [UIView animateWithDuration:0.25 animations:^{
        // 让约束执行动画
        [self.view layoutIfNeeded];
        // 让遮盖慢慢出
        self.coverBtn.alpha = 0.5;
    }];
    
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    
    searchBar.backgroundImage = [UIImage imageNamed:@"bg_login_textfield"];
    searchBar.showsCancelButton = NO;
    self.navBarTopLc.constant = 0;
    [UIView animateWithDuration:0.25 animations:^{
        // 让约束执行动画
        [self.view layoutIfNeeded];
        // 让遮盖慢慢出
        self.coverBtn.alpha = 0.0;
    }];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
    searchBar.text = nil;
    [self.citiesVC.view removeFromSuperview];
    searchBar.showsCancelButton = NO;
    self.coverBtn.alpha = 0.0;
    [searchBar endEditing:YES];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{

#warning first to remove citiesVC.view is to make sure that add autoLayout constrains many times will not occur problem
    
    [self.citiesVC.view removeFromSuperview];
    if(searchText.length > 0){
        [self.view addSubview:self.citiesVC.view];
        [_citiesVC.view autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
        [_citiesVC.view autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.coverBtn];
            
    }
    self.citiesVC.searchText = searchText;
}

#pragma mark - tableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    KKCityGroup *group = self.cityGroups[section];
    return group.cities.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.cityGroups.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID =@"kkcity";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil){
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    KKCityGroup *group = self.cityGroups[indexPath.section];
    cell.textLabel.text = group.cities[indexPath.row];
    
    return cell;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    KKCityGroup *group = self.cityGroups[section];
    return group.title;
}

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    
    // 将cityGroups数组中所有元素的title属性值取出来，放到一个新的数组
    return [self.cityGroups valueForKeyPath:@"title"];
}
#pragma mark - tableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    KKCityGroup *cityGroup = self.cityGroups[indexPath.section];
    NSString *cityName = cityGroup.cities[indexPath.row];
    KKCity *city = [[KKMetaDataTool sharedMetaDataTool] cityWithName:cityName];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    //sent Notification
    [KKNotificationCenter postNotificationName:KKCityDidSelectNotification object:nil userInfo:@{KKSelectedCity:city}];
    
}
#pragma mark - Private Methods
- (IBAction)coverClick:(UIButton *)sender {
    
    [self.searchBar endEditing:YES];
    self.navBarTopLc.constant = 0.0;
    [UIView animateWithDuration:0.25 animations:^{
        // 让约束执行动画
        [self.view layoutIfNeeded];
        // 让遮盖慢慢出
        self.coverBtn.alpha = 0.0;
    }];
}
@end
