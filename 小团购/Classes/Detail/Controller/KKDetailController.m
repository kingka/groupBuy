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
#import "UIView+AutoLayout.h"
#import "KKRestriction.h"
#import "KKDealTool.h"
#import "KKGetSingleDealParam.h"
#import <UIImageView+WebCache.h>

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
@property (weak, nonatomic) IBOutlet UIImageView *dealImageView;

@end

@implementation KKDetailController



#pragma mark - lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBasicView];
    [self setupWebView];
    [self setupLeftContent];
    [self updateLeftContent];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSUInteger)supportedInterfaceOrientations{
    
    return UIInterfaceOrientationMaskLandscape;
}
#pragma mark - UIWebViewDelegate
-(void)webViewDidFinishLoad:(UIWebView *)webView{


    
    NSMutableString *js = [NSMutableString string];
    [js appendString:@"var buyBox = document.getElementsByClassName('buy-box')[0];"];
    [js appendString:@"buyBox.remove();"];
    [js appendString:@"var head = document.getElementsByTagName('head')[0];"];
    [js appendString:@"var link = document.body.getElementsByTagName('link')[0];"];
    [js appendString:@"var bodyHTML = '';"];
    [js appendString:@"bodyHTML += link.outerHTML;"];
    [js appendString:@"var headbar = document.getElementsByClassName('content group-info')[0];"];
    [js appendString:@"bodyHTML += headbar.outerHTML;"];
    [js appendString:@"var details = document.getElementsByClassName('group-detail');"];
    [js appendString:@"for(var i = 0; i<=details.length;i++ ){"];
    [js appendString:@"var detail = details[i];"];
    [js appendString:@"if(detail){"];
    [js appendString:@"bodyHTML += detail.outerHTML;"];
    [js appendString:@"}"];
    [js appendString:@"}"];
    [js appendString:@"var buyKnow = document.getElementsByClassName('detail-info buy-know')[0];"];
    [js appendString:@"bodyHTML += buyKnow.outerHTML;"];
    [js appendString:@"document.body.innerHTML = bodyHTML;"];
    [js appendString:@"document.head.innerHTML = head.innerHTML;"];
        
        // 执行JS代码
    [webView stringByEvaluatingJavaScriptFromString:js];
    
    webView.scrollView.hidden = NO;
    [self.loadingView stopAnimating];

        // 移除圈圈
    [self.loadingView removeFromSuperview];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{

    NSLog(@"%@",request);
    return YES;
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    [self.loadingView stopAnimating];
}

#pragma mark - privateMethods

-(void)setupLeftContent{
    
    // 简单信息
    self.titleLabel.text = self.deal.title;
    self.descLabel.text = self.deal.desc;
    self.currentPriceLabel.text = [NSString stringWithFormat:@"￥%@", self.deal.current_price];
    self.originLabel.text = [NSString stringWithFormat:@"门店价￥%@", self.deal.list_price];
    self.purchaseCountButton.title = [NSString stringWithFormat:@"已售出%d", self.deal.purchase_count];
    [self.dealImageView sd_setImageWithURL:[NSURL URLWithString:self.deal.image_url] placeholderImage:[UIImage imageNamed:@"placeholder_deal"] options:SDWebImageRetryFailed];
    //getMoreInfo
    KKGetSingleDealParam *param = [[KKGetSingleDealParam alloc]init];
    param.deal_id = self.deal.deal_id;
    [KKDealTool getSingleDeals:param success:^(KKGetSingleDealResult *result) {
        if(result.deals.count){
        
            self.deal = [result.deals lastObject];
            [self updateLeftContent];
        }else{
            
            [MBProgressHUD showError:@"找不到指定数据"];
        }
     
    } failure:^(NSError *error) {
        
        [MBProgressHUD showError:@"加载失败"];
    }];
}

-(void)setupWebView{
    
    //webView
    self.webView.delegate = self;
    self.webView.backgroundColor = myColor(230, 230, 230);
    NSURL *url = [NSURL URLWithString:self.deal.deal_h5_url];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    self.webView.scrollView.hidden = YES;
    
    //indicatorView
    UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.webView addSubview:loadingView];
    [loadingView startAnimating];
    self.loadingView = loadingView;
    //layout
    [loadingView autoCenterInSuperview];
}


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
    self.refundableAnyTimeButton.selected = self.deal.restrictions.is_refundable;
    self.refundableExpiresButton.selected = self.deal.restrictions.is_refundable;
    self.purchaseCountButton.title = [NSString stringWithFormat:@"已售出%d", self.deal.purchase_count];
}


-(void)setupBasicView{
    
    self.view.backgroundColor = myColor(230, 230, 230);
    //self.webView.scrollView.hidden = YES;
}

- (IBAction)back:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)buy:(id)sender {
}
- (IBAction)collect:(id)sender {
}

- (IBAction)share:(id)sender {
}
@end
