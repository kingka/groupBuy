//
//  KKNavigationController.m
//  小团购
//
//  Created by Imanol on 15/9/18.
//  Copyright (c) 2015年 Imanol. All rights reserved.
//

#import "KKNavigationController.h"

@implementation KKNavigationController

+(void)initialize{
    
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    [navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_navigationBar_normal"] forBarMetrics:UIBarMetricsDefault];
}

-(void)viewDidLoad{
    
    [super viewDidLoad];
}
@end
