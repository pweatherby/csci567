//
//  paulw_PhotoLibrary.m
//  PhotoPicker
//
//  Created by Paul Weatherby on 2/28/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import "paulw_PhotoLibrary.h"

@implementation paulw_PhotoLibrary

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
    NSString *categoryTitle = [self nameForCategory: category];
    NSDictionary *categoryPhotos = [photoList objectForKey: categoryTitle];
    NSArray *allPhotoTitlesInCategory = [categoryPhotos allKeys];
    return [allPhotoTitlesInCategory objectAtIndex: position];
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
