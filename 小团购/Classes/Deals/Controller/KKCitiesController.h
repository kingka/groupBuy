//
//  KKCitiesController.h
//  小团购
//
//  Created by Imanol on 9/30/15.
//  Copyright (c) 2015 Imanol. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KKCitiesController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *coverBtn;
- (IBAction)coverClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *navBarTopLc;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
