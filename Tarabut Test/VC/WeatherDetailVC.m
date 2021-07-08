//
//  WeatherDetailVC.m
//  Tarabut Test
//
//  Created by M Salman Khan on 07/07/2021.
//

#import "WeatherDetailVC.h"
#import "Utils.h"
#import "DataHolder.h"

@interface WeatherDetailVC ()

@property (weak,nonatomic) IBOutlet UILabel *lblSunset;
@property (weak,nonatomic) IBOutlet UILabel *lblSunrise;
@property (weak,nonatomic) IBOutlet UILabel *lblMaxTemp;
@property (weak,nonatomic) IBOutlet UILabel *lblMinTemp;
@property (weak,nonatomic) IBOutlet UILabel *lblAirPressure;
@property (weak,nonatomic) IBOutlet UILabel *lblHumidity;
@property (weak,nonatomic) IBOutlet UILabel *lblFeelsLike;
@property (weak,nonatomic) IBOutlet UIView *viewContainer;

@end

@implementation WeatherDetailVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //self.navigationController.toolbarHidden = YES;
    self.viewContainer.layer.cornerRadius = 10;
    
    self.lblSunset.text = [NSString stringWithFormat:@"%@",[Utils Get_UTFormatedDate_Time:self.strSunset]];
    self.lblSunrise.text = [NSString stringWithFormat:@"%@",[Utils Get_UTFormatedDate_Time:self.strSunrise]];
    
    if ([[DataHolder getInstance].strTempType isEqualToString:@"C"])
    {
        self.lblMaxTemp.text = [NSString stringWithFormat:@"%@",[Utils Kalvin_to_Celcius:self.strMaxTemp]];
        self.lblMinTemp.text = [NSString stringWithFormat:@"%@",[Utils Kalvin_to_Celcius:self.strMinTemp]];
        self.lblFeelsLike.text = [NSString stringWithFormat:@"%@",[Utils Kalvin_to_Celcius:self.strFeelsLike]];
    }
    else if ([[DataHolder getInstance].strTempType isEqualToString:@"F"])
    {
        self.lblMaxTemp.text = [NSString stringWithFormat:@"%@",[Utils Kalvin_to_fahrenheit:self.strMaxTemp]];
        self.lblMinTemp.text = [NSString stringWithFormat:@"%@",[Utils Kalvin_to_fahrenheit:self.strMinTemp]];
        self.lblFeelsLike.text = [NSString stringWithFormat:@"%@",[Utils Kalvin_to_fahrenheit:self.strFeelsLike]];
    }
    
    self.lblAirPressure.text = [NSString stringWithFormat:@"%@ hPa",self.strAirPressure];
    self.lblHumidity.text = [NSString stringWithFormat:@"%@ Percent",self.strHumidity];
    
}

-(IBAction)backBtn
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    [super viewWillAppear:YES];
}

@end
