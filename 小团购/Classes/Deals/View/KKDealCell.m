//
//  KKDealCell.m
//  小团购
//
//  Created by Imanol on 10/2/15.
//  Copyright (c) 2015 Imanol. All rights reserved.
//

#import "KKDealCell.h"
#import "KKDeal.h"

@implementation KKDealCell


-(void)setDeal:(KKDeal *)deal{
    
    _deal = deal;
    //self.imageView.image = [UIImage imageNamed:deal.i]
    self.titleLabel.text = deal.title;
    self.descLabel.text = deal.desc;
    self.currentPriceLabel.text = [NSString stringWithFormat:@"￥%.0f",deal.current_price];
    self.listPriceLabel.text = [NSString stringWithFormat:@"￥%.0f",deal.list_price];
    self.purchaseCountLabel.text = [NSString stringWithFormat:@"%i",deal.purchase_count];
}
@end
