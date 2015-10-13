//
//  KKLocalDealListViewController.m
//  小团购
//
//  Created by Imanol on 15/10/12.
//  Copyright (c) 2015年 Imanol. All rights reserved.
//

#import "KKLocalDealListViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "KKDeal.h"
#import "KKDealCell.h"
#define KKEdit @"编辑"
#define KKDone @"完成"

@interface KKLocalDealListViewController ()<KKDealCellDelegate>

@property (strong, nonatomic) UIBarButtonItem *allSelectItem;
@property (strong, nonatomic) UIBarButtonItem *unSelectItem;
@property (strong, nonatomic) UIBarButtonItem *deleteItem;
@property (strong, nonatomic) UIBarButtonItem *backItem;
@end

@implementation KKLocalDealListViewController

#pragma mark - lazyLoading
-(UIBarButtonItem *)backItem{

    if(_backItem == nil){
        
        UIBarButtonItem *backItem = [UIBarButtonItem itemWithImageName:@"icon_back" highlightImageName:@"icon_back_highlighted" target:self action:@selector(back)];
        self.backItem = backItem;
    }
    return _backItem;
}

-(UIBarButtonItem *)allSelectItem{
    
    if(_allSelectItem == nil){
        UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"   全选   " style:UIBarButtonItemStyleBordered target:self action:@selector(allSelect)];
        self.allSelectItem = item;
    }
    
    return _allSelectItem;
}

-(UIBarButtonItem *)deleteItem{
    
    if(_deleteItem == nil){
        UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"   删除   " style:UIBarButtonItemStyleBordered target:self action:@selector(delete)];
        item.enabled = NO;
        self.deleteItem = item;
    }
    
    return _deleteItem;
}

-(UIBarButtonItem *)unSelectItem{
    
    if(_unSelectItem == nil){
        UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"   全不选   " style:UIBarButtonItemStyleBordered target:self action:@selector(unSelect)];
        self.unSelectItem = item;
    }
    
    return _unSelectItem;
}
#pragma mark - lifycycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupLeftBar];
    [self setupRightBar];
}

-(void)viewDidDisappear:(BOOL)animated{
    
    for(KKDeal *deal in self.deals){
        
        deal.editing = NO;
        deal.choose = NO;
    }

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupLeftBar{
    
    self.navigationItem.leftBarButtonItem = self.backItem;
}

-(void)setupRightBar{
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:KKEdit style:UIBarButtonItemStylePlain target:self action:@selector(edit:)];
    
}

-(void)edit:(UIBarButtonItem*)item{
    
    if([item.title isEqualToString:KKEdit]){
        
        [item setTitle:KKDone];
        for(KKDeal *deal in self.deals){
            
            deal.editing = YES;
        }
        self.navigationItem.leftBarButtonItems = @[self.backItem,self.allSelectItem,self.unSelectItem,self.deleteItem];
    }else{
        
        [item setTitle:KKEdit];
        for(KKDeal *deal in self.deals){
            
            deal.editing = NO;
            deal.choose = NO;
        }
        [self dealCellDidClickCover:nil];
        self.navigationItem.leftBarButtonItems = @[self.backItem];
    }

    [self.collectionView reloadData];
}

-(void)back{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)allSelect{

    for(KKDeal *deal in self.deals){
        
        deal.choose = YES;
    }
    [self.collectionView reloadData];
    [self dealCellDidClickCover:nil];
}

-(void)delete{

    //fresh deleteBtn title
    [self dealCellDidClickCover:nil];
}

-(void)unSelect{

    for(KKDeal *deal in self.deals){
        
        deal.choose = NO;
    }
    [self.collectionView reloadData];
    [self dealCellDidClickCover:nil];
}

#pragma mark - KKDealCellDelegate
-(void)dealCellDidClickCover:(KKDealCell *)cell{
    
    int selectedCounts = 0;
    for(KKDeal *deal in self.deals){
        
        if(deal.isChoose){

            selectedCounts ++;
        }
    }
    if(selectedCounts){
        
        self.deleteItem.enabled = YES;
        [self.deleteItem setTitle:[NSString stringWithFormat:@"   删除   (%d)",selectedCounts]];
        
    }else{
    
        self.deleteItem.enabled = NO;
        [self.deleteItem setTitle:@"   删除   "];
    }
}
@end
