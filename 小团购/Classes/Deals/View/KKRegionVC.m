//
//  KKRegionVC.m
//  小团购
//
//  Created by Imanol on 9/28/15.
//  Copyright (c) 2015 Imanol. All rights reserved.
//

#import "KKRegionVC.h"
#import "KKDropDownMenu.h"
#import "UIView+AutoLayout.h"
#import "KKMetaDataTool.h"
#import "KKCitiesController.h"



@interface KKRegionVC ()

@end

@implementation KKRegionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    KKDropDownMenu *menu = [KKDropDownMenu dropDownMenu];
    KKMetaDataTool *tool = [KKMetaDataTool sharedMetaDataTool];
    KKCity *city = [tool cityWithName:@"北京"];
    menu.items = city.regions;
    [self.view addSubview:menu];
    UIView *topView = [self.view.subviews firstObject];
    
    //menu autoLayout
    [menu autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:topView];
    [menu autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
    
}



- (IBAction)changeCity:(UIButton *)sender {
    
     if ([[[UIDevice currentDevice] systemVersion] floatValue] <= 7.1) {
    
         if(self.changeCityBlock){
             self.changeCityBlock();
         }
     }
   
    
    KKCitiesController *vc = [[KKCitiesController alloc]init];
    vc.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:vc animated:YES completion:nil];
    
}
@end
