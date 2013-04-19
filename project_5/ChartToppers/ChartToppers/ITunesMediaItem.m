//
//  ITunesMediaItem.m
//  ChartToppers
//
//  Created by Paul Weatherby on 3/28/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import "ITunesMediaItem.h"

@implementation ITunesMediaItem

- (id) initWithCoder:(NSCoder*)aDecoder
{
    self = [super init];
    if(self)
    {
        _title =       [aDecoder decodeObjectForKey:@"_title"];
        _category =    [aDecoder decodeObjectForKey:@"_category"];
        _artist =      [aDecoder decodeObjectForKey:@"_artist"];
        _releaseDate = [aDecoder decodeObjectForKey:@"_releaseDate"];
        _price =       [aDecoder decodeObjectForKey:@"_price"];
        _artworkURL =  [aDecoder decodeObjectForKey:@"_artworkURL"];
        _storeURL =    [aDecoder decodeObjectForKey:@"_storeURL"];
        _rank =        [aDecoder decodeIntForKey:   @"_rank"];
        _summary =     [aDecoder decodeObjectForKey:@"_summary"];
    }
    return self;
}

- (id) initWithJSONAttributes:(NSDictionary*)jsonAttributes
                         rank:(int)rank
{
    self = [super init];
    if (self)
    {
        _title = jsonAttributes[@"im:name"][@"label"];
        _category = jsonAttributes[@"category"][@"attributes"][@"label"];
        _artist = jsonAttributes[@"im:artist"][@"label"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssz"];//2013-03-19T00:00:00-07:00
        NSString* unformattedDate = jsonAttributes[@"im:releaseDate"][@"label"];
        NSDate *date = [formatter dateFromString:unformattedDate];
        
        [formatter setDateFormat:@"MMMM dd, yyyy"];
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
                NSDictionary* linkAttrholder = [link objectAtIndex:1];
                if(linkAttrholder)
                {
                    NSDictionary* linkAttr = [linkAttrholder objectForKey:@"attributes"];
                    if(linkAttr)
                    {
                        _storeURL = [linkAttr objectForKey:@"href"];
                    }
                }
            }
        }
        if(!link)
        {
            NSLog(@"COULD NOT FIND LINK FOR ITEM!");
        }
        
        _summary = jsonAttributes[@"summary"][@"label"];
        
        _rank = rank;
        
    }
    return self;
}
@synthesize artworkImage = _artworkImage;

- (UIImage*) artworkImage
{
    if(!_artworkImage)
    {
        if(self.artworkURL)
        {
            [[NetworkActivityTracker sharedInstance] showActivityIndicator];
            [NSThread sleepForTimeInterval:drand48() * 3.0];
            NSData* artworkData = [NSData dataWithContentsOfURL:self.artworkURL];
            [[NetworkActivityTracker sharedInstance] hideActivityIndicator];
            _artworkImage = [UIImage imageWithData:artworkData];
        }
    }
    return _artworkImage;
}

- (BOOL) isEqual: (ITunesMediaItem*) other
{
    if(self && other)
    {
        if(self.storeURL && other.storeURL)
        {
            return [self.storeURL isEqual: other.storeURL];
        }
    }
    return false;
}

- (NSUInteger) hash
{
    NSUInteger hash = 0;
    if(self && self.storeURL)
    {
        hash += [self.storeURL hash];
    }
    return hash;
}


- (void) encodeWithCoder:(NSCoder*)encoder
{
    [encoder encodeObject:_title       forKey:@"_title"];
    [encoder encodeObject:_category    forKey:@"_category"];
    [encoder encodeObject:_releaseDate forKey:@"_releaseDate"];
    [encoder encodeObject:_artworkURL  forKey:@"_artworkURL"];
    [encoder encodeObject:_storeURL    forKey:@"_storeURL"];
    [encoder encodeInt:_rank           forKey:@"_rank"];
    [encoder encodeObject:_summary     forKey:@"_summary"];
}


@end

