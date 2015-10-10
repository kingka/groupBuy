//
//  KKDealListViewController.m
//  小团购
//
//  Created by Imanol on 15/10/10.
//  Copyright (c) 2015年 Imanol. All rights reserved.
//

#import "KKDealListViewController.h"
#import "KKDetailController.h"
#import "KKDealCell.h"
#import "KKDealsConst.h"
#import "UIView+Extension.h"
#import "UIButton+Extension.h"

@interface KKDealListViewController ()

@end

@implementation KKDealListViewController

static NSString * const reuseIdentifier = @"deal";

-(instancetype)init{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(305, 305);
    
    return [super initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBasicView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupBasicView{
    
    self.collectionView.alwaysBounceVertical = YES;
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = myColor(230, 230, 230);
     [self.collectionView registerNib:[UINib nibWithNibName:@"KKDealCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    [self setupLayout:self.view.width orientation:self.interfaceOrientation];
}
-(EmptyView *)emptyView{
    
    if (_emptyView == nil) {
        EmptyView *emptyView = [EmptyView emptyView];
        //emptyView.image = [UIImage imageNamed:@"icon_deals_empty"];
        [self.view insertSubview:emptyView belowSubview:self.collectionView];
        self.emptyView = emptyView;
    }
    return _emptyView;
}

-(NSMutableArray *)deals{
    
    if(_deals == nil){
        
        self.deals = [NSMutableArray array];
    }
    return _deals;
}

#pragma mark - Rotation
-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    
#warning 这里传的是Height
    [self setupLayout:self.view.height orientation:toInterfaceOrientation];
    
}

-(void)setupLayout:(CGFloat)totalWidth orientation:(UIInterfaceOrientation)orientation{
    
    NSInteger columCount = UIInterfaceOrientationIsLandscape(orientation) ? 3 : 2;
    
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout*)self.collectionViewLayout;
    CGFloat headSpace = 25;
    CGFloat columSpace = (totalWidth - (flowLayout.itemSize.width * columCount))/(columCount+1) - 1;
    //NSLog(@"w:%f,C:%d,S:%f",totalWidth,columCount,columSpace);
    flowLayout.sectionInset = UIEdgeInsetsMake(headSpace, columSpace, headSpace, columSpace);
    flowLayout.minimumLineSpacing = headSpace;
    flowLayout.minimumInteritemSpacing = columSpace;
    //self.collectionViewLayout == self.collectionView.collectionViewLayout;
    
}

#pragma mark -UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    KKDetailController *detailVC = [[KKDetailController alloc]init];
    detailVC.deal = self.deals[indexPath.row];
    [self presentViewController:detailVC animated:YES completion:nil];
    
}
#pragma mark - CollectionDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    self.emptyView.hidden = self.deals.count > 0;

    return self.deals.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    KKDealCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.deal = self.deals[indexPath.row];
    return cell;
    
}

@end
