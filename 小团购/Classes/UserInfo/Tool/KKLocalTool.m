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
@property(strong, nonatomic)NSMutableArray *collectArray;
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

-(NSMutableArray *)collectArray{
    if(_collectArray == nil){
        
        self.collectArray = [NSKeyedUnarchiver unarchiveObjectWithFile:KKCollectDealsFile];
        if(_collectArray ==nil){
            
            self.collectArray = [NSMutableArray array];
        }
    }
    
    return _collectArray;
}

-(void)saveHistoryDeal:(KKDeal *)deal{
    
    [self.historyArray removeObject:deal];
    [self.historyArray insertObject:deal atIndex:0];
    [NSKeyedArchiver archiveRootObject:self.historyArray toFile:KKHistoryDealsFile];
}

-(void)saveCollectDeal:(KKDeal *)deal{

    [self.collectArray insertObject:deal atIndex:0];
    [NSKeyedArchiver archiveRootObject:self.collectArray toFile:KKCollectDealsFile];
}

-(void)unSaveCollectDeal:(KKDeal *)deal{
    
    [self.collectArray removeObject:deal];
    [NSKeyedArchiver archiveRootObject:self.collectArray toFile:KKCollectDealsFile];
}
@end
