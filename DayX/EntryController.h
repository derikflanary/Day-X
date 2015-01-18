//
//  EntryController.h
//  DayX
//
//  Created by Derik Flanary on 1/17/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Entry.h"

@interface EntryController : NSObject

@property (readonly, strong)NSArray *entries;

+ (EntryController *)sharedInstance;

-(void)addEntry:(Entry *)entry;
-(void)removeEntry:(Entry *)entry;
- (void)replaceEntry:(Entry *)oldEntry withEntry:(Entry *)newEntry;



@end
