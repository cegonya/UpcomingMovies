//
//  NSDate+Additions.h
//  UpcomingMovies
//
//  Created by Santex on 10/28/16.
//  Copyright © 2016 Cegonya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Additions)

+ (NSDate *)dateFromISO8601String:(NSString *)string;
- (NSString *)ISO8601String;

@end
