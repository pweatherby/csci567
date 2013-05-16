//
//  ShopCartManager.m
//  ClassCalendar
//
//  Created by Paul Weatherby on 5/16/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import "ShopCartManager.h"


@interface ShopCartManager()

@property (strong, nonatomic) NSString* deviceID;
@property (strong, nonatomic) NSString* key;

@end

@implementation ShopCartManager


- (id) initWithDevice:(NSString*) dID
              withKey:(NSString*) key
{
    self = [super init];
    if(self)
    {
        self.deviceID = dID;
        self.key = key;
    }
    return self;
}

- (NSArray*) currentCart
{
    NSString* queryStr = @"https://emsdev.csuchico.edu/services/ClassSchedule/ShopCart/JSON/ViewCart.ashx";
    NSURL* url = [[NSURL alloc] initWithString:queryStr];
    queryStr = [[queryStr stringByAppendingString:@"?deviceID="] stringByAppendingString:self.deviceID];
    queryStr = [[queryStr stringByAppendingString:@"&valetKey="] stringByAppendingString:self.key];
    /*
    NSString* loginString = [[dID stringByAppendingString:@":"] stringByAppendingString: key];
    NSString* encodedLoginData = [Base64 encode:[loginString dataUsingEncoding:NSUTF8StringEncoding]];
    NSString* headerValue = [@"Basic " stringByAppendingFormat:@"%@", encodedLoginData];
        
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    [request addValue:@"Authorization" forHTTPHeaderField:headerValue];
    
    [NSURLConnection connectionWithRequest:request delegate:self];
    */
    
    // Permananent, session, whatever.
    NSURLCredential *credential = [NSURLCredential credentialWithUser:[self deviceID]
                                                             password:[self key]
                                                          persistence: NSURLCredentialPersistencePermanent];
    // Make sure that if the server you are accessing presents a realm, you set it here.
    NSURLProtectionSpace *protectionSpace = [[NSURLProtectionSpace alloc] initWithHost:@"emsdev.csuchico.edu"
                                                                                  port:443
                                                                              protocol:@"https"
                                                                                 realm:@"CHICOCLASSCALENDAR"
                                                                  authenticationMethod:NSURLAuthenticationMethodHTTPBasic];
    // Store it
    [[NSURLCredentialStorage sharedCredentialStorage] setDefaultCredential:credential forProtectionSpace:protectionSpace];
    
    
    [[NetworkActivityTracker sharedInstance] showActivityIndicator];
    NSData* rawContents = [[NSData alloc] initWithContentsOfURL:url];
    [[NetworkActivityTracker sharedInstance] hideActivityIndicator];
    if(rawContents)
    {
        NSError* error;
        NSArray* parsedJSON = [NSJSONSerialization JSONObjectWithData:rawContents
                                                              options:0
                                                                error:&error];
        if (error)
        {
            NSLog(@"JSON Parsing Error: %@", error);
            NSString* temp = [[NSString alloc] initWithData:rawContents encoding: NSUTF8StringEncoding];
            NSLog(@"JSON rawContents: %@", temp);
        }
        
        if(parsedJSON)
        {
            NSMutableArray* curItems = [[NSMutableArray alloc] init];
            
            for(int i = 0; i < parsedJSON.count; i++)
            {
                ShopCartItem* item = [[ShopCartItem alloc] initWithJSONAttributes: [parsedJSON objectAtIndex:i]];
                [curItems addObject: item];
            }
            
            return [curItems copy];
        }
    }
    return nil;
}

