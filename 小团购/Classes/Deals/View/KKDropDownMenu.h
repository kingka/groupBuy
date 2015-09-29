//
//  KKDropDownMenu.h
//  小团购
//
//  Created by Imanol on 9/29/15.
//  Copyright (c) 2015 Imanol. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KKDropDownMenu : UIView<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (weak, nonatomic) IBOutlet UITableView *subTableView;

+(instancetype)dropDownMenu;
@end
