//
//  EntryController.m
//  DayX
//
//  Created by Derik Flanary on 1/17/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "EntryController.h"
#import "Stack.h"

static NSString * const entryKey = @"entries";

@interface EntryController ()

@property (nonatomic, strong) NSArray *entries;

@end

@implementation EntryController

+ (EntryController *)sharedInstance {
    static EntryController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[EntryController alloc] init];
        
        
    });
    return sharedInstance;
}


-(void)addEntryWithTitle:(NSString *)title andText:(NSString *)text{
    
    Entry *newEntry =  [NSEntityDescription insertNewObjectForEntityForName:@"Entry"
                                                  inManagedObjectContext:[Stack sharedInstance].managedObjectContext];
    newEntry.title = title;
    newEntry.text = text;
    newEntry.date = [NSDate date];
    
    [self synchronize];
}


-(void)removeEntry:(Entry *)entry{
    [[Stack sharedInstance].managedObjectContext deleteObject:entry];
    [self synchronize];
    
}

-(NSArray *)entries{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Entry"];
    
    NSArray *allEntries = [[Stack sharedInstance].managedObjectContext executeFetchRequest:fetchRequest error:NULL];
    
    return allEntries;
}

-(void)synchronize{
    
    [[Stack sharedInstance].managedObjectContext save:NULL];
}


@end
