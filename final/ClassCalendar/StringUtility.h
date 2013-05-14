//
//  StringUtility.h
//  ClassCalendar
//
//  Created by Paul Weatherby on 5/13/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//  Adapted From: http://stackoverflow.com/questions/1105169/html-character-decoding-in-objective-c-cocoa-touch 

#import <Foundation/Foundation.h>

@interface NSString (NSStringCategory)
- (NSString *) stringByDecodingXMLEntities;
@end
