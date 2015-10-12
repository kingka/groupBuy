//
//  KKNavigationController.m
//  小团购
//
//  Created by Imanol on 15/9/18.
//  Copyright (c) 2015年 Imanol. All rights reserved.
//

#import "KKNavigationController.h"
#import "KKDealsConst.h"

@implementation KKNavigationController

+(void)initialize{
    
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    [navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_navigationBar_normal"] forBarMetrics:UIBarMetricsDefault];
    
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = myColor(29, 177, 157);
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    
    
    NSMutableDictionary *disableAttrs = [NSMutableDictionary dictionary];
    disableAttrs[NSForegroundColorAttributeName] = myColor(210, 210, 210);
    [item setTitleTextAttributes:disableAttrs forState:UIControlStateDisabled];
}

-(void)viewDidLoad{
    
    [super viewDidLoad];
}
@end
