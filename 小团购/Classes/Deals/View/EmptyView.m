//
//  EmptyView.m
//  小团购
//
//  Created by Imanol on 10/5/15.
//  Copyright (c) 2015 Imanol. All rights reserved.
//

#import "EmptyView.h"
#import "UIView+AutoLayout.h"

@implementation EmptyView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)didMoveToSuperview{

    [self autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        self.image = [UIImage imageNamed:@"icon_deals_empty"];
        self.contentMode = UIViewContentModeCenter;
    }
    
    return self;
}

+(instancetype)emptyView{
    
    return [[self alloc] init];
}

@end
