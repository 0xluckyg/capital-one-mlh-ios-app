//
//  BrowseCell.m
//  Wanto
//
//  Created by Scott Cho on 8/7/16.
//  Copyright © 2016 Scott Cho. All rights reserved.
//

#import "BrowseCell.h"

@implementation BrowseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.browseImage.layer.cornerRadius = self.browseImage.frame.size.width /2;
    self.browseImage.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
