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
#import <UMSocial.h>
#import "KKLocalTool.h"
#import "MBProgressHUD+KK.h"
// 支付宝头文件
#import "AlixPayOrder.h"
#import "PartnerConfig.h"
#import "DataSigner.h"
#import "AlixLibService.h"

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
    [[KKLocalTool sharedLocalTool] saveHistoryDeal:self.deal];
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
    //deadTime formatter
    // 剩余时间处理
    // 当前时间 2014-08-27 09:06
    NSDate *now = [NSDate date];
    // 过期时间 2014-08-28 00:00
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSDate *deadTime = [[fmt dateFromString:self.deal.purchase_deadline] dateByAddingTimeInterval:24 * 3600];
    // 比较2个时间的差距
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute;
    NSDateComponents *cmps = [calendar components:unit fromDate:now toDate:deadTime options:0];
    if (cmps.day > 365) {
        self.leftTimeButton.title = @"一年内不过期";
    } else {
        self.leftTimeButton.title = [NSString stringWithFormat:@"%d天%d小时%d分", cmps.day, cmps.hour, cmps.minute];
    }

}


-(void)setupBasicView{
    
    self.view.backgroundColor = myColor(230, 230, 230);
    self.collect.selected = [[KKLocalTool sharedLocalTool].collectArray containsObject:self.deal];
    //self.webView.scrollView.hidden = YES;
}

- (IBAction)back:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)buy:(id)sender {
    // 1.生成订单信息
    AlixPayOrder *order = [[AlixPayOrder alloc] init];
    order.partner = PartnerID; // 商户ID
    order.seller = SellerID; // 帐号ID
    
    order.tradeNO = @"2014082717183778587475"; // 订单ID（由商家自行制定）
    order.productName = self.deal.title; // 商品标题
    order.productDescription = self.deal.desc; // 商品描述
    order.amount = [NSString stringWithFormat:@"%.2f", [self.deal.current_price floatValue]]; //商品价格
    order.notifyURL =  @"http%3A%2F%2Fwwww.xxx.com"; // 回调URL
    
    // 2.签名加密
//    id<DataSigner> signer = CreateRSADataSigner(PartnerPrivKey);
//    NSString *signedString = [signer signString:[order description]];
//
//    // 3.利用订单信息、签名信息、签名类型生成一个订单字符串
//    NSString *orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
//                             [order description], signedString, @"RSA"];
//    
//    // 4.打开支付宝,传递订单信息
//    [AlixLibService payOrder:orderString AndScheme:@"kk" seletor:@selector(paymentResultDelegate:) target:self];

}

-(void)paymentResultDelegate:(NSString *)result
{
    NSLog(@"%@",result);
}

- (IBAction)collect:(id)sender {
    
    if(self.collect.isSelected){
        
        [[KKLocalTool sharedLocalTool] unSaveCollectDeal:self.deal];
        [MBProgressHUD showSuccess:@"取消收藏"];
    }else{
        
        [[KKLocalTool sharedLocalTool] saveCollectDeal:self.deal];
        [MBProgressHUD showSuccess:@"收藏成功"];
    }
    
    self.collect.selected = !self.collect.isSelected;
}

- (IBAction)share:(id)sender {
    //注意：分享到微信好友、微信朋友圈、微信收藏、QQ空间、QQ好友、来往好友、来往朋友圈、易信好友、易信朋友圈、Facebook、Twitter、Instagram等平台需要参考各自的集成方法
    //如果需要分享回调，请将delegate对象设置self，并实现下面的回调方法
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"5615231ae0f55acbc7003114"
                                      shareText:self.deal.title
                                     shareImage:self.dealImageView.image
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,nil]
                                       delegate:nil];
}

@end
