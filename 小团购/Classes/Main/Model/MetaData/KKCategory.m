//
//  KKCategory.m
//  小团购
//
//  Created by Imanol on 15/9/22.
//  Copyright (c) 2015年 Imanol. All rights reserved.
//

#import "KKCategory.h"
#import "MJExtension.h"

@implementation KKCategory
MJCodingImplementation

-(NSString *)iconName{
    
    return _small_icon;
}

-(NSString *)title{
    
    return _name;
}

-(NSArray *)subItems{
    
    return _subcategories;
}
-(NSString *)iconHighlightedName{
    
    return _small_highlighted_icon;
}

@end
