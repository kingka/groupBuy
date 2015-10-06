//
//  KKDealsViewController.m
//  小团购
//
//  Created by Imanol on 15/9/18.
//  Copyright (c) 2015年 Imanol. All rights reserved.
//

#import "KKDealsViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "KKCategoriesVC.h"
#import "KKRegionVC.h"
#import "KKSortVC.h"
#import "KKCity.h"
#import "KKRegion.h"
#import "KKCategory.h"
#import "KKDealsConst.h"
#import "KKSort.h"
#import "KKFindDealParam.h"
#import "KKDealTool.h"
#import "MJExtension.h"
#import "KKDealCell.h"
#import "EmptyView.h"
#import <MJRefresh.h>
#import "MBProgressHUD+KK.h"
#import "KKDetailController.h"
#import "KKMetaDataTool.h"


@interface KKDealsViewController()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(strong, nonatomic)KKSort *selectedSort;
@property(strong, nonatomic)KKCity *selectedCity;
@property(strong, nonatomic)KKRegion *selectedRegion;
@property(strong, nonatomic)NSString *selectedSubRegion;
@property(strong, nonatomic)KKCategory *selectedCategory;
@property(strong, nonatomic)NSString *selectedSubCategory;
@property(strong, nonatomic)NSMutableArray *deals;
@property(weak, nonatomic)EmptyView *emptyView;
@property(strong, nonatomic)KKFindDealParam *lastFindDealParam;
@property(assign, nonatomic)int totalNumber;
@end

@implementation KKDealsViewController

#pragma mark - lazy loading
-(EmptyView *)emptyView{
    
    if (_emptyView == nil) {
        EmptyView *emptyView = [EmptyView emptyView];
        //emptyView.image = [UIImage imageNamed:@"icon_deals_empty"];
        [self.view insertSubview:emptyView belowSubview:self.collectionView];
        self.emptyView = emptyView;
    }
    return _emptyView;
}

-(NSMutableArray *)deals{
    
    if(_deals == nil){
        
        self.deals = [NSMutableArray array];
    }
    return _deals;
}

-(UIPopoverController *)categoryPC{
    
    if(_categoryPC == nil){
        KKCategoriesVC *VC = [[KKCategoriesVC alloc]init];
        self.categoryPC = [[UIPopoverController alloc]initWithContentViewController:VC];
        
    }
    return _categoryPC;
}

-(UIPopoverController *)regionPC{

    if(_regionPC == nil){
        KKRegionVC *VC = [[KKRegionVC alloc]init];
        self.regionPC = [[UIPopoverController alloc]initWithContentViewController:VC];
        
        __weak typeof(self) viewController = self;
        VC.changeCityBlock = ^(){
            [viewController.regionPC dismissPopoverAnimated:YES];
        };
    }
    return _regionPC;
}

-(UIPopoverController *)sortPC{
    
    if(!_sortPC){
        KKSortVC *VC = [[KKSortVC alloc]init];
        self.sortPC = [[UIPopoverController alloc]initWithContentViewController:VC];
        
    }
    return _sortPC;
}

#pragma mark - Lifecycle
-(void)dealloc{
    
    [KKNotificationCenter removeObserver:self];
    
}
-(void)viewDidLoad{
    
    [self setupBasicView];
    [self setupRefresh];
    [self setupNotification];
    [self setupPath];
    [self setupLeftNav];
    [self setupRightNav];
    
}

-(void)setupBasicView{
    
    self.collectionView.alwaysBounceVertical = YES;
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = myColor(230, 230, 230);
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    [self setupLayout:self.view.width orientation:self.interfaceOrientation];
}

#pragma mark - Rotation
-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{

#warning 这里传的是Height
    [self setupLayout:self.view.height orientation:toInterfaceOrientation];
    
}

