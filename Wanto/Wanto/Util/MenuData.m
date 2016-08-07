//
//  MenuData.m
//  Wanto
//
//  Created by Scott Cho on 8/7/16.
//  Copyright © 2016 Scott Cho. All rights reserved.
//

#import "MenuData.h"

NSString *const kMenuImage = @"menuImageName";
NSString *const kMenuName = @"menuName";

@implementation MenuData

-(instancetype)init {
    self = [super init];
    
    if (self) {
        
        self.menuDataArray = [NSArray arrayWithObjects:
                              @{kMenuImage: @"food",
                                kMenuName: @"Food"},
                              @{kMenuImage: @"movie",
                                kMenuName: @"Movie"},
                              @{kMenuImage: @"sports",
                                kMenuName: @"Sports"},
                              @{kMenuImage: @"clothes",
                                kMenuName: @"Apparel"},
                              nil];
        
    }

    return self;
}

@end
