//
//  Utils.m
//  Tarabut Test
//
//  Created by M Salman Khan on 07/07/2021.
//

#import "Utils.h"

@implementation Utils


+(NSDate *)Get_UTFormatedDate_Time:(NSString *)strDate
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:([strDate doubleValue] / 1000.0)];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"hh:mm aa"];
    return [df stringFromDate:date];
}

+(NSString *)Kalvin_to_fahrenheit:(NSString *)strTemp;
{
    double kelvin = [strTemp doubleValue];
    double fahrenheit = ((kelvin + 459.67)*(5.0/9.0)); //(fahrenheit - 273.15);
    return [[NSString alloc] initWithFormat:@"%0.0f F",fahrenheit];
    
}
+(NSString *)Kalvin_to_Celcius:(NSString *)strTemp;
{
    double kelvin = [strTemp doubleValue];
    double Celcius = (kelvin - 273.15);
    return [[NSString alloc] initWithFormat:@"%0.0f C",Celcius];
}


@end
