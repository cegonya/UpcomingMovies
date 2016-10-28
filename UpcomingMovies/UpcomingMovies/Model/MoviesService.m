//
//  MoviesService.m
//  UpcomingMovies
//
//  Created by Santex on 10/28/16.
//  Copyright © 2016 Cegonya. All rights reserved.
//

#import "MoviesService.h"
#import "MoviesParser.h"

static NSString *const BaseURL           = @"https://api.themoviedb.org/3/";
static NSString *const APIKey            = @"1f54bd990f1cdfb230adb312546d765d";
static NSString *const URLUpcomingMovies = @"movie/upcoming";
static NSString *const URLGenres         = @"genre/movie/list";

@implementation MoviesService

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

- (void)requestUpcomingMoviesWithSuccess:(ParseSuccess)sucess
                                 failure:(ParseFailure)failure
{
    [self requestUpcomingMoviesAtPage:@"1"
                              success:sucess
                              failure:failure];
}

- (void)requestUpcomingMoviesAtPage:(NSString *)page
                            success:(ParseSuccess)sucess
                            failure:(ParseFailure)failure
{
    NSString            *stringURL = [BaseURL stringByAppendingFormat:@"%@?page=%@&language=en-US&api_key=%@", URLUpcomingMovies, page, APIKey];
    NSMutableURLRequest *request   = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:stringURL]
                                                             cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                         timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];

    NSURLSession         *session  = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                          if (error) {
                                              if (failure) {
                                                  failure(error);
                                              }
                                          } else {
                                              NSError *errorJson = nil;
                                              id dataJson = [NSJSONSerialization JSONObjectWithData:data
                                                                                            options:NSJSONReadingAllowFragments
                                                                                              error:&errorJson];
                                              if (errorJson) {
                                                  if (failure) {
                                                      failure(errorJson);
                                                  }
                                              } else {
                                                  //NSLog(@"data : %@", dataJson);
                                                  MoviesParser *parser = [[MoviesParser alloc] init];
                                                  [parser parseUpcomingMovies:dataJson
                                                                      success:sucess
                                                                      failure:failure];

                                                  if ([page isEqualToString:@"1"] && [dataJson isKindOfClass:[NSDictionary class]] && dataJson[@"total_pages"]) {
                                                      NSNumber *totalPages = dataJson[@"total_pages"];
                                                      NSNumber *currentPage = @([page integerValue]);
                                                      for (NSInteger i = currentPage.integerValue+1; i <= totalPages.integerValue; i++) {
                                                          [self requestUpcomingMoviesAtPage:[NSString stringWithFormat:@"%ld", i]
                                                                                    success:sucess
                                                                                    failure:failure];
                                                      }
                                                  }
                                              }
                                          }
                                      }];
    [dataTask resume];
}

- (void)requestGenresWithSuccess:(ParseSuccess)sucess
                         failure:(ParseFailure)failure
{
    NSString            *stringURL = [BaseURL stringByAppendingFormat:@"%@?language=en-US&api_key=%@", URLGenres, APIKey];
    NSMutableURLRequest *request   = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:stringURL]
                                                             cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                         timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];

    NSURLSession *session = [NSURLSession sharedSession];

    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                          if (error) {
                                              if (failure) {
                                                  failure(error);
                                              }
                                          } else {
                                              NSError *errorJson = nil;
                                              id dataJson = [NSJSONSerialization JSONObjectWithData:data
                                                                                            options:NSJSONReadingAllowFragments
                                                                                              error:&errorJson];
                                              if (errorJson) {
                                                  if (failure) {
                                                      failure(errorJson);
                                                  }
                                              } else {
                                                  //NSLog(@"data : %@", dataJson);
                                                  MoviesParser *parser = [[MoviesParser alloc] init];
                                                  [parser parseGenres:dataJson
                                                              success:sucess
                                                              failure:failure];
                                              }
                                          }
                                      }];
    [dataTask resume];
}

@end
