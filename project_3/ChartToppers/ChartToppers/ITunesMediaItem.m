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
        _title = jsonAttributes[@"title"][@"label"];
        //_category = jsonAttributes[@"category"][@"attributes"][@"label"];
        _artist = jsonAttributes[@"im:artist"][@"label"];
        //_releaseDate = jsonAttributes[@"im:releaseDate"][@"label"];
        //_price = jsonAttributes[@"im:price"][@"label"];
        //_artworkURL = [[NSURL alloc] initWithString:jsonAttributes[@"im:price"][0][@"label"]];
        //NSData* artworkData = [NSData dataWithContentsOfURL:self.artworkURL];
        //_artworkImage = [UIImage imageWithData:artworkData];
        //_storeURL = [[NSURL alloc] initWithString:jsonAttributes[@"im:artist"][@"label"]];
        _rank = rank;
        
    }
    return self;
}

@end

