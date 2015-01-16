//
//  Entry.m
//  DayX
//
//  Created by Derik Flanary on 1/16/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "Entry.h"
#import "DetailViewController.h"

@implementation Entry



-(id)initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if (self){
        self.title = [dictionary objectForKey:titleKey];
        self.text = [dictionary objectForKey:textKey];
        self.date = [dictionary objectForKey:dateKey];
    }
    return self;
}

-(NSDictionary *)entryDictionary{
    NSMutableDictionary *mutableEntryDict = [NSMutableDictionary dictionary];
    if (self.title){
        [mutableEntryDict setValue:self.title forKey:titleKey];
    }
    if (self.text){
        [mutableEntryDict setValue:self.text forKey:textKey];
    }
    if (self.date){
        [mutableEntryDict setValue:self.date forKey:dateKey];
    }
    return mutableEntryDict;
}



@end