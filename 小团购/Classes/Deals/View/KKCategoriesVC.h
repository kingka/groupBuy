//
//  KKCategoriesVC.h
//  小团购
//
//  Created by Imanol on 9/28/15.
//  Copyright (c) 2015 Imanol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKDropDownMenu.h"
#import "KKCategory.h"

@interface KKCategoriesVC : UIViewController
@property (strong, nonatomic)KKCategory *selectedCategory;
@property (nonatomic , copy) NSString *selectedSubCategory;
@end
