//
//  BrowseCell.h
//  Wanto
//
//  Created by Scott Cho on 8/7/16.
//  Copyright © 2016 Scott Cho. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BrowseCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *browseImage;

@property (weak, nonatomic) IBOutlet UILabel *browseName;

@property (weak, nonatomic) IBOutlet UILabel *browseDescription;

@property (weak, nonatomic) IBOutlet UILabel *browsePriceRange;

@property (weak, nonatomic) IBOutlet UILabel *browseRating;

@end
