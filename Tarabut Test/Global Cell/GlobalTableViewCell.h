//
//  GlobalTableViewCell.h
//  Tarabut Test
//
//  Created by M Salman Khan on 07/07/2021.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GlobalTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblCountryName;
@property (weak, nonatomic) IBOutlet UILabel *lblTemperature;

@end

NS_ASSUME_NONNULL_END
