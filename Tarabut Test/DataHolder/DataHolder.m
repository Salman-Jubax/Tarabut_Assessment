//
//  DataHolder.m
//  Tarabut Test
//
//  Created by M Salman Khan on 07/07/2021.
//

#import "DataHolder.h"

@implementation DataHolder
{
    
}

static DataHolder *instance = nil;

+(DataHolder *)getInstance
{
    @synchronized(self)
    {
        if(instance==nil)
        {
            instance= [DataHolder new];
            instance.httpUrl = @"https://api.openweathermap.org/data/2.5/weather?q=Dubai&APPID=524bab8942f85e5509c205899351e01b";
        }
}
    return instance;
}
@end
