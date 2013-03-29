//
//  ITunesFetcher.m
//  ChartToppers
//
//  Created by Paul Weatherby on 3/28/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import "ITunesFetcher.h"

@interface ITunesFetcher

NSString* const topFreeAppsURL = @"http://itunes.apple.com/us/rss/topfreeapplications/limit=50/json";
NSString* const topAlbumsURL = @"http://itunes.apple.com/us/rss/topAlbums/limit=50/json";
NSString* const topPaidBooksURL = @"http://itunes.apple.com/us/rss/topPaideBooks/limit=50/json";
NSString* const topMoviesURL = @"http://itunes.apple.com/us/rss/topMovies/limit=50/json";
NSString* const topTVEpisodesURL = @"http://itunes.apple.com/us/rss/topTVEpisodes/limit=50/json";
NSString* const topITunesUCoursesURL = @"http://itunes.apple.com/us/rss/topITunesUCourses/limit=50/json";

+ (NSArray*)topFeedFor:(NSURL) url;

@end

@implementation ITunesFetcher

+ (NSArray *)topFreeApps
{
   return [self topFeedFor: topFreeAppsURL];
}

+ (NSArray*)topAlbums
{
   return [self topFeedFrom: topAlbumsURL];
}

+ (NSArray*)topPaidBooks
{
   return [self topFeedFrom: topPaidBooksURL];
}

+ (NSArray*)topMovies
{
   return [self topFeedFrom: topMoviesURL];
}

+ (NSArray*)topTVEpisodes
{
   return [self topFeedFrom: topTVEpisodesURL];
}

+ (NSArray*)topITunesUCourses
{
   return [self topFeedFrom: topITunesUCoursesURL];
}

+ (NSArray*)topFeedFor:(NSURL) url
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
      NSMutableArray* topItems = [[MSMutableArray alloc] initWithCapacity: 50];
      for (int i = 1; i <= [parsedJSON Count]; i++)
      {
         NSDictionary* curItemProperties = [parsedJSON objectForIndex: i];
         ITunesMediaItem* item = [[ITunesMediaItem alloc] initWithJSONAttributes: curItemProperties
                                                                                : i ];
         [topItems addObject: item];
      }
      return [topItems copy];
   }
   return nil;
}

@end
