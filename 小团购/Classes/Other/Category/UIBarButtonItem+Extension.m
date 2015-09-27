//
//  UIBarButtonItem+Extension.m
//  小团购
//
//  Created by Imanol on 9/27/15.
//  Copyright (c) 2015 Imanol. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"
#import "UIView+Extension.h"

@implementation UIBarButtonItem (Extension)

+(UIBarButtonItem *)itemWithImageName:(NSString *)imageName highlightImageName:(NSString *)highlightName target:(id)target action:(SEL)action{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highlightName] forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.size = btn.currentImage.size;
    btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}

@end
