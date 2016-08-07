//
//  Menu.h
//  Wanto
//
//  Created by Scott Cho on 8/6/16.
//  Copyright © 2016 Scott Cho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuCell.h"
#import "UIPrinciple.h"
#import "MenuData.h"
#import "Browse.h"

@interface Menu : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    
    NSUInteger rowNum;
    
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) UIPrinciple *UIPrinciple;

@property (strong, nonatomic) MenuData *menuData;

@end