-(void)setupLayout:(CGFloat)totalWidth orientation:(UIInterfaceOrientation)orientation{
    
    NSInteger columCount = UIInterfaceOrientationIsLandscape(orientation) ? 3 : 2;
   
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout*)self.collectionViewLayout;
    CGFloat headSpace = 25;
    CGFloat columSpace = (totalWidth - (flowLayout.itemSize.width * columCount))/(columCount+1) - 1;
     //NSLog(@"w:%f,C:%d,S:%f",totalWidth,columCount,columSpace);
    flowLayout.sectionInset = UIEdgeInsetsMake(headSpace, columSpace, headSpace, columSpace);
    flowLayout.minimumLineSpacing = headSpace;
    flowLayout.minimumInteritemSpacing = columSpace;
        //self.collectionViewLayout == self.collectionView.collectionViewLayout;
    
}
#pragma mark -UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    KKDetailController *detailVC = [[KKDetailController alloc]init];
    detailVC.deal = self.deals[indexPath.row];
    [self presentViewController:detailVC animated:YES completion:nil];
    
}
#pragma mark - CollectionDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    self.emptyView.hidden = self.deals.count > 0;
    //control footer show or hide
    self.collectionView.footer.hidden = (self.totalNumber == self.deals.count);
    return self.deals.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    KKDealCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"deal" forIndexPath:indexPath];
    
    cell.deal = self.deals[indexPath.row];
    return cell;

}
#pragma mark - Private methods
-(void)setupRefresh{
   // self.collectionView.footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreInfo)];
    self.collectionView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreInfo)];
    self.collectionView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewInfo)];
    
}

-(void)setupNotification{
    
    KKAddObserver(sortClicked:, KKSortDidSelectNotification);
    KKAddObserver(regionClicked:, KKRegionDidSelectNotification);
    KKAddObserver(categoryClicked:, KKCategoryDidSelectNotification);
    KKAddObserver(cityClicked:, KKCityDidSelectNotification);
}

-(AwesomeMenuItem *)itemWithContent:(NSString*)contentImage highlightedContent:(NSString*)highlightedContentImage{
    
    UIImage *bgItem = [UIImage imageNamed:@"bg_pathMenu_black_normal"];
    AwesomeMenuItem *menuItem = [[AwesomeMenuItem alloc]initWithImage:bgItem highlightedImage:nil ContentImage:[UIImage imageNamed:contentImage] highlightedContentImage:[UIImage imageNamed:highlightedContentImage]];
    return menuItem;
}



-(void)setupLeftNav{
    
    //logo
    UIBarButtonItem *logoBtn = [UIBarButtonItem itemWithImageName:@"icon_meituan_logo" highlightImageName:@"icon_meituan_logo" target:nil action:nil];
    
    //category
    KKDealsTopMenu *category = [KKDealsTopMenu menu];
    UIBarButtonItem *categoryItem = [[UIBarButtonItem alloc]initWithCustomView:category];
    self.categoryMenu = category;
    [category addTarget:self method:@selector(categoryItemClick:)];
    
    //region
    KKDealsTopMenu *region = [KKDealsTopMenu menu];
    region.menuButton.image = @"icon_district";
    region.menuButton.highlightedImage = @"icon_district_highlighted";
    UIBarButtonItem *regionItem = [[UIBarButtonItem alloc]initWithCustomView:region];
    self.regionMenu = region;
    [region addTarget:self method:@selector(regionItemClick:)];
    
    //sort
    KKDealsTopMenu *sort = [KKDealsTopMenu menu];
    sort.titleLabel.text = @"排序";
    sort.subTitleLabel.text = @"默认";
    sort.menuButton.image = @"icon_sort";
    sort.menuButton.highlightedImage = @"icon_sort_highlighted";
    [sort addTarget:self method:@selector(sortItemClick:)];
    UIBarButtonItem *sortItem = [[UIBarButtonItem alloc]initWithCustomView:sort];
    self.sortMenu = sort;
    
    
    self.navigationItem.leftBarButtonItems = @[logoBtn,categoryItem,regionItem,sortItem];

}

-(void)setupRightNav{

    //map
    UIBarButtonItem *mapBtn = [UIBarButtonItem itemWithImageName:@"icon_map" highlightImageName:@"icon_map_hightlighted" target:self action:@selector(mapBtnClick)];
    mapBtn.customView.width = 70;
    
    //search
    UIBarButtonItem *searchBtn = [UIBarButtonItem itemWithImageName:@"icon_search" highlightImageName:@"" target:self action:@selector(searchBtnClick)];
    searchBtn.width = mapBtn.width;
    
    self.navigationItem.rightBarButtonItems = @[mapBtn,searchBtn];
    
}

-(void)mapBtnClick{

}

-(void)searchBtnClick{
    
}

