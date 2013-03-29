//
//  ITunesMediaItem.m
//  ChartToppers
//
//  Created by Paul Weatherby on 3/28/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import "ITunesMediaItem.h"

@implementation ITunesMediaItem


- (id)initWithJSONAttributes:(NSDictionary*)jsonAttributes
                        rank:(int)rank
{
    self = [super init];
    if (self) {
        self.title = jsonAttributes[@"title"][@"label"];
        self.category jsonAttributes[@"category"][@"attributes"][@"label"];
        self.artist = jsonAttributes[@"im:artist"][@"label"];
        self.releaseDate = jsonAttributes[@"im:releaseDate"][@"label"];
        self.price = jsonAttributes[@"im:price"][@"label"];
        self.artworkURL = [[NSURL alloc] initWithString:jsonAttributes[@"im:price"][0][@"label"]];
        NSData* artworkData = [NSData dataWithContentsOfURL:self.artworkURL];
        self.artworkImage = [UIImage imageWithData:artworkData];
        self.storeURL = [[NSURL alloc] initWithString:jsonAttributes[@"im:artist"][@"label"]];
        self.rank = rank;
        
    }
    return self;
}

@end

