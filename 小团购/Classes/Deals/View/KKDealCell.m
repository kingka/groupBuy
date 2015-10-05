//
//  KKDealCell.m
//  小团购
//
//  Created by Imanol on 10/2/15.
//  Copyright (c) 2015 Imanol. All rights reserved.
//

#import "KKDealCell.h"
#import "KKDeal.h"
#import <UIImageView+WebCache.h>

@implementation KKDealCell


-(void)setDeal:(KKDeal *)deal{
    
    _deal = deal;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:deal.image_url] placeholderImage:[UIImage imageNamed:@"placeholder_deal"] options:SDWebImageRetryFailed];
    self.titleLabel.text = deal.title;
    self.descLabel.text = deal.desc;
    self.currentPriceLabel.text = [NSString stringWithFormat:@"￥%@",deal.current_price];
    self.listPriceLabel.text = [NSString stringWithFormat:@"￥%@",deal.list_price];
    self.purchaseCountLabel.text = [NSString stringWithFormat:@"%i",deal.purchase_count];
    
    //set layout constraint by lable content
    self.currentPriceLYWidth.constant = [_currentPriceLabel.text sizeWithAttributes:@{NSFontAttributeName:_currentPriceLabel.font}].width + 1;// 1 是为了误差
    
    self.listPriceLYWidth.constant = [_listPriceLabel.text sizeWithAttributes:@{NSFontAttributeName:_listPriceLabel.font}].width + 1;// 1 是为了误差
    
}

-(void)drawRect:(CGRect)rect{
    
    [super drawRect:rect];
    [[UIImage imageNamed:@"bg_dealcell"] drawInRect:rect];
}
@end
