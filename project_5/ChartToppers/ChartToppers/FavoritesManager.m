//
//  FavoritesManager.m
//  ChartToppers
//
//  Created by Paul Weatherby on 4/15/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import "FavoritesManager.h"


@implementation FavoritesManager



- (void)addFavorite:(ITunesMediaItem*)mediaItem
{

}

- (void)removeFavorite:(ITunesMediaItem*)mediaItem
{
    
}

- (BOOL)isFavorite:(ITunesMediaItem*)mediaItem
{
    NSArray* favs = [self allFavorites];
    if(favs)
    {
        if([favs indexOfObject:mediaItem] > 0)
        {
            return true;
        }
    }
    return false;
}

- (NSArray*)allFavorites
{
    return nil;
}

+ (FavoritesManager*)sharedFavoritesManager
{
    static FavoritesManager* sharedInstance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[FavoritesManager alloc] init];
    });
    
    return sharedInstance;
}

@end
