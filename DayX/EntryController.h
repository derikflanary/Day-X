//
//  EntryController.h
//  DayX
//
//  Created by Derik Flanary on 1/17/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Entry.h"
#import <CoreData/CoreData.h>

@interface EntryController : NSObject

@property (readonly, strong, nonatomic)NSArray *entries;

+ (EntryController *)sharedInstance;
-(void)removeEntry:(Entry *)entry;
-(void)synchronize;
-(void)addEntryWithTitle:(NSString *)title andText:(NSString *)text;
-(NSArray *)entries;
@end
