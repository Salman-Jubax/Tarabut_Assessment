//
//  DataHolder.h
//  Tarabut Test
//
//  Created by M Salman Khan on 07/07/2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DataHolder : NSObject
{
    NSString *httpUrl;
}

@property(nonatomic,copy)NSString *httpUrl;
@property(nonatomic,copy)NSString *strMinTemp;
@property(nonatomic,copy)NSString *strMaxTemp;
@property(nonatomic,copy)NSString *strTempType;
+(DataHolder *)getInstance;

@end

NS_ASSUME_NONNULL_END
