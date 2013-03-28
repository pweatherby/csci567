//
//  ITunesMediaItem.m
//  ChartToppers
//
//  Created by Paul Weatherby on 3/28/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import "ITunesMediaItem.h"

@implementation ITunesMediaItem


- (id)initWithJSONAttributes:(NSDictionary *)jsonAttributes
                        rank:(int)rank
{
    self = [super init];
    if (self) {
        title;
        category;
        artist;
        releaseDate;
        price;
        artworkURL;
        artworkImage;
        self.storeURL = jsonAttributes[@"im:artist"][@"label"];
        self.rank = rank;
        
    }
    return self;
}

@end

