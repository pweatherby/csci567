//
//  NetworkActivityTracker.m
//  ClassCalendar
//
//  Created by Paul Weatherby on 4/12/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import "NetworkActivityTracker.h"

@interface NetworkActivityTracker()

@property int trackerCount;

@end

@implementation NetworkActivityTracker

+ (NetworkActivityTracker*) sharedInstance
{
    static NetworkActivityTracker* sharedInstance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[NetworkActivityTracker alloc] init];
    });
    
    return sharedInstance;
}

- (void) showActivityIndicator
{
    self.trackerCount++;
    if (self.trackerCount == 1)
    {
        UIApplication* commonApp = [UIApplication sharedApplication];
        if(commonApp)
        {
            [commonApp setNetworkActivityIndicatorVisible:YES];
        }
    }
}

- (void) hideActivityIndicator
{
    self.trackerCount--;
    if (self.trackerCount == 0)
    {
        UIApplication* commonApp = [UIApplication sharedApplication];
        if(commonApp)
        {
            [commonApp setNetworkActivityIndicatorVisible:NO];
        }
    }
}



@end
