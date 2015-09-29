//
//  KKDropDownMainCell.h
//  小团购
//
//  Created by Imanol on 9/29/15.
//  Copyright (c) 2015 Imanol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKDropDownMenu.h"


@interface KKDropDownMainCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView*)tableView;
@property (nonatomic , strong) id<KKDropDownMenuItem> item;
@end
