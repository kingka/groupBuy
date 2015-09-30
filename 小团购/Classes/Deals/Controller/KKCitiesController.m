//
//  KKCitiesController.m
//  小团购
//
//  Created by Imanol on 9/30/15.
//  Copyright (c) 2015 Imanol. All rights reserved.
//

#import "KKCitiesController.h"

@interface KKCitiesController ()<UISearchBarDelegate>
- (IBAction)closeClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation KKCitiesController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


- (IBAction)closeClick:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - searchBarDelegate
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{

    searchBar.backgroundImage = [UIImage imageNamed:@"bg_login_textfield_hl"];
    searchBar.showsCancelButton = YES;
    self.navBarTopLc.constant = -62;
    [UIView animateWithDuration:0.25 animations:^{
        // 让约束执行动画
        [self.view layoutIfNeeded];
        // 让遮盖慢慢出
        self.coverBtn.alpha = 0.5;
    }];
    
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    
    searchBar.showsCancelButton = NO;
    self.coverBtn.alpha = 0.0;
    self.navBarTopLc.constant = 0;
    [UIView animateWithDuration:0.25 animations:^{
        // 让约束执行动画
        [self.view layoutIfNeeded];
        // 让遮盖慢慢出
        self.coverBtn.alpha = 0.0;
    }];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
    searchBar.showsCancelButton = NO;
    self.coverBtn.alpha = 0.0;
    [searchBar endEditing:YES];
}
- (IBAction)coverClick:(UIButton *)sender {
    
    [self.searchBar endEditing:YES];
    self.navBarTopLc.constant = 0.0;
    [UIView animateWithDuration:0.25 animations:^{
        // 让约束执行动画
        [self.view layoutIfNeeded];
        // 让遮盖慢慢出
        self.coverBtn.alpha = 0.0;
    }];
}
@end
