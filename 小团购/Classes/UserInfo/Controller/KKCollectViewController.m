//
//  KKCollectViewController.m
//  小团购
//
//  Created by Imanol on 10/11/15.
//  Copyright (c) 2015 Imanol. All rights reserved.
//

#import "KKCollectViewController.h"
#import "KKLocalTool.h"

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

-(NSString *)empytIcon{
    
    return @"icon_collects_empty";
}





@end
