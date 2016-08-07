//
//  UIPrinciple.m
//  Wanto
//
//  Created by Scott Cho on 8/6/16.
//  Copyright © 2016 Scott Cho. All rights reserved.
//

#import "UIPrinciple.h"

@implementation UIPrinciple

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _defaultOrange = [UIColor colorWithRed:242.0f/255.0f green:150.0f/255.0f blue:81.0f/255.0f alpha:1.0f];
        
        _lightOrange = [UIColor colorWithRed:240.0f/255.0f green:123.0f/255.0f blue:35.0f/255.0f alpha:1.0f];

    }
    return self;
}

-(UIFont*)wantoFontWithSize: (int)size {
    return [UIFont fontWithName:@"HelveticaNeue-Light" size:size];
}


@end
