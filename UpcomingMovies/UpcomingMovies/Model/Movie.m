//
//  Movie.m
//  UpcomingMovies
//
//  Created by Santex on 10/28/16.
//  Copyright © 2016 Cegonya. All rights reserved.
//

#import "Movie.h"

@interface Movie ()

@property (copy, nonatomic) NSNumber *uid;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *overview;
@property (copy, nonatomic) NSString *releaseDate;
@property (copy, nonatomic) NSArray  *genres;
@property (copy, nonatomic) NSString *pathPoster;
@property (copy, nonatomic) NSString *pathBackDrop;

@end

@implementation Movie

- (instancetype)initWithData:(NSDictionary *)data
{
    self = [super init];

    if (self) {
        if ([data[@"id"] isKindOfClass:[NSNumber class]] && [data[@"title"] isKindOfClass:[NSString class]]) {
            _uid          = data[@"id"];
            _title        = [data[@"title"] copy];
            _overview     = [data[@"overview"] copy];
            _pathPoster   = [data[@"poster_path"] copy];
            _pathBackDrop = [data[@"backdrop_path"] copy];
            _releaseDate  = [data[@"release_date"] copy];
            _genres       = [data[@"genre_ids"] copy];
        } else {
            return nil;
        }
    }

    return self;
}

@end
