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

#import "KKDealsConst.h"
@interface KKCategoriesVC ()<KKDropDownMenuDelegate>
@property (weak, nonatomic)KKDropDownMenu *menu;

@end

@implementation KKCategoriesVC


#pragma mark - lifecycle
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

    if(category.subcategories.count == 0){
        
        //sent notification
        [KKNotificationCenter postNotificationName:KKCategoryDidSelectNotification object:nil userInfo:@{KKSelectedCategory:category}];
    }else{//category.subcategories.count>0
        
        //控制再次点击方才选中的主category时， subCategory 可以显示方才选中的
        if(self.selectedCategory == category){
            
            self.selectedSubCategory = self.selectedSubCategory;
        }
    }
}

-(void)dropDownMenu:(KKDropDownMenu *)dpMenu subRow:(NSInteger)subRow ofMain:(NSInteger)mainRow{
    
    KKCategory *category = dpMenu.items[mainRow];
    NSArray *subCategorys = category.subcategories;
    NSString *subCategory = subCategorys[subRow];
    
    //sent notification
    [KKNotificationCenter postNotificationName:KKCategoryDidSelectNotification object:nil userInfo:@{KKSelectedSubCategory:subCategory,KKSelectedCategory:category}];
}

#pragma mark - public methods
-(void)setSelectedCategory:(KKCategory *)selectedCategory{

    _selectedCategory = selectedCategory;
    NSInteger mainRow = [self.menu.items indexOfObject:selectedCategory];
    [self.menu selectedMainRow:mainRow];
}

-(void)setSelectedSubCategory:(NSString *)selectedSubCategory{

    _selectedSubCategory = selectedSubCategory;
    NSArray *subCategories = self.selectedCategory.subcategories;
    NSInteger subRow = [subCategories indexOfObject:selectedSubCategory];
    [self.menu selectedSubRow:subRow];
}
@end
