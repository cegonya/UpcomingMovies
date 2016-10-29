//
//  MoviesData.h
//  UpcomingMovies
//
//  Created by Santex on 10/28/16.
//  Copyright © 2016 Cegonya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Genre.h"
#import "Movie.h"

@interface MoviesData : NSObject

+ (instancetype)sharedInstance;

- (void)addMovie:(Movie *)movie;
- (void)addGenre:(Genre *)genre;

- (Genre *)getGenreWithId:(NSNumber *)uid;
- (Movie *)getMovieWithId:(NSNumber *)uid;
- (UIImage *)getSmallPosterFromMovie:(Movie *)movie completion:(void (^)(BOOL finished))completion;
- (UIImage *)getLargePosterFromMovie:(Movie *)movie completion:(void (^)(BOOL finished))completion;
- (NSString *)getGenresString:(NSArray *)genres;

@end
