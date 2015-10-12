//
//  KKLocalTool.m
//  小团购
//
//  Created by Imanol on 15/10/10.
//  Copyright (c) 2015年 Imanol. All rights reserved.
//

#import "KKLocalTool.h"
#import "KKDeal.h"

@interface KKLocalTool ()

@property(strong, nonatomic)NSMutableArray *historyArray;
@end
@implementation KKLocalTool
KKSingletonM(LocalTool)
-(NSMutableArray *)historyArray{
    
    if(_historyArray == nil){
        
        self.historyArray = [NSKeyedUnarchiver unarchiveObjectWithFile:KKHistoryDealsFile];
        if(_historyArray ==nil){
            
            self.historyArray = [NSMutableArray array];
        }
    }
    
    return _historyArray;
}

-(void)saveHistoryDeal:(KKDeal *)deal{
    
    [self.historyArray removeObject:deal];
    [self.historyArray insertObject:deal atIndex:0];
    [NSKeyedArchiver archiveRootObject:self.historyArray toFile:KKHistoryDealsFile];
}
@end
