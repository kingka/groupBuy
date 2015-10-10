//
//  KKHistoryController.m
//  小团购
//
//  Created by Imanol on 15/10/10.
//  Copyright (c) 2015年 Imanol. All rights reserved.
//

#import "KKHistoryController.h"
#import "KKLocalTool.h"

@interface KKHistoryController ()

@end

@implementation KKHistoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray *array = [KKLocalTool sharedLocalTool].historyArray;
    NSLog(@"%d",array.count);
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
