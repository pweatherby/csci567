//
//  CalendarKeyRequestWebViewController.m
//  ClassCalendar
//
//  Created by Paul Weatherby on 5/15/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import "CalendarKeyRequestWebViewController.h"

@interface CalendarKeyRequestWebViewController ()

@end

@implementation CalendarKeyRequestWebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	NSURL* url = [NSURL URLWithString:@"https://emsdev.csuchico.edu/ADTS/AppValet/Stand/Authorize.aspx?appID=89b25df7-560f-4e6a-8cbc-097ea9a689c7&deviceID=89b25df7-560f-4e6a-8cbc-097ea9a689c7"];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    
    [self.webBrowser loadRequest:request];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request
                                                 navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL *u = [request URL];
    NSString* absU = u.absoluteString;
    if([absU isEqualToString: @"https://emsdev.csuchico.edu/ADTS/AppValet/Stand/Authorize.aspx"])
    {
        if(navigationType == UIWebViewNavigationTypeFormSubmitted)
        {
            [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *resp, NSData *d, NSError *e) {
                NSString* returned = [[NSString alloc] initWithData:d encoding:NSUTF8StringEncoding];
                NSLog(@"%@", returned);
                
                [self.webBrowser loadData:d MIMEType:nil textEncodingName:nil baseURL:u];
                NSLog(@"%@", [(NSHTTPURLResponse*)resp allHeaderFields]);
            }];
            return NO;
        }
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [[NetworkActivityTracker sharedInstance] showActivityIndicator];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [[NetworkActivityTracker sharedInstance] hideActivityIndicator];
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
    [[NetworkActivityTracker sharedInstance] hideActivityIndicator];
}

@end
