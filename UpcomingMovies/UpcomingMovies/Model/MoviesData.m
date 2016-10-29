//
//  MoviesData.m
//  UpcomingMovies
//
//  Created by Santex on 10/28/16.
//  Copyright © 2016 Cegonya. All rights reserved.
//

#import "MoviesData.h"
#import "MoviesService.h"

@interface MoviesData ()

@property (strong, nonatomic) NSMutableArray      *genres;
@property (strong, nonatomic) NSMutableArray      *movies;
@property (strong, nonatomic) NSMutableDictionary *posters;

@end

@implementation MoviesData

- (instancetype)init
{
    self = [super init];
    if (self) {
        _genres  = [NSMutableArray new];
        _movies  = [NSMutableArray new];
        _posters = [NSMutableDictionary new];
    }
    return self;
}

#pragma mark - Public

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

- (UIImage *)getSmallPosterFromMovie:(Movie *)movie completion:(void (^)(BOOL finished))completion
{
    return [self getImageFromMovie:movie size:@"w185" completion:completion];
}

- (UIImage *)getLargePosterFromMovie:(Movie *)movie completion:(void (^)(BOOL finished))completion
{
    return [self getImageFromMovie:movie size:@"w780" completion:completion];
}

- (NSString *)getGenresString:(NSArray *)genres
{
    NSMutableArray *genresNames  = [NSMutableArray new];
    for (int i = 0; i < genres.count; i++) {
        Genre *genre = [[MoviesData sharedInstance] getGenreWithId:genres[i]];
        if (genre) {
            [genresNames addObject:genre.name];
        }
    }
    return [genresNames componentsJoinedByString:@", "];
}

#pragma mark - Private

- (UIImage *)getImageFromMovie:(Movie *)movie size:(NSString *)size completion:(void (^)(BOOL finished))completion
{
    NSString *imageKey = [NSString stringWithFormat:@"%@_%@", movie.pathPoster, size];
    if (!self.posters[imageKey]) {
        __weak __typeof(self) weakSelf = self;
        [[MoviesService sharedInstance] requestImageFromPath:movie.pathPoster
                                                        size:size
                                                     success:^(NSArray *data){
             dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{
                NSError *error = nil;
                UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:data.firstObject
                                                                              options:0
                                                                                error:&error]];

                if (!error) {
                    __strong __typeof(weakSelf) strongSelf = weakSelf;
                    if (strongSelf) {
                        strongSelf.posters[imageKey] = image;
                        if (completion) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                completion(1);
                            });
                        }
                    }
                }
            });
         }
                                                     failure:^(NSError *error){
         }];
    }
    return self.posters[imageKey];
}

@end
