//
//  MoviesParser.m
//  UpcomingMovies
//
//  Created by Santex on 10/28/16.
//  Copyright © 2016 Cegonya. All rights reserved.
//

#import "MoviesParser.h"
#import "MoviesData.h"

@implementation MoviesParser

- (void)parseUpcomingMovies:(id)response
                    success:(ParseSuccess)success
                    failure:(ParseFailure)failure
{
    __block id           blockResponse = response;
    __block ParseSuccess blockSuccess  = success;
    __block ParseFailure blockFailure  = failure;
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{
        NSError *error = nil;
        NSMutableArray *movies = [NSMutableArray new];
        if ([blockResponse isKindOfClass:[NSDictionary class]]) {
            NSDictionary *responseDictionary = blockResponse;
            if ([responseDictionary[@"results"] isKindOfClass:[NSArray class]]) {
                NSArray *movieList = responseDictionary[@"results"];
                for (id movieData in movieList) {
                    if ([movieData isKindOfClass:[NSDictionary class]]) {
                        Movie *movie = [[Movie alloc] initWithData:movieData];
                        if (movie) {
                            [movies addObject:movie];
                            [[MoviesData sharedInstance] addMovie:movie];
                        }
                    }
                }
            }
        }

        if (error) {
            if (blockFailure) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    blockFailure(error);
                });
            }
        } else {
            if (blockSuccess) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    blockSuccess([NSArray arrayWithArray:movies]);
                });
            }
        }
    });
}

- (void)parseGenres:(id)response
            success:(ParseSuccess)success
            failure:(ParseFailure)failure
{
    __block id           blockResponse = response;
    __block ParseSuccess blockSuccess  = success;
    __block ParseFailure blockFailure  = failure;
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{
        NSError *error = nil;
        NSMutableArray *genres = [NSMutableArray new];
        if ([blockResponse isKindOfClass:[NSDictionary class]]) {
            NSDictionary *responseDictionary = blockResponse;
            if ([responseDictionary[@"genres"] isKindOfClass:[NSArray class]]) {
                NSArray *genreList = responseDictionary[@"genres"];
                for (id genreData in genreList) {
                    if ([genreData isKindOfClass:[NSDictionary class]]) {
                        Genre *genre = [[Genre alloc] initWithData:genreData];
                        if (genre) {
                            [genres addObject:genre];
                            [[MoviesData sharedInstance] addGenre:genre];
                        }
                    }
                }
            }
        }

        if (error) {
            if (blockFailure) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    blockFailure(error);
                });
            }
        } else {
            if (blockSuccess) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    blockSuccess([NSArray arrayWithArray:genres]);
                });
            }
        }
    });
}

@end
