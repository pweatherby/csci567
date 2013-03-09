//
//  PhotoLibrary.m
//  PhotoPicker
//
//  Created by Paul Weatherby on 2/28/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import "PhotoLibrary.h"

@implementation PhotoLibrary

- (NSUInteger)numberOfCategories
{
    NSString* path = [[NSBundle mainBundle] pathForResource:@"photos" ofType:@"plist"];
    if(![path isEqualToString:@""])
    {
        NSDictionary* photoList = [NSDictionary dictionaryWithContentsOfFile:path];
        if(photoList)
        {
            return photoList.count;
        }
    }
    return 0;
}

- (NSString*)nameForCategory:(NSUInteger)category
{
    NSString* path = [[NSBundle mainBundle] pathForResource:@"photos" ofType:@"plist"];
    if(![path isEqualToString:@""])
    {
        NSDictionary* photoList = [NSDictionary dictionaryWithContentsOfFile:path];
        if(photoList)
        {
            NSArray* allCategories = [photoList allKeys];
            if(allCategories)
            {
                NSArray* sortedArray;
                sortedArray = [allCategories sortedArrayUsingFunction:strSort context:NULL];
                return [sortedArray objectAtIndex:category];
            }
        }
    }
    return @"";
}

- (NSUInteger)numberOfPhotosInCategory:(NSUInteger)category
{
    NSString* path = [[NSBundle mainBundle] pathForResource:@"photos" ofType:@"plist"];
    if(![path isEqualToString:@""])
    {
        NSDictionary* photoList = [NSDictionary dictionaryWithContentsOfFile:path];
        if(photoList)
        {
            NSString* categoryTitle = [self nameForCategory: category];
            if(![categoryTitle isEqualToString:@""])
            {
                NSDictionary* categoryPhotos = [photoList objectForKey: categoryTitle];
                if(categoryPhotos)
                {
                    return categoryPhotos.count;
                }
            }
        }
    }
    return 0;
}

- (NSString*)nameForPhotoInCategory:(NSUInteger)category
                          atPosition:(NSUInteger)position
{
    NSString* path = [[NSBundle mainBundle] pathForResource:@"photos" ofType:@"plist"];
    if(![path isEqualToString:@""])
    {
        NSDictionary* photoList = [NSDictionary dictionaryWithContentsOfFile:path];
        if(photoList)
        {
            NSString* categoryTitle = [self nameForCategory: category];
            if(![categoryTitle isEqualToString:@""])
            {
                NSDictionary* categoryPhotos = [photoList objectForKey: categoryTitle];
                if(categoryPhotos)
                {
                    NSArray* allPhotoTitlesInCategory = [categoryPhotos allKeys];
                    if(allPhotoTitlesInCategory && allPhotoTitlesInCategory.count > 0)
                    {
                        NSArray* sortedArray;
                        sortedArray = [allPhotoTitlesInCategory sortedArrayUsingFunction:strSort context:NULL];
                        return [sortedArray objectAtIndex: position];
                    }
                }
            }
        }
    }
    return @"";
}

- (UIImage*)imageForPhotoInCategory:(NSUInteger)category
                          atPosition:(NSUInteger)position
{
    NSString* path = [[NSBundle mainBundle] pathForResource:@"photos" ofType:@"plist"];
    if(![path isEqualToString:@""])
    {
        NSDictionary* photoList = [NSDictionary dictionaryWithContentsOfFile:path];
        if(photoList)
        {
            NSString* categoryTitle = [self nameForCategory: category];
            if(![categoryTitle isEqualToString:@""])
            {
                NSDictionary* categoryPhotos = [photoList objectForKey: categoryTitle];
                if(categoryPhotos)
                {
                    NSString* imgTitle = [self nameForPhotoInCategory:category atPosition:position];
                    if(![imgTitle isEqualToString:@""])
                    {
                        NSString* imgFileName = [categoryPhotos objectForKey: imgTitle];
                        if(![imgFileName isEqualToString:@""])
                        {
                            return [UIImage imageNamed:imgFileName];
                        }
                    }
                }
            }
        }
    }
    return [[UIImage alloc] init];
}

NSInteger strSort(id str1, id str2, void *context)
{
    if(![str1 isKindOfClass:[NSString class]] || ![str2 isKindOfClass:[NSString class]])
    {
        return NSOrderedSame;
    }
    NSString* v1 = str1;
    NSString* v2 = str2;
    return [v1 compare:v2];
}

@end
