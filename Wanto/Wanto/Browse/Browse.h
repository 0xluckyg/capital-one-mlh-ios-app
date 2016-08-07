//
//  Browse.h
//  Wanto
//
//  Created by Scott Cho on 8/7/16.
//  Copyright © 2016 Scott Cho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Detail.h"
#import "BrowseCell.h"
#import <CoreLocation/CoreLocation.h>
#import "Place.h"
#import "MBProgressHud.h"
#import "UIPrinciple.h"

@interface Browse : UITableViewController <CLLocationManagerDelegate> {
    
}

@property (strong, nonatomic) NSCache *imageCache;

@property (strong, nonatomic) UIPrinciple *UIPrinciple;

@property (strong, nonatomic) NSString *type;

@property (strong, nonatomic) CLLocationManager *locationManager;

@property (strong, nonatomic) CLLocation *location;

@property (strong, nonatomic) NSMutableDictionary *places;

@property (strong, nonatomic) Place *place;

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations;

@end
