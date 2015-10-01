//
//  KKCitiesResultController.h
//  小团购
//
//  Created by Imanol on 10/1/15.
//  Copyright (c) 2015 Imanol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKMetaDataTool.h"
#import "KKCity.h"

@interface KKCitiesResultController : UITableViewController

@property (strong, nonatomic)NSString* searchText;
@property (strong, nonatomic)NSArray *cities;
@end
