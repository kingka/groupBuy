//
//  KKSortVC.m
//  小团购
//
//  Created by Imanol on 9/28/15.
//  Copyright (c) 2015 Imanol. All rights reserved.
//

#import "KKSortVC.h"
#import "UIView+Extension.h"
#import "KKSort.h"
#import "KKMetaDataTool.h"

@interface sortButton : UIButton
@property(strong, nonatomic)KKSort *sort;
@end

@implementation sortButton

-(void)setHighlighted:(BOOL)highlighted{

}

-(void)setSort:(KKSort *)sort{
    
    _sort = sort;
    [self setTitle:sort.label forState:UIControlStateNormal];
}

@end

@interface KKSortVC ()

@property(strong, nonatomic)KKSort *sortModel;
@end

@implementation KKSortVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpSortItems];
    self.preferredContentSize = self.view.size;
    
}

-(void)setUpSortItems{
    
    NSArray *sortArray = [KKMetaDataTool sharedMetaDataTool].sorts;
    CGFloat buttonX = 20;
    CGFloat buttonH = 30;
    CGFloat buttonP = 10;
    CGFloat buttonW = self.view.width - 2*buttonX;
    CGFloat scrollContentH = 0;
    for(int i = 0 ; i< sortArray.count; i++){
        
        KKSort *sort = sortArray[i];
        sortButton *button = [[sortButton alloc]init];
        button.sort = sort;
        //[button setTitle:sort.label forState:UIControlStateNormal];
        CGFloat buttonY = buttonP + i*(buttonH + buttonP);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.view addSubview:button];
        
        scrollContentH = button.y + buttonP;
    }
    
    UIScrollView *scrollView = (UIScrollView*)self.view;
    scrollView.contentSize = CGSizeMake(0, scrollContentH);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
