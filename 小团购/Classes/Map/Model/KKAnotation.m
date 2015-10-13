//
//  KKAnotation.m
//  小团购
//
//  Created by Imanol on 15/10/13.
//  Copyright (c) 2015年 Imanol. All rights reserved.
//

#import "KKAnotation.h"

@implementation KKAnotation

-(BOOL)isEqual:(KKAnotation*)other{
    
    return self.coordinate.latitude == other.coordinate.latitude && self.coordinate.longitude == other.coordinate.longitude;
}
@end
