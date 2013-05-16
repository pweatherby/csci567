//
//  ShopCartManager.h
//  ClassCalendar
//
//  Created by Paul Weatherby on 5/16/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShopCartItem.h"

@interface ShopCartManager : NSObject

- (id) initWithDevice:(NSString*) dID
              withKey:(NSString*) key;

- (NSArray*) currentCart;

- (bool) AddToCartWithTerm:(NSString*)t
                SessionGrp:(NSString*)sesGrp
                   subject:(NSString*)subj
                    number:(NSString*)numb
                  courseID:(NSString*)crsID
                 courseOfr:(NSString*)crsOffr
                  clssSect:(NSString*)section;

- (bool) RemoveFromCartTerm:(NSString*)t
                 SessionGrp:(NSString*)sesGrp
                    subject:(NSString*)subj
                     number:(NSString*)numb
                   courseID:(NSString*)crsID
                  courseOfr:(NSString*)crsOffr
                   clssSect:(NSString*)section;

@end
