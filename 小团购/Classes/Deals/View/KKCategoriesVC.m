//
//  KKCategoriesVC.m
//  小团购
//
//  Created by Imanol on 9/28/15.
//  Copyright (c) 2015 Imanol. All rights reserved.
//

#import "KKCategoriesVC.h"
#import "UIView+Extension.h"

@interface KKCategoriesVC ()

@end

@implementation KKCategoriesVC

-(void)loadView{
    
    self.view = [KKDropDownMenu dropDownMenu];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.preferredContentSize = self.view.size;
}



@end
