//
//  Browse.m
//  Wanto
//
//  Created by Scott Cho on 8/7/16.
//  Copyright © 2016 Scott Cho. All rights reserved.
//

//
//  Browse.m
//  Wanto
//
//  Created by Scott Cho on 8/6/16.
//  Copyright © 2016 Scott Cho. All rights reserved.
//

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#import "Browse.h"

@interface Browse () {
    bool gotData;
}

@end

@implementation Browse

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initializeSettings];
    [self initializeDesign];

}

//- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
//    NSLog(@"OldLocation %f %f", oldLocation.coordinate.latitude, oldLocation.coordinate.longitude);
//    NSLog(@"NewLocation %f %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
//}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    self.location = locations.lastObject;
    
    self.UIPrinciple = [[UIPrinciple alloc] init];

    
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    hud.mode = MBProgressHUDModeIndeterminate;
//    hud.label.text = @"Loading";
//    hud.tintColor = [UIColor whiteColor];
//    hud.bezelView.color = [self.UIPrinciple.defaultOrange colorWithAlphaComponent:1.0f];
//    [hud showAnimated:YES];
    
    NSLog(@"location %f %f", self.location.coordinate.latitude, self.location.coordinate.longitude);
    NSLog(@"functioncalled");
    
    NSLog(@"%@", self.location.description);
    
    if (gotData == true) {
    
        NSString *serverLocation = [NSString stringWithFormat:@"http://9c23e10c.ngrok.io/api?lat=%f&lng=%f",self.location.coordinate.latitude, self.location.coordinate.longitude];
        
        NSURL *url = [[NSURL alloc] initWithString:serverLocation];

        NSURLRequest *request = [NSURLRequest requestWithURL:url];

        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler: ^(NSData *data, NSURLResponse *response, NSError *error){
            
            if (error) {
                NSLog(@"%@", error);
            } else {
                self.places = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                NSLog(@"%@", self.places);
                NSLog(@"Parse ended");
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                });
            }
        }];
        
        gotData = false;

        [task resume];
        
    }
    
    if ([self.places count] != 0) {
//        [hud hideAnimated:YES];
    }
    
}

- (void)initializeSettings {
    
    self.imageCache = [[NSCache alloc] init];
    self.places = [[NSMutableDictionary alloc] init];
    
    gotData = true;
    
    self.location = [[CLLocation alloc] init];
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    // Code to check if the app can respond to the new selector found in iOS 8. If so, request it.
    if([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.locationManager requestAlwaysAuthorization];
        // Or [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startUpdatingLocation];
    
}

- (void)initializeDesign {
    
    self.navigationItem.title = self.type;
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"Back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:normal target:self action:@selector(backButtonPressed)];
    
    self.navigationItem.leftBarButtonItem = leftButton;
    
}

-(void)backButtonPressed {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.places.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BrowseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"browseCell"];
    
//    Place *place = self.places[indexPath.row];
//    
//    if (cell) {
////        cell.browseImage.image = [UIImage imageNamed:place.imageUrl];
//        cell.browseName.text = place.name;
//        cell.browseDescription.text = place.desc;
//        cell.browsePriceRange.text = place.price;
//        cell.browseRating.text = place.rating;
//    }
//
    
    NSLog(@"this is data for table view %@", self.places);
    
    NSArray *tableCellData = [self.places allValues];
    
    NSDictionary *tableCellInfo = [tableCellData objectAtIndex:indexPath.row];
    
    cell.browseName.text = [tableCellInfo objectForKey:@"m_name"];
    cell.browseRating.text = [NSString stringWithFormat:@"%@",[tableCellInfo objectForKey:@"m_rating"]];
    cell.browseDescription.text = [NSString stringWithFormat:@"%@",[tableCellInfo objectForKey:@"m_snippet_text"]];
    
    NSString *photoUrl = [NSString stringWithFormat:@"%@",[tableCellInfo objectForKey:@"m_image_url"]];

    if (photoUrl != NULL) {
        NSURL *profileImageUrl = [NSURL URLWithString:photoUrl];
        [self loadAndCacheImage:cell photoUrl:profileImageUrl cache:self.imageCache];
    } else {
        cell.browseImage.image = [[UIImage alloc] init];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *tableCellData = [self.places allValues];
    
    NSDictionary *tableCellInfo = [tableCellData objectAtIndex:indexPath.row];

    NSString *urlString = [NSString stringWithFormat:@"%@", [tableCellInfo objectForKey:@"m_url"]];
    
    UIStoryboard *detailStoryboard = [UIStoryboard storyboardWithName:@"Detail" bundle:nil];
    Detail *detailVC = [detailStoryboard instantiateViewControllerWithIdentifier:@"Detail"];
    
    detailVC.type = @"Detail";
    
    detailVC.pageUrlString = urlString;
    
    [self.navigationController pushViewController:detailVC animated:YES];

}

//Function for downloading and caching the image
-(void)loadAndCacheImage:(BrowseCell *)browseCell photoUrl:(NSURL *)photoUrl cache:(NSCache *)imageCache {
    
    //Set default to nil
    browseCell.browseImage.image = nil;
    
    NSURL *profileImageUrl = photoUrl;
    
    UIImage *cachedImage = [imageCache objectForKey:profileImageUrl];
    
    if (cachedImage) {
        
        browseCell.browseImage.image = cachedImage;
        
    } else {
        
        [[[NSURLSession sharedSession] dataTaskWithURL:profileImageUrl completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error != nil) {
                NSLog(@"%@", error);
                return;
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                UIImage *downloadedImage = [UIImage imageWithData:data];
                
                if (downloadedImage != nil) {
                    
                    [imageCache setObject:downloadedImage forKey:profileImageUrl];
                    
                }
                
                browseCell.browseImage.image = downloadedImage;
                
            });
            
        }] resume];
        
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
