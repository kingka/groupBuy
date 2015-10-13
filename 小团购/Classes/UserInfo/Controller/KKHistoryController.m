//
//  KKHistoryController.m
//  小团购
//
//  Created by Imanol on 15/10/10.
//  Copyright (c) 2015年 Imanol. All rights reserved.
//

#import "KKHistoryController.h"
#import "KKLocalTool.h"
#import "KKDeal.h"


@interface KKHistoryController ()

@end

@implementation KKHistoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"浏览记录";
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.deals = [KKLocalTool sharedLocalTool].historyArray;
    
    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - overide parent method
-(NSString *)empytIcon{
    
    return @"icon_latestBrowse_empty";
}
-(void)delete{

    NSMutableArray *selectedDeals = [NSMutableArray array];
    for(KKDeal *deal in self.deals){
        
        if(deal.isChoose){
            [selectedDeals addObject:deal];
            deal.choose = NO;
            deal.editing = NO;
        }
    }
    [[KKLocalTool sharedLocalTool] unSaveHistoryDeals:selectedDeals];
    [self.deals removeObjectsInArray:selectedDeals];
    [super delete];
    [self.collectionView reloadData];
    
}
@end
