//
//  KKCity.m
//  小团购
//
//  Created by Imanol on 15/9/22.
//  Copyright (c) 2015年 Imanol. All rights reserved.
//

#import "KKCity.h"
#import "MJExtension.h"
#import "KKRegion.h"

@implementation KKCity


+(NSDictionary *)objectClassInArray{
    
    return @{@"regions" : [KKRegion class]};
}
@end
