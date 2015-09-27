//
//  UIBarButtonItem+Extension.h
//  小团购
//
//  Created by Imanol on 9/27/15.
//  Copyright (c) 2015 Imanol. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+(UIBarButtonItem*)itemWithImageName:(NSString*)imageName highlightImageName:(NSString*)highlightName target:(id)target action:(SEL)action;
@end
