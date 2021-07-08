//
//  WeatherDetailVC.h
//  Tarabut Test
//
//  Created by M Salman Khan on 07/07/2021.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WeatherDetailVC : UIViewController

@property (nonatomic,strong) NSString *strSunset;
@property (nonatomic,strong) NSString *strSunrise;
@property (nonatomic,strong) NSString *strMaxTemp;
@property (nonatomic,strong) NSString *strMinTemp;
@property (nonatomic,strong) NSString *strAirPressure;
@property (nonatomic,strong) NSString *strHumidity;
@property (nonatomic,strong) NSString *strFeelsLike;

@end

NS_ASSUME_NONNULL_END
