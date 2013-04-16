//
//  FavoritesManager.h
//  ChartToppers
//
//  Created by Paul Weatherby on 4/15/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ITunesMediaItem.h"

@interface FavoritesManager : NSObject

- (void)addFavorite:(ITunesMediaItem*)mediaItem;
- (void)removeFavorite:(ITunesMediaItem*)mediaItem;
- (BOOL)isFavorite:(ITunesMediaItem*)mediaItem;

- (NSArray*)allFavorites;

+ (FavoritesManager*)sharedFavoritesManager;

@end
