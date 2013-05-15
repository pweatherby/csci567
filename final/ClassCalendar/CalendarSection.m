//
//  CalendarSection.m
//  ClassCalendar
//
//  Created by iOS Student on 5/14/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import "CalendarSection.h"

@implementation CalendarSection

+ (NSArray*) currentSections:(NSString*) termCode
                SessionGroup:(NSString*) sesGrp
                       CrsID:(NSString*) crsID
                      CrsOfr:(NSString*) crsOffer

{
    NSString* queryStr = @"https://emsdev.csuchico.edu/services/ClassSchedule/CalendarInfo/JSON/SECTIONS_REQUEST.ashx?term=";
    queryStr = [queryStr stringByAppendingString:termCode];
    queryStr = [queryStr stringByAppendingString:@"&session_group="];
    queryStr = [queryStr stringByAppendingString:sesGrp];
    queryStr = [queryStr stringByAppendingString:@"&course_id="];
    queryStr = [queryStr stringByAppendingString:crsID];
    queryStr = [queryStr stringByAppendingString:@"&course_offer_nbr="];
    queryStr = [queryStr stringByAppendingString:crsOffer];
    NSURL* url = [[NSURL alloc] initWithString:queryStr];
    
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
        }
        
        if(parsedJSON)
        {
            NSMutableArray* curItems = [[NSMutableArray alloc] init];
            
            for(int i = 0; i < parsedJSON.count; i++)
            {
                CalendarSection* item = [[CalendarSection alloc] initWithJSONAttributes: [parsedJSON objectAtIndex:i]];
                [curItems addObject: item];
            }
            
            return [curItems copy];
        }
    }
    return nil;
}


- (id) initWithJSONAttributes:(NSDictionary*)jsonAttributes
{
    self = [super init];
    if (self)
    {
        _termCode = [jsonAttributes[@"TERM"] stringByDecodingXMLEntities];
        _sessionGroupCode = [jsonAttributes[@"SESSION_GROUP"] stringByDecodingXMLEntities];
        _courseID = [jsonAttributes[@"COURSE_ID"] stringByDecodingXMLEntities];
        _courseOfferNbr = [jsonAttributes[@"COURSE_OFFER_NBR"] stringByDecodingXMLEntities];
       
        
        _classSection = [jsonAttributes[@"CLASS_SECTION"] stringByDecodingXMLEntities];
        _classStatus = [jsonAttributes[@"CLASS_STATUS"] stringByDecodingXMLEntities];
        _classStatusLDesc = [jsonAttributes[@"CLASS_STATUS_LDESC"] stringByDecodingXMLEntities];
        
        _classType = [jsonAttributes[@"CLASS_TYPE"] stringByDecodingXMLEntities];
        _classTypeLDesc = [jsonAttributes[@"CLASS_TYPE_LDESC"] stringByDecodingXMLEntities];
        _registrationNbr = [jsonAttributes[@"REGISTRATION_NBR"] stringByDecodingXMLEntities];
        
        _component = [jsonAttributes[@"CLASS_COMPONENT"] stringByDecodingXMLEntities];
        _componentLDesc = [jsonAttributes[@"CLASS_COMPONENT_LDESC"] stringByDecodingXMLEntities];
        _associatedClass = [jsonAttributes[@"ASSOCIATED_CLASS"] stringByDecodingXMLEntities];
        
        _enrlStatus = [jsonAttributes[@"ENRL_STATUS"] stringByDecodingXMLEntities];
        _enrlStatusLDesc = [jsonAttributes[@"ENRL_STATUS_LDESC"] stringByDecodingXMLEntities];
        _enrlTotal = [jsonAttributes[@"ENRL_TOTAL"] stringByDecodingXMLEntities];
        _enrlCapacity = [jsonAttributes[@"ENRL_CAPACITY"] stringByDecodingXMLEntities];
        _enrlAutoWaitlist = [jsonAttributes[@"AUTO_ENRL_WAITLIST"] stringByDecodingXMLEntities];
        
        _waitDaemon = [jsonAttributes[@"WAITLIST_DAEMON"] stringByDecodingXMLEntities];
        _waitTotal = [jsonAttributes[@"WAITLIST_TOTAL"] stringByDecodingXMLEntities];
        _waitCapacity = [jsonAttributes[@"WAITLIST_CAPACTIY"] stringByDecodingXMLEntities];
        
        NSMutableArray* curItems = [[NSMutableArray alloc] init];
        NSArray* pats = jsonAttributes[@"MEETING_PATTERNS"];
        if(pats)
        {
            for(int i = 0; i < pats.count; i++)
            {
                CalendarMeetingPattern* item = [[CalendarMeetingPattern alloc] initWithJSONAttributes: [pats objectAtIndex:i]];
                [curItems addObject: item];
            }
            
            _meetingPatterns = [curItems copy];
        }

        
    }
    return self;
}

@end
