//
//  ViewController.m
//  Tarabut Test
//
//  Created by M Salman Khan on 07/07/2021.
//

#import "ViewController.h"
#import "GlobalTableViewCell.h"
#import "DataHolder.h"
#import "WeatherDetailVC.h"
#import "Utils.h"

@interface ViewController ()
{
    GlobalTableViewCell *cell;
}

@property (weak,nonatomic) IBOutlet UITableView *tblTempList;
@property (weak,nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (strong, nonatomic) NSMutableArray *arrayTemperature;
@property (nonatomic,strong) NSMutableDictionary *dictMyTemperature;
@property (nonatomic,strong) NSUserDefaults *preferences;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.segmentedControl.selectedSegmentIndex = 0;
    [self getDataFrom:[DataHolder getInstance].httpUrl];
    //self.tblTempList.hidden = YES;

}

- (IBAction)segmentTemperature:(id)sender
{
    
    if (self.segmentedControl.selectedSegmentIndex == 0)
    {
        [DataHolder getInstance].strTempType = @"F";
        [self getDataFrom:[DataHolder getInstance].httpUrl];
        
    }
    else if (self.segmentedControl.selectedSegmentIndex == 1)
    {
        [DataHolder getInstance].strTempType = @"C";
        [self getDataFrom:[DataHolder getInstance].httpUrl];
    }
}


- (NSString *) getDataFrom:(NSString *)url{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:url]];
    
    NSError *error = nil;
    NSHTTPURLResponse *responseCode = nil;
    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    if([responseCode statusCode] != 200)
    {
        NSLog(@"Error getting %@, HTTP status code %li", url, (long)[responseCode statusCode]);
        self.tblTempList.hidden = YES;
        self.arrayTemperature = [self.preferences valueForKey:@"Weather_Value"];
        
        return nil;
    }
    else
    {
    
        NSError *error = nil;
        NSString *responseData = [[NSString alloc]initWithData:oResponseData encoding:NSUTF8StringEncoding];
        id JSON = [NSJSONSerialization JSONObjectWithData:oResponseData options: NSJSONReadingMutableContainers error:&error];
        //NSDictionary *dictWeather = [JSON objectForKey:@"weather"];
        NSDictionary *dictMain = [JSON objectForKey:@"main"];
        NSDictionary *dictSystem = [JSON objectForKey:@"sys"];
        NSLog(@"Weather Resp: %@",responseData);
        self.dictMyTemperature = [[NSMutableDictionary alloc] init];
        self.arrayTemperature = [[NSMutableArray alloc] init];
        [self.dictMyTemperature setObject:[dictMain valueForKey:@"humidity"] forKey:@"Humaidity"];
        [self.dictMyTemperature setObject:[dictMain valueForKey:@"pressure"] forKey:@"AirPressure"];
        [self.dictMyTemperature setObject:[dictMain valueForKey:@"temp"] forKey:@"CurrentTemperature"];
        [self.dictMyTemperature setObject:[dictMain valueForKey:@"temp_max"] forKey:@"MaxTemperature"];
        [self.dictMyTemperature setObject:[dictMain valueForKey:@"temp_min"] forKey:@"MinTemperature"];
        [self.dictMyTemperature setObject:[dictMain valueForKey:@"feels_like"] forKey:@"Feeling"];
        [self.dictMyTemperature setObject:[dictSystem valueForKey:@"country"] forKey:@"Country"];
        [self.dictMyTemperature setObject:[dictSystem valueForKey:@"sunrise"] forKey:@"Sunrise"];
        [self.dictMyTemperature setObject:[dictSystem valueForKey:@"sunset"] forKey:@"Sunset"];
        
        if (self.segmentedControl.selectedSegmentIndex == 0)
        {
            cell.lblTemperature.text = [Utils Kalvin_to_fahrenheit:[dictMain valueForKey:@"temp"]];
            [DataHolder getInstance].strTempType = @"F";
        }
        else if (self.segmentedControl.selectedSegmentIndex == 1)
        {
            cell.lblTemperature.text = [Utils Kalvin_to_Celcius:[dictMain valueForKey:@"temp"]];
            [DataHolder getInstance].strTempType = @"C";
            
        }
        [self.arrayTemperature addObject:self.dictMyTemperature];
        self.preferences = [NSUserDefaults standardUserDefaults];
        [self.preferences setObject:self.arrayTemperature forKey:@"Weather_Value"];
        
    }
    self.tblTempList.hidden = NO;
    return [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
}

#pragma mark - UITableViewDelegate and UITableViewDataSource methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  [self.arrayTemperature count];
}
-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *cellIdentifier = NSStringFromClass([GlobalTableViewCell class]);
    cell = [self.tblTempList dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[GlobalTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    //NSDictionary *dictTemp = [self.arrayTemperature objectAtIndex:indexPath.row];
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    WeatherDetailVC *vc = [storyBoard instantiateViewControllerWithIdentifier:@"WeatherDetailVC"];
    NSDictionary *dictTemps = [self.arrayTemperature objectAtIndex:indexPath.row];
    vc.strSunset = [NSString stringWithFormat:@"%@",[dictTemps objectForKey:@"Sunset"]];
    vc.strSunrise = [NSString stringWithFormat:@"%@",[dictTemps objectForKey:@"Sunrise"]];
    vc.strMinTemp = [NSString stringWithFormat:@"%@",[dictTemps objectForKey:@"MinTemperature"]];
    vc.strMaxTemp = [NSString stringWithFormat:@"%@",[dictTemps objectForKey:@"MaxTemperature"]];
    vc.strHumidity = [NSString stringWithFormat:@"%@",[dictTemps objectForKey:@"Humaidity"]];
    vc.strAirPressure = [NSString stringWithFormat:@"%@",[dictTemps objectForKey:@"AirPressure"]];
    vc.strFeelsLike = [NSString stringWithFormat:@"%@",[dictTemps objectForKey:@"Feeling"]];
    [self.navigationController pushViewController:vc animated:true];
    
}


@end
