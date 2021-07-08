//
//  Utils.h
//  Tarabut Test
//
//  Created by M Salman Khan on 07/07/2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Utils : NSObject

+(NSDate *)Get_UTFormatedDate_Time:(NSString *)strDate;
+(NSString *)Kalvin_to_fahrenheit:(NSString *)strTemp;
+(NSString *)Kalvin_to_Celcius:(NSString *)strTemp;

@end

NS_ASSUME_NONNULL_END
