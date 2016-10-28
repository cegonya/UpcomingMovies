//
//  Genre.m
//  UpcomingMovies
//
//  Created by Santex on 10/28/16.
//  Copyright © 2016 Cegonya. All rights reserved.
//

#import "Genre.h"

@interface Genre ()

@property (copy, nonatomic) NSNumber *uid;
@property (copy, nonatomic) NSString *name;

@end

@implementation Genre

- (instancetype)initWithData:(NSDictionary *)data
{
	self = [super init];

	if (self) {
		if ([data[@"id"] isKindOfClass:[NSNumber class]] && [data[@"name"] isKindOfClass:[NSString class]]) {
			_uid = data[@"id"];
			_name = [data[@"name"] copy];
		} else {
			return nil;
		}
	}

	return self;
}

@end
