//
//  DetailViewController.h
//  DayX
//
//  Created by Derik Flanary on 1/13/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EntryController.h"




@interface DetailViewController : UIViewController

@property (nonatomic, assign)NSInteger entryIndex;
@property (nonatomic, strong)NSDictionary *entryDictionary;
@property (nonatomic, strong)Entry *thisEntry;

- (void)updateWithEntry:(Entry *)entry;


@end
