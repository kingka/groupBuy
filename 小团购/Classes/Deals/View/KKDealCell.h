//
//  KKDealCell.h
//  小团购
//
//  Created by Imanol on 10/2/15.
//  Copyright (c) 2015 Imanol. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KKDeal;
@class KKDealCell;
@protocol KKDealCellDelegate <NSObject>

@optional
-(void)dealCellDidClickCover:(KKDealCell*)cell;

@end

@interface KKDealCell : UICollectionViewCell
@property (strong, nonatomic) KKDeal *deal;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *listPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *purchaseCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *cover;
@property (weak, nonatomic) IBOutlet UIImageView *chooseImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *currentPriceLYWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *listPriceLYWidth;

@property (weak, nonatomic) id<KKDealCellDelegate> delegate;
@end
