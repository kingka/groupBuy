//
//  KKSearchViewController.m
//  小团购
//
//  Created by Imanol on 15/10/13.
//  Copyright (c) 2015年 Imanol. All rights reserved.
//

#import "KKSearchViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "UIView+AutoLayout.h"
#import "UIView+Extension.h"
#import "KKDealTool.h"
#import "KKFindDealParam.h"
#import "KKMetaDataTool.h"
#import "MBProgressHUD+KK.h"
#import "MJRefresh.h"

@interface KKSearchViewController ()<UISearchBarDelegate>

@property(strong, nonatomic) KKFindDealParam *lastParam;
@property(assign, nonatomic) int totalCount;
@property(weak, nonatomic) UISearchBar *searchBar;
@end

@implementation KKSearchViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupNav];
    [self setupRefresh];
}

-(void)setupRefresh{
    
    self.collectionView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreInfo)];
}

-(void)loadMoreInfo{
    
    //param
    KKFindDealParam *param = [[KKFindDealParam alloc]init];
    param.keyword = self.searchBar.text;
    param.city = [[KKMetaDataTool sharedMetaDataTool] selectedCity].name;
    param.page = @([self.lastParam.page intValue] + 1);
    
    
    [KKDealTool findDeals:param success:^(KKFindDealResult *result) {
        //param timeOUT
        if(self.lastParam != param) return ;
        [self.deals addObjectsFromArray:result.deals];
        //end footer refresh
        [self.collectionView.footer endRefreshing];
        //reload
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
        param.page = @(param.page.intValue - 1);
        //end footer refresh
        [self.collectionView.footer endRefreshing];
        //show error
        [MBProgressHUD showError:@"加载失败"];
    }];
    
    self.lastParam = param;

}

-(void)setupNav{
    
    //back barItem
     UIBarButtonItem *backItem = [UIBarButtonItem itemWithImageName:@"icon_back" highlightImageName:@"icon_back_highlighted" target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = backItem;
    
    UIView *searchView = [[UIView alloc]init];
    searchView.width = 400;
    searchView.height = 20;
    self.navigationItem.titleView = searchView;
   
    
    UISearchBar *searchBar = [[UISearchBar alloc]init];
    [searchBar setBackgroundImage:[UIImage imageNamed:@"bg_login_textfield"]];
    [searchView addSubview:searchBar];
    [searchBar autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    searchBar.delegate = self;
    searchBar.placeholder = @"请输入关键词";
    [searchBar becomeFirstResponder];
    
    self.searchBar = searchBar;
    
}

-(void)back{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -override parent method
-(NSString *)empytIcon{
    
    return @"icon_deals_empty";
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    //hide footer when no more info
    if( self.totalCount == self.deals.count){
        [self.collectionView.footer setHidden:YES];
    }
    return [super collectionView:collectionView numberOfItemsInSection:section];
}

#pragma mark - UISearchBarDelegate
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [searchBar endEditing:YES];
    //hud
    [MBProgressHUD showMessage:@"正在搜索" toView:self.navigationController.view];
    //param
    KKFindDealParam *param = [[KKFindDealParam alloc]init];
    param.keyword = searchBar.text;
    param.city = [[KKMetaDataTool sharedMetaDataTool] selectedCity].name;
    param.page = @1;
    
    //call server
    [KKDealTool findDeals:param success:^(KKFindDealResult *result) {
        //hide hud
        [MBProgressHUD hideAllHUDsForView:self.navigationController.view animated:YES];
        //param timeOUT
        if(self.lastParam != param) return ;
        //totalCount
        self.totalCount = result.total_count;
        //remove pre data
        [self.deals removeAllObjects];
        [self.deals addObjectsFromArray:result.deals];
        //reload
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
        //hide hud
        [MBProgressHUD hideAllHUDsForView:self.navigationController.view animated:YES];
        //param timeOUT
        if(self.lastParam != param) return ;
        //show error
        [MBProgressHUD showError:@"加载失败"];
    }];
    
    //赋值
    self.lastParam = param;
}


@end
