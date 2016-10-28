//
//  ViewController.m
//  UpcomingMovies
//
//  Created by Santex on 10/28/16.
//  Copyright © 2016 Cegonya. All rights reserved.
//

#import "ViewController.h"
#import "MoviesService.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[MoviesService sharedInstance] requestUpcomingMoviesWithSuccess:^(NSArray *data){
         NSLog(@"%@", data);
     }
                                                             failure:^(NSError *error){
     }];

    [[MoviesService sharedInstance] requestGenresWithSuccess:^(NSArray *data){
         NSLog(@"%@", data);
     }
                                                     failure:^(NSError *error){
     }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
