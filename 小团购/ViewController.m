//
//  ViewController.m
//  小团购
//
//  Created by Imanol on 15/9/16.
//  Copyright (c) 2015年 Imanol. All rights reserved.
//

#import "ViewController.h"
#import "KKDealTool.h"
#import "KKFindDealParam.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    KKAPITool *apiTool = [KKAPITool shareKKAPITool];
//    
//    NSMutableDictionary *params1 = [NSMutableDictionary dictionary];
//    params1[@"city"] = @"北京";
//    params1[@"region"] = @"朝阳区";
//    params1[@"category"] = @"美发";
//    [apiTool requset:@"v1/deal/find_deals" params:params1 success:^(id json) {
//         NSLog(@"北京-请求成功---%@", json);
//    } failure:^(NSError *error) {
//         NSLog(@"北京-请求失败---%@", error);
//    }];
    
    KKFindDealParam *param = [[KKFindDealParam alloc]init];
    param.city = @"北京";
    param.limit = @5;
    [KKDealTool findDeals:param success:^(KKFindDealResult *result) {
        NSLog(@"result:--%@",result);
    } failure:^(NSError *error) {
        
    }];
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
