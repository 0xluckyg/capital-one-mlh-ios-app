//
//  UIPrinciple.h
//  Wanto
//
//  Created by Scott Cho on 8/6/16.
//  Copyright © 2016 Scott Cho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface UIPrinciple : NSObject

@property (nonatomic, strong) UIColor *defaultOrange;
@property (nonatomic, strong) UIColor *lightOrange;

-(UIFont*)wantoFontWithSize: (int)size;

@end
