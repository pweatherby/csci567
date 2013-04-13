//
//  NetworkActivityTracker.h
//  ChartToppers
//
//  Created by Paul Weatherby on 4/12/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkActivityTracker : NSObject

@property int trackerCount;

+ (NetworkActivityTracker *)sharedInstance;

- (void)showActivityIndicator;
- (void)hideActivityIndicator;

@end