- (bool) AddToCartWithTerm:(NSString*)t
                SessionGrp:(NSString*)sesGrp
                   subject:(NSString*)subj
                    number:(NSString*)numb
                  courseID:(NSString*)crsID
                 courseOfr:(NSString*)crsOffr
                  clssSect:(NSString*)section
{
    NSString* queryStr = @"https://emsdev.csuchico.edu/services/ClassSchedule/ShopCart/JSON/AddItem.ashx";
    queryStr = [[queryStr stringByAppendingString:@"?term="] stringByAppendingString:t];
    queryStr = [[queryStr stringByAppendingString:@"&session_group="] stringByAppendingString:sesGrp];
    queryStr = [[queryStr stringByAppendingString:@"&subject="] stringByAppendingString:subj];
    queryStr = [[queryStr stringByAppendingString:@"&number="] stringByAppendingString:numb];
    queryStr = [[queryStr stringByAppendingString:@"&course_id="] stringByAppendingString:crsID];
    queryStr = [[queryStr stringByAppendingString:@"&course_offer_nbr="] stringByAppendingString:crsOffr];
    queryStr = [[queryStr stringByAppendingString:@"&section="] stringByAppendingString:section];
    NSURL* url = [[NSURL alloc] initWithString:queryStr];

    // Permananent, session, whatever.
    NSURLCredential *credential = [NSURLCredential credentialWithUser:[self deviceID]
                                                             password:[self key]
                                                          persistence: NSURLCredentialPersistencePermanent];
    // Make sure that if the server you are accessing presents a realm, you set it here.
    NSURLProtectionSpace *protectionSpace = [[NSURLProtectionSpace alloc] initWithHost:@"emsdev.csuchico.edu"
                                                                                  port:443
                                                                              protocol:@"https"
                                                                                 realm:@"CHICOCLASSCALENDAR"
                                                                  authenticationMethod:NSURLAuthenticationMethodHTTPBasic];
    // Store it
    [[NSURLCredentialStorage sharedCredentialStorage] setDefaultCredential:credential forProtectionSpace:protectionSpace];
    
    
    [[NetworkActivityTracker sharedInstance] showActivityIndicator];
    NSData* rawContents = [[NSData alloc] initWithContentsOfURL:url];
    [[NetworkActivityTracker sharedInstance] hideActivityIndicator];
    if(rawContents)
    {
        NSError* error;
        NSArray* parsedJSON = [NSJSONSerialization JSONObjectWithData:rawContents
                                                              options:0
                                                                error:&error];
        if (error)
        {
            return false;
        }
        
        if(parsedJSON)
        {
            for(int i = 0; i < parsedJSON.count; i++)
            {
                NSDictionary* stat = [parsedJSON objectAtIndex:i];
                if(stat && stat.count > 0)
                {
                    NSString* status = [stat objectForKey:@"STATUS"];
                    if(status && [status isEqualToString:@"SUCCESS"])
                    {
                        return true;
                    }
                }
            }
        }
    }
    return false;
}

- (bool) RemoveFromCartTerm:(NSString*)t
                 SessionGrp:(NSString*)sesGrp
                    subject:(NSString*)subj
                     number:(NSString*)numb
                   courseID:(NSString*)crsID
                  courseOfr:(NSString*)crsOffr
                   clssSect:(NSString*)section
{
    NSString* queryStr = @"https://emsdev.csuchico.edu/services/ClassSchedule/ShopCart/JSON/AddItem.ashx";
    queryStr = [[queryStr stringByAppendingString:@"?term="] stringByAppendingString:t];
    queryStr = [[queryStr stringByAppendingString:@"&session_group="] stringByAppendingString:sesGrp];
    queryStr = [[queryStr stringByAppendingString:@"&subject="] stringByAppendingString:subj];
    queryStr = [[queryStr stringByAppendingString:@"&number="] stringByAppendingString:numb];
    queryStr = [[queryStr stringByAppendingString:@"&course_id="] stringByAppendingString:crsID];
    queryStr = [[queryStr stringByAppendingString:@"&course_offer_nbr="] stringByAppendingString:crsOffr];
    queryStr = [[queryStr stringByAppendingString:@"&section="] stringByAppendingString:section];
    NSURL* url = [[NSURL alloc] initWithString:queryStr];
    
    // Permananent, session, whatever.
    NSURLCredential *credential = [NSURLCredential credentialWithUser:[self deviceID]
                                                             password:[self key]
                                                          persistence: NSURLCredentialPersistencePermanent];
    // Make sure that if the server you are accessing presents a realm, you set it here.
    NSURLProtectionSpace *protectionSpace = [[NSURLProtectionSpace alloc] initWithHost:@"emsdev.csuchico.edu"
                                                                                  port:443
                                                                              protocol:@"https"
                                                                                 realm:@"CHICOCLASSCALENDAR"
                                                                  authenticationMethod:NSURLAuthenticationMethodHTTPBasic];
    // Store it
    [[NSURLCredentialStorage sharedCredentialStorage] setDefaultCredential:credential forProtectionSpace:protectionSpace];
    
    
    [[NetworkActivityTracker sharedInstance] showActivityIndicator];
    NSData* rawContents = [[NSData alloc] initWithContentsOfURL:url];
    [[NetworkActivityTracker sharedInstance] hideActivityIndicator];
    if(rawContents)
    {
        NSError* error;
        NSArray* parsedJSON = [NSJSONSerialization JSONObjectWithData:rawContents
                                                              options:0
                                                                error:&error];
        if (error)
        {
            return false;
        }
        
        if(parsedJSON)
        {
            for(int i = 0; i < parsedJSON.count; i++)
            {
                NSDictionary* stat = [parsedJSON objectAtIndex:i];
                if(stat && stat.count > 0)
                {
                    NSString* status = [stat objectForKey:@"STATUS"];
                    if(status && [status isEqualToString:@"SUCCESS"])
                    {
                        return true;
                    }
                }
            }
        }
    }
    return false;}

@end
