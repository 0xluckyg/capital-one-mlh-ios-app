//
//  Place.h
//  Wanto
//
//  Created by Scott Cho on 8/7/16.
//  Copyright © 2016 Scott Cho. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Place : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *desc;
@property (strong, nonatomic) NSString *price;
@property (strong, nonatomic) NSString *rating;
@property (strong, nonatomic) NSString *imageUrl;

@end
