//
//  ViewController.m
//  SimulatorLocation
//
//  Created by yidao on 2019/9/5.
//

#import "ViewController.h"
#import "SSYLocationChanged.h"

@interface ViewController ()<CLLocationManagerDelegate>

@property (nonatomic, strong)CLLocationManager *locationManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _locationManager =[[CLLocationManager alloc]init];
    _locationManager.delegate =self;
    //设置定位经准
    _locationManager.desiredAccuracy =kCLLocationAccuracyNearestTenMeters;
    [_locationManager requestWhenInUseAuthorization];//否则，ios10不弹定位框
    _locationManager.distanceFilter =10.0f;
    //开始定位
    [_locationManager startUpdatingLocation];
    
    // Do any additional setup after loading the view.
}

//定位代理经纬度回调
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation *newLocation =locations[0];
    CLLocationCoordinate2D oCoordinate =newLocation.coordinate;
    [_locationManager stopUpdatingLocation];
    
    NSLog(@"经度------%f\n------纬度%f",oCoordinate.longitude,oCoordinate.latitude);
    //创建地理位置解码编码器对象
    CLGeocoder *geoCoder =[[CLGeocoder alloc]init];
    [geoCoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        for (CLPlacemark *place in placemarks) {
            NSLog(@"城市-----%@",place.locality);
        }
    }];
}


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    if ([error code] == kCLErrorDenied){
        //访问被拒绝
        NSLog(@"访问被拒绝");
    }
    if ([error code] == kCLErrorLocationUnknown) {
        //无法获取位置信息
        NSLog(@"无法获取位置信息");
    }
}


@end
