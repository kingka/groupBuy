//
//  KKLocalDealListViewController.m
//  小团购
//
//  Created by Imanol on 15/10/12.
//  Copyright (c) 2015年 Imanol. All rights reserved.
//

#import "KKLocalDealListViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "KKDeal.h"
#define KKEdit @"编辑"
#define KKDone @"完成"

@interface KKLocalDealListViewController ()

@end

@implementation KKLocalDealListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupLeftBar];
    [self setupRightBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupLeftBar{
    
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"icon_back" highlightImageName:@"icon_back_highlighted" target:self action:@selector(back)];
}

-(void)setupRightBar{
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:KKEdit style:UIBarButtonItemStylePlain target:self action:@selector(edit:)];
    
}

-(void)edit:(UIBarButtonItem*)item{
    
    if([item.title isEqualToString:KKEdit]){
        
        [item setTitle:KKDone];
        for(KKDeal *deal in self.deals){
            
            deal.editing = YES;
        }
    }else{
        
        [item setTitle:KKEdit];
        for(KKDeal *deal in self.deals){
            
            deal.editing = NO;
        }
    }

    [self.collectionView reloadData];
}

-(void)back{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
