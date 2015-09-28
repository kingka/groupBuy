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



@implementation KKDealsViewController

#pragma mark - lazy loading

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
-(void)viewDidLoad{
    
    [self setupPath];
    [self setupLeftNav];
    [self setupRightNav];
    
}


#pragma mark - Private methods
-(AwesomeMenuItem *)itemWithContent:(NSString*)contentImage highlightedContent:(NSString*)highlightedContentImage{
    
    UIImage *bgItem = [UIImage imageNamed:@"bg_pathMenu_black_normal"];
    AwesomeMenuItem *menuItem = [[AwesomeMenuItem alloc]initWithImage:bgItem highlightedImage:nil ContentImage:[UIImage imageNamed:contentImage] highlightedContentImage:[UIImage imageNamed:highlightedContentImage]];
    return menuItem;
}



-(void)setupLeftNav{
    
    //logo
    UIBarButtonItem *logoBtn = [UIBarButtonItem itemWithImageName:@"icon_meituan_logo" highlightImageName:@"icon_meituan_logo" target:nil action:nil];
    
    KKDealsTopMenu *category = [KKDealsTopMenu menu];
    UIBarButtonItem *categoryItem = [[UIBarButtonItem alloc]initWithCustomView:category];
    self.categoryMenu = category;
    [category addTarget:self method:@selector(categoryItemClick:)];
    
    KKDealsTopMenu *region = [KKDealsTopMenu menu];
    UIBarButtonItem *regionItem = [[UIBarButtonItem alloc]initWithCustomView:region];
    self.regionMenu = region;
    [region addTarget:self method:@selector(regionItemClick:)];
    
    KKDealsTopMenu *sort = [KKDealsTopMenu menu];
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
    
    [self.categoryPC presentPopoverFromRect:self.categoryMenu.bounds inView:self.categoryMenu permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

-(void)sortItemClick:(id)sender{
    
    [self.sortPC presentPopoverFromRect:self.sortMenu.bounds inView:self.sortMenu permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];

}

-(void)regionItemClick:(id)sender{
    
    [self.regionPC presentPopoverFromRect:self.regionMenu.bounds inView:self.regionMenu permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
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
    NSLog(@"close.");
    menu.contentImage = [UIImage imageNamed:@"icon_pathMenu_mainMine_normal"];
    menu.highlightedContentImage = [UIImage imageNamed:@"icon_pathMenu_mainMine_highlighted"];

}

-(void)awesomeMenuWillAnimateOpen:(AwesomeMenu *)menu{
    menu.contentImage = [UIImage imageNamed:@"icon_pathMenu_cross_normal"];
    menu.highlightedContentImage = [UIImage imageNamed:@"icon_pathMenu_cross_highlighted"];
    NSLog(@"open.");
    
    /*
    [UIView transitionWithView:menu duration:1.0 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        menu.contentImage = [UIImage imageNamed:@"icon_pathMenu_cross_normal"];
    } completion:^(BOOL finished) {
       
        
    }];*/

}


@end
