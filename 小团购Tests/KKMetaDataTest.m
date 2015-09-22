//
//  KKMetaDataTest.m
//  小团购
//
//  Created by Imanol on 15/9/22.
//  Copyright (c) 2015年 Imanol. All rights reserved.
//


#import <XCTest/XCTest.h>
#import "KKMetaDataTool.h"

@interface KKMetaDataTest : XCTestCase

@end

@implementation KKMetaDataTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testMetaDataTest{
    
    KKMetaDataTool *tool = [KKMetaDataTool sharedMetaDataTool];
    //NSLog(@"11%@",tool.cities);
    NSLog(@"22%@",tool.categories);
    XCTAssert(tool.categories.count > 0,@"失败");
}

- (void)testMetaDataTest2{
    
    KKMetaDataTool *tool = [KKMetaDataTool sharedMetaDataTool];
    NSLog(@"%@",tool.categories);
   // XCTAssert(tool.categories.count > 0,@"失败");
}

@end
