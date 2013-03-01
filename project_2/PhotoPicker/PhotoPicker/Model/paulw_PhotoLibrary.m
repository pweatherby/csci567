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
    return 0;
}

- (NSString *)nameForCategory:(NSUInteger)category
{
    return @"none";
}

- (NSUInteger)numberOfPhotosInCategory:(NSUInteger)category
{
    return 0;
}

- (NSString *)nameForPhotoInCategory:(NSUInteger)category
                          atPosition:(NSUInteger)position
{
    return @"nane";
}

- (UIImage *)imageForPhotoInCategory:(NSUInteger)category
                          atPosition:(NSUInteger)position
{
    return [[UIImage alloc] init];
    
}

@end
