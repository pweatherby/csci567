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
        _title = jsonAttributes[@"im:name"][@"label"];
        _category = jsonAttributes[@"category"][@"attributes"][@"label"];
        _artist = jsonAttributes[@"im:artist"][@"label"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YYYY-MM-DD'T'HH:mm:ssZZZ"];//2013-03-19T00:00:00-07:00
        NSDate *date = [formatter dateFromString:jsonAttributes[@"im:releaseDate"][@"label"]];
        
        [formatter setDateFormat:@"MMMM DD, YYYY"];
        _releaseDate = [formatter stringFromDate:date];

        _price = jsonAttributes[@"im:price"][@"label"];
        NSArray* images = jsonAttributes[@"im:image"];
        if(images)
        {
            NSDictionary* firstImage = [images objectAtIndex:1];
            if(firstImage)
            {
                NSString* imageSource = [firstImage objectForKey:@"label"];
                if(imageSource)
                {
                    _artworkURL = [[NSURL alloc] initWithString:imageSource];
                }
            }
        }
        //_artworkImage = [UIImage imageWithData:<#(NSData *)#>]
        if(self.artworkURL)
        {
            NSData* artworkData = [NSData dataWithContentsOfURL:self.artworkURL];
            _artworkImage = [UIImage imageWithData:artworkData];
        }
        NSArray* link = jsonAttributes[@"link"];
        if(!link)
        {
            NSDictionary* collection = jsonAttributes[@"collection"];
            if(collection)
            {
                link = [collection objectForKey:@"link"];
            }
        }
        
        if(link)
        {
            if([link isKindOfClass: [NSArray class]])
            {
                NSArray* linkAttr = [link objectAtIndex:1];// objectForKey:@"attributes"];
                if(linkAttr)
                {
                    //_storeURL = [link objectForKey:@"href"];
                }
            }
            else
            {
                
            }
        }
        _rank = rank;
        
    }
    return self;
}

@end

