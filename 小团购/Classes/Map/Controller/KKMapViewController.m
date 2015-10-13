//
//  KKMapViewController.m
//  小团购
//
//  Created by Imanol on 15/10/13.
//  Copyright (c) 2015年 Imanol. All rights reserved.
//

#import "KKMapViewController.h"
#import "UIBarButtonItem+Extension.h"
#import <MapKit/MapKit.h>
#import "KKFindDealParam.h"
#import "KKDealTool.h"
#import "KKDeal.h"
#import "MBProgressHUD+KK.h"
#import "KKBusiness.h"
#import "KKAnotation.h"

@interface KKMapViewController ()<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (copy, nonatomic) NSString *locationCity;
@property (nonatomic, strong) CLGeocoder *geocoder;

@end

@implementation KKMapViewController

#pragma  mark - lazyloading
- (CLGeocoder *)geocoder
{
    if (_geocoder == nil) {
        self.geocoder = [[CLGeocoder alloc] init];
    }
    return _geocoder;
}
#pragma  mark - lifycycle
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
}

-(void)setupMapView{
    
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
}

-(void)setupLeftBar{
    
    //back barItem
    UIBarButtonItem *backItem = [UIBarButtonItem itemWithImageName:@"icon_back" highlightImageName:@"icon_back_highlighted" target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = backItem;
}

-(void)back{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)moveToUserLocation:(UIButton *)sender {
    
    [self.mapView setCenterCoordinate:self.mapView.userLocation.location.coordinate animated:YES];
}

#pragma mark - MKMapViewDelegate
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    
    //create Region
    CLLocationCoordinate2D center = userLocation.location.coordinate;
    MKCoordinateSpan span = MKCoordinateSpanMake(0.1, 0.1);
    MKCoordinateRegion region = MKCoordinateRegionMake(center, span);
    
    //move to region
    [mapView setRegion:region animated:YES];
    
    //get locationCity
    [self.geocoder reverseGeocodeLocation:userLocation.location completionHandler:^(NSArray *placemarks, NSError *error) {
        if(placemarks.count == 0)return ;
        
        CLPlacemark *placeMark = [placemarks firstObject];
        NSString *city = placeMark.addressDictionary[@"State"];
        self.locationCity = [city substringToIndex:city.length-1];
        
        //locate to city , call server
        [self mapView:self.mapView regionDidChangeAnimated:YES];
    }];
}

-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    
    if(self.locationCity == nil ) return;
    //param
    KKFindDealParam *param = [[KKFindDealParam alloc]init];
    //location info
    CLLocationCoordinate2D center = mapView.region.center;
    param.latitude = @(center.latitude);
    param.longitude = @(center.longitude);
    param.radius = @1500;
    //city
    param.city = self.locationCity;
    //call server
    [KKDealTool findDeals:param success:^(KKFindDealResult *result) {
        //set annotation
        [self setupDeals:result.deals];
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"加载失败"];
    }];
    
    
}

-(void)setupDeals:(NSArray *)deals{

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for(KKDeal *deal in deals){
            
            for(KKBusiness *business in deal.businesses){
                KKAnotation *anotation = [[KKAnotation alloc]init];
                anotation.coordinate = CLLocationCoordinate2DMake(business.latitude, business.longitude);
                anotation.title = deal.title;
                anotation.subtitle = business.name;
                if([self.mapView.annotations containsObject:anotation])continue;
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [self.mapView addAnnotation:anotation];
                });
            }
        }
    });
}
@end
