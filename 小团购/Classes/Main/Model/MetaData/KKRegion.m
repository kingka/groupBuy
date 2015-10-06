//
//  KKRegion.m
//  小团购
//
//  Created by Imanol on 15/9/22.
//  Copyright (c) 2015年 Imanol. All rights reserved.
//

#import "KKRegion.h"
#import "MJExtension.h"

@implementation KKRegion
MJCodingImplementation

-(NSString *)title{
    
    return _name;
}

-(NSArray *)subItems{
    
    return _subregions;
}
@end
