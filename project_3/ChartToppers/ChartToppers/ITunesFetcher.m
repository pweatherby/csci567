//
//  ITunesFetcher.m
//  ChartToppers
//
//  Created by Paul Weatherby on 3/28/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import "ITunesFetcher.h"


@implementation ITunesFetcher

NSString* const topFreeAppsURL = @"http://itunes.apple.com/us/rss/topfreeapplications/limit=50/json";
NSString* const topAlbumsURL = @"http://itunes.apple.com/us/rss/topAlbums/limit=50/json";
NSString* const topPaidBooksURL = @"http://itunes.apple.com/us/rss/topPaideBooks/limit=50/json";
NSString* const topMoviesURL = @"http://itunes.apple.com/us/rss/topMovies/limit=50/json";
NSString* const topTVEpisodesURL = @"http://itunes.apple.com/us/rss/topTVEpisodes/limit=50/json";
NSString* const topITunesUCoursesURL = @"http://itunes.apple.com/us/rss/topITunesUCourses/limit=50/json";

+ (NSArray *)topFreeApps
{
    return [self topFeedFor: [NSURL fileURLWithPath: topFreeAppsURL] ];
}

+ (NSArray*)topAlbums
{
    return [self topFeedFor: [NSURL fileURLWithPath: topAlbumsURL] ];
}

+ (NSArray*)topPaidBooks
{
    return [self topFeedFor: [NSURL fileURLWithPath: topPaidBooksURL] ];
}

+ (NSArray*)topMovies
{
    return [self topFeedFor: [NSURL fileURLWithPath: topMoviesURL] ];
}

+ (NSArray*)topTVEpisodes
{
    return [self topFeedFor: [NSURL fileURLWithPath: topTVEpisodesURL] ];
}

+ (NSArray*)topITunesUCourses
{
    return [self topFeedFor: [NSURL fileURLWithPath: topITunesUCoursesURL] ];
}

+ (NSArray*)topFeedFor:(NSURL*) url
{
    NSData* rawContents = [[NSData alloc] initWithContentsOfURL:url];
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
        int i = 0;
        for (id Key in parsedJSON)
        {
            i++;
            NSDictionary* curItemProperties = [parsedJSON  objectForKey: Key];
            ITunesMediaItem* item = [[ITunesMediaItem alloc] initWithJSONAttributes: curItemProperties
                                                                               rank: i ];
            [topItems addObject: item];
        }
        return [topItems copy];
    }
    return nil;
}

@end
