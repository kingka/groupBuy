//
//  AppDelegate.m
//  小团购
//
//  Created by Imanol on 15/9/16.
//  Copyright (c) 2015年 Imanol. All rights reserved.
//

#import "AppDelegate.h"
#import <UMSocial.h>
#import "KKDealsViewController.h"
#import "KKNavigationController.h"
#import "AlixPayResult.h"
#import <SDWebImageManager.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    KKDealsViewController *dealsVC = [[KKDealsViewController alloc]init];
    KKNavigationController *nav = [[KKNavigationController alloc]initWithRootViewController:dealsVC];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    [UMSocialData setAppKey:@"5615231ae0f55acbc7003114"];
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    [self parse:url application:application];
    return YES;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    [self parse:url application:application];
    return YES;
}

- (void)parse:(NSURL *)url application:(UIApplication *)application {
    
    //结果处理
    AlixPayResult* result = [self handleOpenURL:url];
    
    if (result.statusCode == 9000) { // 成功
        /*
         *用公钥验证签名 严格验证请使用result.resultString与result.signString验签
         */
        
        //交易成功
        //            NSString* key = @"签约帐户后获取到的支付宝公钥";
        //			id<DataVerifier> verifier;
        //            verifier = CreateRSADataVerifier(key);
        //
        //			if ([verifier verifyString:result.resultString withSign:result.signString])
        //            {
        //                //验证签名成功，交易结果无篡改
        //			}
        
    } else {
        // 失败
    }
    
}

- (AlixPayResult *)resultFromURL:(NSURL *)url {
    NSString * query = [[url query] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
#if ! __has_feature(objc_arc)
    return [[[AlixPayResult alloc] initWithString:query] autorelease];
#else
    return [[AlixPayResult alloc] initWithString:query];
#endif
}

- (AlixPayResult *)handleOpenURL:(NSURL *)url {
    AlixPayResult * result = nil;
    
    if (url != nil && [[url host] compare:@"safepay"] == 0) {
        result = [self resultFromURL:url];
    }
    
    return result;
}


@end
