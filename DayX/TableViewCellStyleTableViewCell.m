//
//  TableViewCellStyleTableViewCell.m
//  DayX
//
//  Created by Derik Flanary on 1/16/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "TableViewCellStyleTableViewCell.h"

@implementation TableViewCellStyleTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell One"];
    self.textLabel.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:20];
    
   
    
    return self;
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
