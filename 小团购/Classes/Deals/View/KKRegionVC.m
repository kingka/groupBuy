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
#import "KKDealsConst.h"


@interface KKRegionVC ()

@property(weak, nonatomic)KKDropDownMenu *menu;

@end

@implementation KKRegionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    KKDropDownMenu *menu = [KKDropDownMenu dropDownMenu];
    self.menu = menu;
    self.menu.delegate = self;
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

-(void)setRegions:(NSArray *)regions{
    
    _regions = regions;
    self.menu.items = regions;
}

#pragma mark - KKDropDownMenuDelegate
-(void)dropDownMenu:(KKDropDownMenu *)dpMenu mainRow:(NSInteger)row{

    KKRegion *region = self.regions[row];
    if(region.subregions.count == 0){
        
        //sent Notification
        [KKNotificationCenter postNotificationName:KKRegionDidSelectNotification object:nil userInfo:@{KKSelectedRegion:region}];
    }
}

-(void)dropDownMenu:(KKDropDownMenu *)dpMenu subRow:(NSInteger)subRow ofMain:(NSInteger)mainRow{
    
    KKRegion *region = self.regions[mainRow];
    NSArray *subRegions = region.subregions;
    NSString *subRegion = subRegions[subRow];

    //sent Notification
    [KKNotificationCenter postNotificationName:KKRegionDidSelectNotification object:nil userInfo:@{KKSelectedRegion:region,KKSelectedSubRegion:subRegion}];
}

-(void)setSelectedRegion:(KKRegion *)selectedRegion{
    
    _selectedRegion = selectedRegion;
    NSInteger mainRow = [self.regions indexOfObject:selectedRegion];
    [self.menu selectedMainRow:mainRow];
}

-(void)setSelectedSubRegion:(NSString *)selectedSubRegion{
    
    _selectedSubRegion = selectedSubRegion;
    NSArray *subRegions = self.selectedRegion.subregions;
    NSInteger subRow = [subRegions indexOfObject:selectedSubRegion];
    [self.menu selectedSubRow:subRow];
}

@end
