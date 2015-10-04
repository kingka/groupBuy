//
//  LableLine.m
//  小团购
//
//  Created by Imanol on 10/4/15.
//  Copyright (c) 2015 Imanol. All rights reserved.
//

#import "LableLine.h"
#import "UIView+Extension.h"

@implementation LableLine


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
   
    [super drawRect:rect];
    
    [self.textColor set];
    
    CGFloat x = 0;
    CGFloat y = self.height * 0.5;
    CGFloat w = self.width;
    CGFloat h = 0.5 ;
    
    UIRectFill(CGRectMake(x, y, w, h));
}


@end
