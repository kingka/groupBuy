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
#import "KKDropDownMenu.h"
#import "KKCategory.h"
#import "KKDealsConst.h"
@interface KKCategoriesVC ()<KKDropDownMenuDelegate>
@property (weak, nonatomic)KKDropDownMenu *menu;
@property (strong, nonatomic)KKCategory *selectedCategory;
@end

@implementation KKCategoriesVC

-(void)loadView{
    
    KKDropDownMenu *menu = [KKDropDownMenu dropDownMenu];
    self.menu = menu;
    self.menu.delegate = self;
    self.view = menu;
    NSArray *categories = [KKMetaDataTool sharedMetaDataTool].categories;
    menu.items = categories;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.preferredContentSize = CGSizeMake(350, 480);
}

#pragma mark - KKDropDownMenuDelegate

-(void)dropDownMenu:(KKDropDownMenu *)dpMenu mainRow:(NSInteger)row{

    KKCategory *category = self.menu.items[row];
    self.selectedCategory = category;
    if(category.subcategories.count == 0){
        
        //sent notification
        [KKNotificationCenter postNotificationName:KKCategoryDidSelectNotification object:nil userInfo:@{KKSelectedCategory:category}];
    }
}

-(void)dropDownMenu:(KKDropDownMenu *)dpMenu subRow:(NSInteger)subRow ofMain:(NSInteger)mainRow{
    
    NSArray *subCategorys = self.selectedCategory.subcategories;
    NSString *subCategory = subCategorys[subRow];
    
    //sent notification
    [KKNotificationCenter postNotificationName:KKCategoryDidSelectNotification object:nil userInfo:@{KKSelectedSubCategory:subCategory,KKSelectedCategory:self.selectedCategory}];
}
@end
