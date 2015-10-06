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
#import "UIButton+Extension.h"
#import "KKDealsConst.h"

@interface KKSortButton : UIButton
@property(strong, nonatomic)KKSort *sort;
@end

@implementation KKSortButton

-(instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
    
        self.bgImage = @"btn_filter_normal";
        self.selectedBgImage = @"btn_filter_selected";
        self.titleColor = [UIColor blackColor];
        self.selectedTitleColor = [UIColor whiteColor];

    }
    
    return self;
}
-(void)setHighlighted:(BOOL)highlighted{

}

-(void)setSort:(KKSort *)sort{
    
    _sort = sort;
    [self setTitle:sort.label forState:UIControlStateNormal];
}

@end

@interface KKSortVC ()

@property(strong, nonatomic)KKSort *sortModel;
@property(weak, nonatomic)KKSortButton *selectedButton;
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
        KKSortButton *button = [[KKSortButton alloc]init];
        button.sort = sort;
        CGFloat buttonY = buttonP + i*(buttonH + buttonP);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        button.titleColor = [UIColor blackColor];
        [self.view addSubview:button];
        [button addTarget:self action:@selector(itemClick:)];
        scrollContentH = button.y + buttonP;
    }
    
    UIScrollView *scrollView = (UIScrollView*)self.view;
    scrollView.contentSize = CGSizeMake(0, scrollContentH);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)itemClick:(KKSortButton*)btn{
    
    self.selectedButton.selected = NO;
    btn.selected = YES;
    self.selectedButton = btn;
    
    //sent notification
    [KKNotificationCenter postNotificationName:KKSortDidSelectNotification object:nil userInfo:@{KKSelectedSort:btn.sort}];
    
    //[self dismissViewControllerAnimated:YES completion:nil];
}

-(void)setSelectedSort:(KKSort *)selectedSort{
    
    
    _selectedSort = selectedSort;
    
    //NSLog(@"%d",self.view.subviews.count);
    for(KKSortButton *button in self.view.subviews){
        
//        if([button isKindOfClass:[KKSortButton class]])
//        NSLog(@"1:%@, 2:%@",selectedSort,button.sort);
        if([button isKindOfClass:[KKSortButton class]] && button.sort == selectedSort){
            
            self.selectedButton.selected = NO;
            button.selected = YES;
            self.selectedButton = button;
        }
    }
}
@end
