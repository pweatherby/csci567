//
//  CalendarKeyRequestWebViewController.h
//  ClassCalendar
//
//  Created by Paul Weatherby on 5/15/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetworkActivityTracker.h"
#import "UserProfile.h"

@interface CalendarKeyRequestWebViewController : UIViewController <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webBrowser;

@end
