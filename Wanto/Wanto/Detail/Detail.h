//
//  Detail.h
//  Wanto
//
//  Created by Scott Cho on 8/6/16.
//  Copyright © 2016 Scott Cho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHud.h"
#import "UIPrinciple.h"

@interface Detail : UIViewController

@property (strong, nonatomic) NSString *type;

@property (strong, nonatomic) NSString *pageUrlString;

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (strong, nonatomic) UIPrinciple *UIPrinciple;

@end
