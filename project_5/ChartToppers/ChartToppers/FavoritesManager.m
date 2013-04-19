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

NSString* const ArchiveFileName = @"ChartToppers.fav";

+ (NSString*) getArchiveDirectoryPath
{
    NSFileManager* fileManager = [[NSFileManager alloc] init];
    NSArray* urls = [fileManager URLsForDirectory:NSApplicationDirectory inDomains:NSUserDomainMask];
    if(urls)
    {
        NSURL* path = [urls objectAtIndex:0];
        if(path)
        {
            return [path absoluteString];
        }
    }
    return nil;
}

- (void) addFavorite:(ITunesMediaItem*)mediaItem
{
    if(![self isFavorite:mediaItem])
    {
        [self.favs addObject:mediaItem];
        if([self saveFavsToFile])
        {
            NSLog(@"SAVED!");
        }
    }
}

- (void) removeFavorite:(ITunesMediaItem*)mediaItem
{
    if([self isFavorite:mediaItem])
    {
        [self.favs removeObject:mediaItem];
        [self saveFavsToFile];
    }
}

- (BOOL) isFavorite:(ITunesMediaItem*)mediaItem
{
    if(self.favs)
    {
        return [self.favs containsObject:mediaItem];
    }
    return false;
}

- (NSArray*) allFavorites
{
    return [[self.favs allObjects] copy];
}

+ (FavoritesManager*) sharedFavoritesManager
{
    static FavoritesManager* sharedInstance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[FavoritesManager alloc] init];
        sharedInstance.favs = [[NSMutableSet alloc] init];
        
        NSString* filepath = [[FavoritesManager getArchiveDirectoryPath] stringByAppendingString:ArchiveFileName];
        if([[NSFileManager defaultManager] isReadableFileAtPath:filepath])
        {
            sharedInstance.favs = [NSKeyedUnarchiver unarchiveObjectWithFile:filepath];
        }
    });
    
    return sharedInstance;
}


- (BOOL) saveFavsToFile
{
    NSString* directoryPath = [FavoritesManager getArchiveDirectoryPath];
    NSString* filePath = [directoryPath stringByAppendingString:ArchiveFileName];
    if(![[NSFileManager defaultManager] isReadableFileAtPath:filePath])
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:directoryPath
                                  withIntermediateDirectories:TRUE
                                                   attributes:nil
                                                        error:nil];
    }

    [[NSFileManager defaultManager] createFileAtPath:filePath
                                            contents:[[NSData alloc] init]
                                          attributes:nil];
    BOOL success = [NSKeyedArchiver archiveRootObject:self.favs toFile:filePath];
    return success;
}

@end
