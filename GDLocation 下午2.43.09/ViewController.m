//
//  ViewController.m
//  GDLocation
//
//  Created by Alexander Wang on 2018/2/5.
//  Copyright © 2018年 Alexander Wang. All rights reserved.
//

#import "ViewController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>

@interface ViewController ()<AMapLocationManagerDelegate>
@property (nonatomic, strong) AMapLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UILabel *licationLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLocationLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 带逆地理信息的一次定位（返回坐标和地址信息）
    self.locationManager = [[AMapLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    //   定位超时时间，最低2s，此处设置为10s
    self.locationManager.locationTimeout =10;
    //   逆地理请求超时时间，最低2s，此处设置为10s
    self.locationManager.reGeocodeTimeout = 10;
    [self.locationManager startUpdatingLocation];
    [self.locationManager setLocatingWithReGeocode:YES];
    [self.locationManager startUpdatingLocation];
}

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location {
    NSLog(@"location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
}

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode {
    if (reGeocode) {
        self.licationLabel.text = reGeocode.city;
//        self.detailLocationLabel.text = [NSString stringWithFormat:@"%@%@%@%@", reGeocode.city,reGeocode.district,reGeocode.street,reGeocode.number];
        self.detailLocationLabel.numberOfLines=0;
        self.detailLocationLabel.textAlignment = NSTextAlignmentLeft;
        self.detailLocationLabel.text = @"wqewdwef\nweqqw21";
        [self.locationManager stopUpdatingLocation];
    }
}

- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error {
    UIAlertView *alet = [[UIAlertView alloc] initWithTitle:@"当前定位服务不可用" message:@"请到“设置->隐私->定位服务”中开启定位" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alet show];
}

@end
