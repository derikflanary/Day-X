//
//  EntryController.m
//  DayX
//
//  Created by Derik Flanary on 1/17/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "EntryController.h"
#import "Entry.h"

static NSString * const entryKey = @"entries";

@interface EntryController ()

@property(nonatomic, strong)NSArray *entries;

@end

@implementation EntryController

+ (EntryController *)sharedInstance {
    static EntryController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[EntryController alloc] init];
        
        [sharedInstance loadEntriesFromDefaults];
    });
    return sharedInstance;
}

-(void)addEntry:(Entry *)entry{
    if (!entry){
        return;
    }
    NSMutableArray *mutableEntries = [NSMutableArray arrayWithArray:self.entries];
    [mutableEntries addObject:entry];
    self.entries = mutableEntries;
    [self storeEntriesToDefaults:self.entries];
}

-(void)removeEntry:(Entry *)entry{
    if (!entry){
        return;
        [self storeEntriesToDefaults:self.entries];
    }
    NSMutableArray *mutableEntries = [NSMutableArray arrayWithArray:self.entries];
    if ([self.entries containsObject:entry]){
        [mutableEntries removeObject:entry];
    }
    self.entries = mutableEntries;
    
    [self storeEntriesToDefaults:self.entries];
    
}

- (void)replaceEntry:(Entry *)oldEntry withEntry:(Entry *)newEntry{
    if (!oldEntry || !newEntry){
        return;
    }
    
    NSMutableArray *mutableEntries = self.entries.mutableCopy;
    if ([mutableEntries containsObject:oldEntry]){
        NSInteger indexN = [mutableEntries indexOfObject:oldEntry];
        [mutableEntries replaceObjectAtIndex:indexN withObject:newEntry];
    }
    self.entries = mutableEntries;
    [self storeEntriesToDefaults:self.entries];
    
}

-(void)loadEntriesFromDefaults{
    NSArray *entryDictionaries = [[NSUserDefaults standardUserDefaults] objectForKey:@"Entries"];
    NSMutableArray *mutableEntryArray = [NSMutableArray array];
    for (NSDictionary *entryDict in entryDictionaries) {
        Entry *entry = [[Entry alloc] initWithDictionary:entryDict];
        [mutableEntryArray addObject:entry];
    }
    self.entries = mutableEntryArray;
}

-(void)storeEntriesToDefaults:(NSArray *)entryArray{
    NSMutableArray *mutableEntryDictionaries = [NSMutableArray array];
    for (Entry *entry in entryArray) {
        NSDictionary *entryDictionary = [entry entryDictionary];
        [mutableEntryDictionaries addObject:entryDictionary];
    }
    [[NSUserDefaults standardUserDefaults] setObject:mutableEntryDictionaries forKey:@"Entries"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}



@end
