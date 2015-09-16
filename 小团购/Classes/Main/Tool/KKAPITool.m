//
//  KKAPITool.m
//  小团购
//
//  Created by Imanol on 15/9/16.
//  Copyright (c) 2015年 Imanol. All rights reserved.
//

#import "KKAPITool.h"
#import "DPAPI.h"

@interface KKAPITool() <DPRequestDelegate>
@property (nonatomic, strong) DPAPI *api;
@end
@implementation KKAPITool

#pragma mark -实现单例
static id _instance = nil;
+(instancetype)shareKKAPITool{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc]init];
    });
    return _instance;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

-(id)copyWithZone:(NSZone *)zone{
    
    return _instance;
}

#pragma mark -layze loading
-(DPAPI *)api{
    
    if(_api == nil){
        self.api = [[DPAPI alloc]init];
    }
    return _api;
}

#pragma mark -实现对DPAPI的封装
-(void)requset:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    DPRequest *request = [self.api requestWithURL:url params:[NSMutableDictionary dictionaryWithDictionary:params] delegate:self];
    request.success = success;
    request.failure = failure;
}

#pragma mark -DPRequestDelegate
-(void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result{
    
    if(request.success){
        request.success(result);
    }
}

-(void)request:(DPRequest *)request didFailWithError:(NSError *)error{
    if(request.failure){
        request.failure(error);
    }
}
@end
