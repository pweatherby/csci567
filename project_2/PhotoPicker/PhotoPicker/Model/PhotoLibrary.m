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
    NSString *path = [[NSBundle mainBundle] pathForResource:@"photos" ofType:@"plist"];
    NSDictionary *photoList = [NSDictionary dictionaryWithContentsOfFile:path];
    return photoList.count;
}

- (NSString *)nameForCategory:(NSUInteger)category
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"photos" ofType:@"plist"];
    NSDictionary *photoList = [NSDictionary dictionaryWithContentsOfFile:path];
    NSArray* allCategories = [photoList allKeys];
    return [allCategories objectAtIndex:category];
}

- (NSUInteger)numberOfPhotosInCategory:(NSUInteger)category
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"photos" ofType:@"plist"];
    NSDictionary *photoList = [NSDictionary dictionaryWithContentsOfFile:path];
    NSString *categoryTitle = [self nameForCategory: category];
    NSDictionary *categoryPhotos = [photoList objectForKey: categoryTitle];
    return categoryPhotos.count;
}

- (NSString *)nameForPhotoInCategory:(NSUInteger)category
                          atPosition:(NSUInteger)position
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"photos" ofType:@"plist"];
    NSDictionary *photoList = [NSDictionary dictionaryWithContentsOfFile:path];
    if(photoList)
    {
        NSString *categoryTitle = [self nameForCategory: category];
        if(categoryTitle)
        {
            NSDictionary *categoryPhotos = [photoList objectForKey: categoryTitle];
            if(categoryPhotos)
            {
                NSArray *allPhotoTitlesInCategory = [categoryPhotos allKeys];
                if(allPhotoTitlesInCategory && allPhotoTitlesInCategory.count > 0)
                {
                    return [allPhotoTitlesInCategory objectAtIndex: position];
                }
            }
        }
    }
    return @"";
}

- (UIImage *)imageForPhotoInCategory:(NSUInteger)category
                          atPosition:(NSUInteger)position
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"photos" ofType:@"plist"];
    NSDictionary *photoList = [NSDictionary dictionaryWithContentsOfFile:path];
    NSString *categoryTitle = [self nameForCategory: category];
    NSDictionary *categoryPhotos = [photoList objectForKey: categoryTitle];
    NSString *imgTitle = [self nameForPhotoInCategory:category atPosition:position];
    NSString *imgFileName = [categoryPhotos objectForKey: imgTitle];
    
    return [UIImage imageNamed:imgFileName];
}

@end
