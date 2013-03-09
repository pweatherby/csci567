//
//  PhotoLibrary.h
//  PhotoPicker
//
//  Created by Paul Weatherby on 2/28/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoLibrary : NSObject


- (NSUInteger)numberOfCategories;
- (NSString *)nameForCategory:(NSUInteger)category;
- (NSUInteger)numberOfPhotosInCategory:(NSUInteger)category;
- (NSString *)nameForPhotoInCategory:(NSUInteger)category
                          atPosition:(NSUInteger)position;
- (UIImage *)imageForPhotoInCategory:(NSUInteger)category
                          atPosition:(NSUInteger)position;
@end