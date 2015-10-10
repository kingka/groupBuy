//
//  KKDealListViewController.h
//  小团购
//
//  Created by Imanol on 15/10/10.
//  Copyright (c) 2015年 Imanol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmptyView.h"

@interface KKDealListViewController : UICollectionViewController<UICollectionViewDataSource,UICollectionViewDelegate>
@property(strong, nonatomic)NSMutableArray *deals;
@property(weak, nonatomic)EmptyView *emptyView;
@end
