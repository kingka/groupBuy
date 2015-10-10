//
//  KKDealsViewController.h
//  小团购
//
//  Created by Imanol on 15/9/18.
//  Copyright (c) 2015年 Imanol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AwesomeMenu.h"
#import "AwesomeMenuItem.h"
#import "UIView+AutoLayout.h"
#import "UIView+Extension.h"
#import "KKDealsTopMenu.h"
#import "KKDealListViewController.h"

@interface KKDealsViewController : KKDealListViewController<AwesomeMenuDelegate>

@property (nonatomic , weak) KKDealsTopMenu *categoryMenu;
@property (nonatomic , weak) KKDealsTopMenu *sortMenu;
@property (nonatomic , weak) KKDealsTopMenu *regionMenu;

@property (nonatomic , strong) UIPopoverController *categoryPC;
@property (nonatomic , strong) UIPopoverController *sortPC;
@property (nonatomic , strong) UIPopoverController *regionPC;

@end
