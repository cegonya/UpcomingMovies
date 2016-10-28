//
//  MoviesData.m
//  UpcomingMovies
//
//  Created by Santex on 10/28/16.
//  Copyright © 2016 Cegonya. All rights reserved.
//

#import "MoviesData.h"

@interface MoviesData ()

@property (strong, nonatomic) NSMutableArray *genres;
@property (strong, nonatomic) NSMutableArray *movies;

@end

@implementation MoviesData

+ (instancetype)sharedInstance
{
    static id              currentSession = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,
                  ^{
        currentSession = [[self alloc] init];
    });
    return currentSession;
}

- (void)addMovie:(Movie *)movie
{
    if (!movie || ![movie isKindOfClass:[Movie class]]) {
        return;
    }

    [self.movies addObject:movie];
}

- (void)addGenre:(Genre *)genre
{
    if (!genre || ![genre isKindOfClass:[Genre class]]) {
        return;
    }

    [self.genres addObject:genre];
}

- (Genre *)getGenreWithId:(NSNumber *)uid
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"uid == %@", uid];
    return [self.genres filteredArrayUsingPredicate:predicate].lastObject;
}

- (Movie *)getMovieWithId:(NSNumber *)uid
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"uid == %@", uid];
    return [self.movies filteredArrayUsingPredicate:predicate].lastObject;
}

@end
