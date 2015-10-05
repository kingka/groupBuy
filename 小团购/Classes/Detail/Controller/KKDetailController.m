//
//  KKDetailController.m
//  小团购
//
//  Created by Imanol on 10/5/15.
//  Copyright (c) 2015 Imanol. All rights reserved.
//

#import "KKDetailController.h"
#import "MBProgressHUD+KK.h"
#import "KKDeal.h"
#import "LableLine.h"
#import "UIButton+Extension.h"
#import "KKDealsConst.h"

@interface KKDetailController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIView *leftView;
- (IBAction)back:(UIButton *)sender;

- (IBAction)buy:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *collect;
- (IBAction)collect:(id)sender;
- (IBAction)share:(id)sender;

// label
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentPriceLabel;
@property (weak, nonatomic) IBOutlet LableLine *originLabel;

// 按钮
@property (weak, nonatomic) IBOutlet UIButton *refundableAnyTimeButton;
@property (weak, nonatomic) IBOutlet UIButton *refundableExpiresButton;
@property (weak, nonatomic) IBOutlet UIButton *leftTimeButton;
@property (weak, nonatomic) IBOutlet UIButton *purchaseCountButton;

@property (nonatomic, weak) UIActivityIndicatorView *loadingView;

@end

@implementation KKDetailController

#pragma mark - privateMethods
/**
 *  更新左边的内容
 */
- (void)updateLeftContent
{
    // 简单信息
    self.titleLabel.text = self.deal.title;
    self.descLabel.text = self.deal.desc;
    self.currentPriceLabel.text = [NSString stringWithFormat:@"￥%@", self.deal.current_price];
    self.originLabel.text = [NSString stringWithFormat:@"门店价￥%@", self.deal.list_price];
    //self.refundableAnyTimeButton.selected = self.deal.restrictions.is_refundable;
    //self.refundableExpiresButton.selected = self.deal.restrictions.is_refundable;
    self.purchaseCountButton.title = [NSString stringWithFormat:@"已售出%d", self.deal.purchase_count];
}

#pragma mark - lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = myColor(230, 230, 230);
    [self setupWebView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupWebView{
    self.webView.delegate = self;
    NSURL *url = [NSURL URLWithString:self.deal.deal_h5_url];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}
#pragma mark - UIWebViewDelegate
-(void)webViewDidFinishLoad:(UIWebView *)webView{


}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{

    return YES;
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    
}



- (IBAction)back:(UIButton *)sender {
}

- (IBAction)buy:(id)sender {
}
- (IBAction)collect:(id)sender {
}

- (IBAction)share:(id)sender {
}
@end
