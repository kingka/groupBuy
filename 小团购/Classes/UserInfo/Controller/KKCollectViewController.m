//
//  KKCollectViewController.m
//  小团购
//
//  Created by Imanol on 10/11/15.
//  Copyright (c) 2015 Imanol. All rights reserved.
//

#import "KKCollectViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "KKLocalTool.h"

@interface KKCollectViewController ()

@end

@implementation KKCollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupLeftBar];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.deals = [KKLocalTool sharedLocalTool].collectArray;
    
    [self.collectionView reloadData];
}

-(NSString *)empytIcon{
    
    return @"icon_collects_empty";
}

-(void)setupLeftBar{
    
    self.title = @"我的收藏";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"icon_back" highlightImageName:@"icon_back_highlighted" target:self action:@selector(back)];
}

-(void)back{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
