//
//  ITunesFetcher.m
//  ChartToppers
//
//  Created by Paul Weatherby on 3/28/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import "ITunesFetcher.h"


@implementation ITunesFetcher

NSString* const topFreeAppsURL = @"https://itunes.apple.com/us/rss/topfreeapplications/limit=50/json";
NSString* const topAlbumsURL = @"https://itunes.apple.com/us/rss/topAlbums/limit=50/json";
NSString* const topPaidBooksURL = @"https://itunes.apple.com/us/rss/topPaideBooks/limit=50/json";
NSString* const topMoviesURL = @"https://itunes.apple.com/us/rss/topMovies/limit=50/json";
NSString* const topTVEpisodesURL = @"https://itunes.apple.com/us/rss/topTVEpisodes/limit=50/json";
NSString* const topITunesUCoursesURL = @"https://itunes.apple.com/us/rss/topITunesUCourses/limit=50/json";

+ (NSArray *)topFreeApps
{
    return [self topFeedFor: [[NSURL alloc] initWithString:topFreeAppsURL] ];
}

+ (NSArray*)topAlbums
{
    return [self topFeedFor: [[NSURL alloc] initWithString:topAlbumsURL] ];
}

+ (NSArray*)topPaidBooks
{
    return [self topFeedFor: [[NSURL alloc] initWithString:topPaidBooksURL] ];
}

+ (NSArray*)topMovies
{
    return [self topFeedFor: [[NSURL alloc] initWithString:topMoviesURL] ];
}

+ (NSArray*)topTVEpisodes
{
    return [self topFeedFor: [[NSURL alloc] initWithString:topTVEpisodesURL] ];
}

+ (NSArray*)topITunesUCourses
{
    return [self topFeedFor: [[NSURL alloc] initWithString:topITunesUCoursesURL] ];
}

+ (NSArray*)topFeedFor:(NSURL*) url
{
    NSData* rawContents = [[NSData alloc] initWithContentsOfURL:url];
    if(rawContents)
    {
        NSError* error;
        NSDictionary* parsedJSON = [NSJSONSerialization JSONObjectWithData:rawContents
                                                                   options:0
                                                                     error:&error];
        if (error)
        {
            NSLog(@"JSON Parsing Error: %@", error);
        }
        
        if(parsedJSON)
        {
            NSMutableArray* topItems = [[NSMutableArray alloc] initWithCapacity: 50];
            NSDictionary* feed = [parsedJSON objectForKey:@"feed"];
            if(feed)
            {
                NSArray* entries = [feed objectForKey: @"entry"];
                if(entries)
                {
                    for(int i = 0; i < entries.count; i++)
                    {
                        ITunesMediaItem* item = [[ITunesMediaItem alloc] initWithJSONAttributes: [entries objectAtIndex:i]
                                                                                           rank: i+1 ];
                        [topItems addObject: item];
                    }
                }
            }
            return [topItems copy];
        }
    }
    return nil;
}

@end
