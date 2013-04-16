//
//  ImageUtils.h
//  ChartToppers
//
//  Created by Paul Weatherby on 4/9/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageUtils : NSObject

+ (UIImage *)cropImage:(UIImage *)imageToCrop toRect:(CGRect)rect;

+ (UIImage*)resizeImage:(UIImage*)image withWidth:(int)width withHeight:(int)height;

@end
