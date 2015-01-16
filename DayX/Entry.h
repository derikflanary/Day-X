//
//  Entry.h
//  DayX
//
//  Created by Derik Flanary on 1/16/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Entry : NSObject

@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSString *text;
@property (nonatomic, strong)NSDate *date;

-(id)initWithDictionary:(NSDictionary *)dictionary;
-(NSDictionary *)entryDictionary;


@end
