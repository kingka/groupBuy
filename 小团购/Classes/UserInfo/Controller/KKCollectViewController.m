//
//  KKCollectViewController.m
//  小团购
//
//  Created by Imanol on 10/11/15.
//  Copyright (c) 2015 Imanol. All rights reserved.
//

#import "KKCollectViewController.h"
#import "KKLocalTool.h"
#import "KKDeal.h"

@interface KKCollectViewController ()

@end

@implementation KKCollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的收藏";

}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.deals = [KKLocalTool sharedLocalTool].collectArray;
    
    [self.collectionView reloadData];
}

#pragma mark - overide parent method
-(NSString *)empytIcon{
    
    return @"icon_collects_empty";
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
    [[KKLocalTool sharedLocalTool] unSaveCollectDeals:selectedDeals];
    [self.deals removeObjectsInArray:selectedDeals];
    [super delete];
    [self.collectionView reloadData];
}



@end
