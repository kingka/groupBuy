//
//  KKDealsTopMenu.h
//  小团购
//
//  Created by Imanol on 9/27/15.
//  Copyright (c) 2015 Imanol. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KKDealsTopMenu : UIView
@property (weak, nonatomic) IBOutlet UIButton *menuButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;

+(instancetype)menu;

- (IBAction)buttonClick:(UIButton *)sender;


@end
