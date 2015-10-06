//
//  KKDealsConst.h
//  小团购
//
//  Created by Imanol on 10/1/15.
//  Copyright (c) 2015 Imanol. All rights reserved.
//

#ifndef ____KKDealsConst_h
#define ____KKDealsConst_h

/** Notification */
#define KKSortDidSelectNotification @"KKSortDidSelectNotification"
#define KKSelectedSort @"KKSelectedSort"

#define KKCityDidSelectNotification @"KKCityDidSelectNotification"
#define KKSelectedCity @"KKSelectedCity"

#define KKRegionDidSelectNotification @"KKRegionDidSelectNotification"
#define KKSelectedRegion @"SelectedRegion"
#define KKSelectedSubRegion @"SelectedSubRegion"

#define KKCategoryDidSelectNotification @"KKCategoryDidSelectNotification"
#define KKSelectedCategory @"KKSelectedCategory"
#define KKSelectedSubCategory @"KKSelectedSubCategory"

#define KKNotificationCenter [NSNotificationCenter defaultCenter]

#define KKAddObserver(methodName,notificationName) [KKNotificationCenter addObserver:self selector:@selector(methodName) name:notificationName object:nil];

#define KKColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define KKGlobalBg HMColor(230, 230, 230)

#define myColor(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define KKSelectedCityNamesFile [[NSSearchPathForDirectoriesInDomains( NSDocumentationDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"recentCityNames.plist"]
#endif
