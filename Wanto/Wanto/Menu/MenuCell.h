//
//  MenuCell.h
//  Wanto
//
//  Created by Scott Cho on 8/7/16.
//  Copyright © 2016 Scott Cho. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIView *cellView;

@property (weak, nonatomic) IBOutlet UILabel *cellLabel;

@property (weak, nonatomic) IBOutlet UIImageView *cellImage;


@end