-(void)categoryItemClick:(id)sender{
    
    KKCategoriesVC *categoryVC = (KKCategoriesVC*)self.categoryPC.contentViewController;
    categoryVC.selectedCategory = self.selectedCategory;
    categoryVC.selectedSubCategory = self.selectedSubCategory;
    
    [self.categoryPC presentPopoverFromRect:self.categoryMenu.bounds inView:self.categoryMenu permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

-(void)sortItemClick:(id)sender{
    
    KKSortVC *sortVC = (KKSortVC*)self.sortPC.contentViewController;
    sortVC.selectedSort = self.selectedSort;
    
    [self.sortPC presentPopoverFromRect:self.sortMenu.bounds inView:self.sortMenu permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];

}

-(void)regionItemClick:(id)sender{
    
    KKRegionVC *regionVC = (KKRegionVC*)self.regionPC.contentViewController;
    regionVC.selectedRegion = self.selectedRegion;
    regionVC.selectedSubRegion = self.selectedSubRegion;
    
    [self.regionPC presentPopoverFromRect:self.regionMenu.bounds inView:self.regionMenu permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}
#pragma mark - Handle Notification
-(void)sortClicked:(NSNotification *)info{
    
    //analysis info
    KKSort *sort = info.userInfo[KKSelectedSort];
    self.selectedSort = sort;
    self.sortMenu.titleLabel.text = sort.label;
    
   
    //dismiss popover
    [self.sortPC dismissPopoverAnimated:YES];
    //call server
    [self.collectionView.header beginRefreshing];
}

-(void)cityClicked:(NSNotification *)info{
    
    //analysis info
    KKCity *city = info.userInfo[KKSelectedCity];
    self.regionMenu.titleLabel.text = city.name;
    self.regionMenu.subTitleLabel.text = @"全部";
    self.selectedCity = city;
    
    //change region's source
    KKRegionVC *regionVC = (KKRegionVC*)self.regionPC.contentViewController;
    regionVC.regions = city.regions;
    //call server
    [self.collectionView.header beginRefreshing];
    
    [[KKMetaDataTool sharedMetaDataTool] saveSelectedCityNames:city.name];
}

-(void)regionClicked:(NSNotification *)info{
    
    //analysis info
    KKRegion *region = info.userInfo[KKSelectedRegion];
    NSString *subRegion = info.userInfo[KKSelectedSubRegion];
    
    self.selectedSubRegion = subRegion;
    self.selectedRegion = region;
    
    self.regionMenu.titleLabel.text = [NSString stringWithFormat:@"%@-%@",self.selectedCity.name,region.name];
    self.regionMenu.subTitleLabel.text = subRegion;
    
    //dismiss popover
    [self.regionPC dismissPopoverAnimated:YES];
    //call server
     [self.collectionView.header beginRefreshing];
}

-(void)categoryClicked:(NSNotification *)info{
    
    //analysis info
    KKCategory *category = info.userInfo[KKSelectedCategory];
    NSString *subCategory = info.userInfo[KKSelectedSubCategory];
    
    self.selectedCategory = category;
    self.selectedSubCategory = subCategory;
    
    self.categoryMenu.titleLabel.text = category.name;
    self.categoryMenu.subTitleLabel.text = subCategory;
    self.categoryMenu.menuButton.image = category.small_icon;
    self.categoryMenu.menuButton.highlightedImage = category.small_highlighted_icon;
    
    //dismiss popover

    [self.categoryPC dismissPopoverAnimated:YES];
    
    //call server
     [self.collectionView.header beginRefreshing];
}
#pragma mark - sent post
-(KKFindDealParam*)buildParam{
    
    KKFindDealParam *param = [[KKFindDealParam alloc]init];
    param.city = self.selectedCity.name;
    // 排序
    if (self.selectedSort) {
        param.sort = @(self.selectedSort.value);
    }
    // 除开“全部分类”和“全部”以外的所有词语都可以发
    // 分类
    if (self.selectedCategory && ![self.selectedCategory.name isEqualToString:@"全部分类"]) {
        if (self.selectedSubCategory && ![self.selectedSubCategory isEqualToString:@"全部"]) {
            param.category = self.selectedSubCategory;
        } else {
            param.category = self.selectedCategory.name;
        }
    }
    // 区域
    if (self.selectedRegion && ![self.selectedRegion.name isEqualToString:@"全部"]) {
        if (self.selectedSubRegion && ![self.selectedSubRegion isEqualToString:@"全部"]) {
            param.region = self.selectedSubRegion;
        } else {
            param.region = self.selectedRegion.name;
        }
    }
    // 设置单次返回的数量
    param.limit = @(12);
    
    return param;
    
}
-(void)loadNewInfo{
    
    KKFindDealParam *param = [self buildParam];
    param.page = @(1);
    [KKDealTool findDeals:param success:^(KKFindDealResult *result) {
        //请求过期：直接返回
        if(param != self.lastFindDealParam)return ;
        
        self.totalNumber = result.total_count;
        [self.deals removeAllObjects];
        [self.deals addObjectsFromArray:result.deals];
        [self.collectionView reloadData];
        [self.collectionView.header endRefreshing];
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"网络有错误"];
        [self.collectionView.header endRefreshing];
    }];
    
    self.lastFindDealParam = param;
}

-(void)loadMoreInfo{

    KKFindDealParam *param = [self buildParam];
    param.page = @(self.lastFindDealParam.page.intValue + 1);
    [KKDealTool findDeals:param success:^(KKFindDealResult *result) {
        //请求过期：直接返回
        if(param != self.lastFindDealParam)return ;
        
        [self.deals addObjectsFromArray:result.deals];
        [self.collectionView reloadData];
        //refresh
        [self.collectionView.footer endRefreshing];
        
    } failure:^(NSError *error) {

        param.page = @(param.page.intValue - 1);
        //end refresh
        [self.collectionView.footer endRefreshing];
        
        [MBProgressHUD showError:@"网络有错误"];
    }];
    
    self.lastFindDealParam = param;
}
#pragma mark - Path
-(void)setupPath{
    
    // 1.周边的item
    AwesomeMenuItem *mineItem = [self itemWithContent:@"icon_pathMenu_mine_normal" highlightedContent:@"icon_pathMenu_mine_highlighted"];
    AwesomeMenuItem *collectItem = [self itemWithContent:@"icon_pathMenu_collect_normal" highlightedContent:@"icon_pathMenu_collect_highlighted"];
    AwesomeMenuItem *scanItem = [self itemWithContent:@"icon_pathMenu_scan_normal" highlightedContent:@"icon_pathMenu_scan_highlighted"];
    AwesomeMenuItem *moreItem = [self itemWithContent:@"icon_pathMenu_more_normal" highlightedContent:@"icon_pathMenu_more_highlighted"];
    NSArray *items = @[mineItem, collectItem, scanItem, moreItem];
    
    // the start item, similar to "add" button of Path
    AwesomeMenuItem *startItem = [[AwesomeMenuItem alloc] initWithImage:[UIImage imageNamed:@"icon_pathMenu_background_normal"]
                                                       highlightedImage:[UIImage imageNamed:@"icon_pathMenu_background_highlighted"]
                                                           ContentImage:[UIImage imageNamed:@"icon_pathMenu_mainMine_normal"]
                                                highlightedContentImage:[UIImage imageNamed:@"icon_pathMenu_mainMine_highlighted"]];
    
    //menu
    AwesomeMenu *menu = [[AwesomeMenu alloc]initWithFrame:CGRectZero startItem:startItem menuItems:items];
    menu.delegate = self;
    menu.alpha = 0.15;
    [self.view addSubview:menu];
    CGFloat menuH = 200;
    
    //menu BG
    UIImageView *menuBG = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_pathMenu_background"]];
    [menu insertSubview:menuBG atIndex:0];
    
    //menu BG constrains
    [menuBG autoSetDimensionsToSize:menuBG.image.size];
    [menuBG autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [menuBG autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    
    //menu constrains
    [menu autoSetDimensionsToSize:CGSizeMake(200, menuH)];
    menu.startPoint = CGPointMake(menuBG.image.size.width * 0.5, menuH - menuBG.image.size.height * 0.5);
    menu.rotateAngle = 0.0;
    menu.menuWholeAngle = M_PI_2 ;
    menu.rotateAddButton = NO;
    [menu autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [menu autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];

}

-(void)awesomeMenu:(AwesomeMenu *)menu didSelectIndex:(NSInteger)idx{

    
    [self awesomeMenuWillAnimateClose:menu];
}

-(void)awesomeMenuWillAnimateClose:(AwesomeMenu *)menu{

    menu.contentImage = [UIImage imageNamed:@"icon_pathMenu_mainMine_normal"];
    menu.highlightedContentImage = [UIImage imageNamed:@"icon_pathMenu_mainMine_highlighted"];
    [UIView animateWithDuration:0.5 animations:^{
        menu.alpha = 0.15;
    }];

}

-(void)awesomeMenuWillAnimateOpen:(AwesomeMenu *)menu{
    menu.contentImage = [UIImage imageNamed:@"icon_pathMenu_cross_normal"];
    menu.highlightedContentImage = [UIImage imageNamed:@"icon_pathMenu_cross_highlighted"];
    [UIView animateWithDuration:0.5 animations:^{
        menu.alpha = 1;
    }];
    
    /*
    [UIView transitionWithView:menu duration:1.0 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        menu.contentImage = [UIImage imageNamed:@"icon_pathMenu_cross_normal"];
    } completion:^(BOOL finished) {
       
        
    }];*/

}


@end
