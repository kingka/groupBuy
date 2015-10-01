//
//  KKRegionVC.h
//  小团购
//
//  Created by Imanol on 9/28/15.
//  Copyright (c) 2015 Imanol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKDropDownMenu.h"
#import "KKRegion.h"
@interface KKRegionVC : UIViewController<KKDropDownMenuDelegate>
@property (nonatomic , strong) NSArray *regions;
@property (nonatomic , copy) void(^changeCityBlock)();
- (IBAction)changeCity:(UIButton *)sender;
@end
