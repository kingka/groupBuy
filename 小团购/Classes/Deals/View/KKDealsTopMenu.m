//
//  KKDealsTopMenu.m
//  小团购
//
//  Created by Imanol on 9/27/15.
//  Copyright (c) 2015 Imanol. All rights reserved.
//

#import "KKDealsTopMenu.h"

@implementation KKDealsTopMenu

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(instancetype)menu{
    
    return [[[NSBundle mainBundle]loadNibNamed:@"KKDealsTopMenu" owner:nil options:nil  ]lastObject];
}

- (IBAction)buttonClick:(UIButton *)sender {
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if(self){
#warning fobiden auto resize;
        self.autoresizingMask = UIViewAutoresizingNone;
    }
    
    return self;
}
@end
