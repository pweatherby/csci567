//
//  ITunesMediaItem.h
//  ChartToppers
//
//  Created by Paul Weatherby on 3/28/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkActivityTracker.h"

@interface ITunesMediaItem : NSObject

@property (nonatomic, readonly) NSString* title;
@property (nonatomic, readonly) NSString* category;
@property (nonatomic, readonly) NSString* artist;
@property (nonatomic, readonly) NSString* releaseDate;
@property (nonatomic, readonly) NSString* price;
@property (nonatomic, readonly) NSURL* artworkURL;
@property (nonatomic, readonly) UIImage* artworkImage;
@property (nonatomic, readonly) NSURL* storeURL;
@property (nonatomic, readonly) int rank;
@property (nonatomic, readonly) NSString* summary;

- (id)initWithJSONAttributes:(NSDictionary*)jsonAttributes
                        rank:(int)rank;

@end
