//
//  KKHistoryController.m
//  小团购
//
//  Created by Imanol on 15/10/10.
//  Copyright (c) 2015年 Imanol. All rights reserved.
//

#import "KKHistoryController.h"
#import "KKLocalTool.h"
#import "UIBarButtonItem+Extension.h"

@interface KKHistoryController ()

@end

@implementation KKHistoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupLeftBar];
    
    

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

-(void)setupLeftBar{
    
    self.title = @"浏览记录";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"icon_back" highlightImageName:@"icon_back_highlighted" target:self action:@selector(back)];
}

-(void)back{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(NSString *)empytIcon{
    
    return @"icon_latestBrowse_empty";
}
@end
