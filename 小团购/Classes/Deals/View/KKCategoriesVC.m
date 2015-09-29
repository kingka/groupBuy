//
//  KKCategoriesVC.m
//  小团购
//
//  Created by Imanol on 9/28/15.
//  Copyright (c) 2015 Imanol. All rights reserved.
//

#import "KKCategoriesVC.h"
#import "UIView+Extension.h"
#import "KKMetaDataTool.h"

@interface KKCategoriesVC ()

@end

@implementation KKCategoriesVC

-(void)loadView{
    
    KKDropDownMenu *menu = [KKDropDownMenu dropDownMenu];
    self.view = menu;
    NSArray *categories = [KKMetaDataTool sharedMetaDataTool].categories;
    menu.items = categories;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.preferredContentSize = CGSizeMake(350, 480);
}



@end
