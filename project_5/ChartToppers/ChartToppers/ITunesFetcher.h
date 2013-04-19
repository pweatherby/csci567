//
//  ITunesFetcher.h
//  ChartToppers
//
//  Created by Paul Weatherby on 3/28/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//
// ios_student
// !ios@csuchico#

#import <Foundation/Foundation.h>
#import "ITunesMediaItem.h"
#import "NetworkActivityTracker.h"

@interface ITunesFetcher : NSObject

+ (NSArray*) topFreeApps;
+ (NSArray*) topAlbums;
+ (NSArray*) topPaidBooks;
+ (NSArray*) topMovies;
+ (NSArray*) topTVEpisodes;
+ (NSArray*) topITunesUCourses;

@end
