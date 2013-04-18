//
//  FavoritesManager.m
//  ChartToppers
//
//  Created by Paul Weatherby on 4/15/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import "FavoritesManager.h"

@interface FavoritesManager()

@property (strong, nonatomic) NSMutableSet* favs;

@end

@implementation FavoritesManager

@synthesize favs = _favs;


- (NSString*) getArchiveFilePath
{
    return nil;
}

- (BOOL) saveFavsToFile:(NSString*) path
{
    if(![[NSFileManager defaultManager] isReadableFileAtPath:path])
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:path
                                  withIntermediateDirectories:TRUE
                                                   attributes:nil
                                                        error:nil];
    }
    [[NSFileManager defaultManager] createFileAtPath:path
                                            contents:nil
                                          attributes:nil];
    return [NSKeyedArchiver archiveRootObject:_favs toFile:path];
}

- (NSMutableSet*) favs
{
    if(!_favs)
    {
        NSString* path = [self getArchiveFilePath];
        if([[NSFileManager defaultManager] isReadableFileAtPath:path])
        {
            _favs = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        }
    }
    return _favs;
}

- (void)addFavorite:(ITunesMediaItem*)mediaItem
{
    if(![self isFavorite:mediaItem])
    {
        [self.favs addObject:mediaItem];
        [self saveFavsToFile:[self getArchiveFilePath]];
    }
}

- (void)removeFavorite:(ITunesMediaItem*)mediaItem
{
    if([self isFavorite:mediaItem])
    {
        [self.favs removeObject:mediaItem];
        [self saveFavsToFile:[self getArchiveFilePath]];
    }
}

- (BOOL)isFavorite:(ITunesMediaItem*)mediaItem
{
    if(self.favs)
    {
        return [self.favs containsObject:mediaItem];
    }
    return false;
}

- (NSArray*)allFavorites
{
    return [self.favs copy];
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
