//
//  Movie.h
//  UpcomingMovies
//
//  Created by Santex on 10/28/16.
//  Copyright © 2016 Cegonya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject

@property (nonatomic, readonly) NSNumber *uid;
@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) NSString *overview;
@property (nonatomic, readonly) NSString *releaseDate;
@property (nonatomic, readonly) NSArray  *genres;
@property (nonatomic, readonly) NSString *pathPoster;
@property (nonatomic, readonly) NSString *pathBackDrop;

- (instancetype)initWithData:(NSDictionary *)data;

@end