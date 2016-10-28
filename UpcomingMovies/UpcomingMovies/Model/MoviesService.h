//
//  MoviesService.h
//  UpcomingMovies
//
//  Created by Santex on 10/28/16.
//  Copyright © 2016 Cegonya. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ParseSuccess)(NSArray *data);
typedef void (^ParseFailure)(NSError *error);

@interface MoviesService : NSObject

+ (instancetype)sharedInstance;

- (void)requestUpcomingMoviesWithSuccess:(ParseSuccess)sucess
                                 failure:(ParseFailure)failure;

- (void)requestUpcomingMoviesAtPage:(NSString *)page
                            success:(ParseSuccess)sucess
                            failure:(ParseFailure)failure;

- (void)requestGenresWithSuccess:(ParseSuccess)sucess
                         failure:(ParseFailure)failure;

@end
