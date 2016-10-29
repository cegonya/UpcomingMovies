//
//  Genre.h
//  UpcomingMovies
//
//  Created by Santex on 10/28/16.
//  Copyright © 2016 Cegonya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Genre : NSObject

@property (nonatomic, readonly) NSNumber *uid;
@property (nonatomic, readonly) NSString *name;

- (instancetype)initWithData:(NSDictionary *)data;

@end
