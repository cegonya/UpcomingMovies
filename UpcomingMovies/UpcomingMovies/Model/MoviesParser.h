//
//  MoviesParser.h
//  UpcomingMovies
//
//  Created by Santex on 10/28/16.
//  Copyright © 2016 Cegonya. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ParseSuccess)(NSArray *data);
typedef void (^ParseFailure)(NSError *error);

@interface MoviesParser : NSObject

- (void)parseUpcomingMovies:(id)response
                    success:(ParseSuccess)success
                    failure:(ParseFailure)failure;

- (void)parseGenres:(id)response
            success:(ParseSuccess)success
            failure:(ParseFailure)failure;

@end
