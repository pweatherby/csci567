//
//  CalendarSubject.m
//  ClassCalendar
//
//  Created by Paul Weatherby on 5/13/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import "CalendarSubject.h"

@implementation CalendarSubject

+ (NSArray*) currentSubjects:(NSString*) termCode
                SessionGroup:(NSString*) sesGrp
{
    /// DEBUG; RETURNING TEST VALUES
    /// return [CalendarSubject testValues];
    NSString* queryStr = @"https://emsdev.csuchico.edu/services/ClassSchedule/CalendarInfo/JSON/SUBJECTS_REQUEST.ashx?term=";
    queryStr = [queryStr stringByAppendingString:termCode];
    queryStr = [queryStr stringByAppendingString:@"&session_group="];
    queryStr = [queryStr stringByAppendingString:sesGrp];
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
                CalendarSubject* item = [[CalendarSubject alloc] initWithJSONAttributes: [parsedJSON objectAtIndex:i]];
                [curItems addObject: item];
            }
            
            return [curItems copy];
        }
    }
    return nil;
}

+ (NSArray*) testValues
{
    
    NSMutableArray* curItems = [[NSMutableArray alloc] init];
    CalendarSubject* csci = [[CalendarSubject alloc] initWithTerm:@"2138"
                                                           SesGrp:@"10"
                                                             Subj:@"CSCI"
                                                            SDesc:@"Csci"
                                                            LDesc:@"Comp. Sci."
                                                            FDesc:@"Computer Science"];
    [curItems addObject: csci];
    CalendarSubject* edma = [[CalendarSubject alloc] initWithTerm:@"2138"
                                                           SesGrp:@"10"
                                                             Subj:@"EDMA"
                                                            SDesc:@"EDMA"
                                                            LDesc:@"Education- Ma Studies"
                                                            FDesc:@"Education- Masters Studies"];
    [curItems addObject: edma];
    return [curItems copy];
}


- (id) initWithJSONAttributes:(NSDictionary*)jsonAttributes
{
    self = [super init];
    if (self)
    {
        _termCode = [jsonAttributes[@"TERM"] stringByDecodingXMLEntities];
        _sessionGroupCode = [jsonAttributes[@"SESSION_GROUP"] stringByDecodingXMLEntities];
        _subjectCode = [jsonAttributes[@"SUBJECT_CODE"] stringByDecodingXMLEntities];
        _shortDesc = [jsonAttributes[@"SUBJECT_SDESC"] stringByDecodingXMLEntities];
        _longDesc = [jsonAttributes[@"SUBJECT_LDESC"] stringByDecodingXMLEntities];
        _formalDesc = [jsonAttributes[@"SUBJECT_FDESC"] stringByDecodingXMLEntities];
    }
    return self;
}


- (id) initWithTerm:(NSString*)t
             SesGrp:(NSString*)g
               Subj:(NSString*)c
              SDesc:(NSString*)s
              LDesc:(NSString*)l
              FDesc:(NSString*)f
{
    self = [super init];
    if (self)
    {
        _termCode = t;
        _sessionGroupCode = g;
        _subjectCode = c;
        _shortDesc = s;
        _longDesc = l;
        _formalDesc = f;
    }
    return self;
}


@end
