//
//  ViewControllerMovieDetail.m
//  UpcomingMovies
//
//  Created by Santex on 10/28/16.
//  Copyright © 2016 Cegonya. All rights reserved.
//

#import "ViewControllerMovieDetail.h"
#import "MoviesData.h"

@interface ViewControllerMovieDetail ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewDetail;
@property (weak, nonatomic) IBOutlet UILabel      *overview;
@property (weak, nonatomic) IBOutlet UILabel      *genres;
@property (weak, nonatomic) IBOutlet UILabel      *releaseDate;
@property (weak, nonatomic) IBOutlet UIImageView  *poster;

@end

@implementation ViewControllerMovieDetail

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title            = self.movie.title;
    self.overview.text    = self.movie.overview;
    self.releaseDate.text = [self.movie.releaseDate ISO8601String];

    __weak __typeof(self) weakSelf = self;
    self.poster.image = [[MoviesData sharedInstance] getLargePosterFromMovie:self.movie
                                                                  completion:^(BOOL finished){
                             if (finished) {
                                 __strong __typeof(weakSelf) strongSelf = weakSelf;
                                 if (strongSelf) {
                                     strongSelf.poster.image = [[MoviesData sharedInstance] getLargePosterFromMovie:self.movie completion:nil];
                                 }
                             }
                         }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
   #pragma mark - Navigation

   // In a storyboard-based application, you will often want to do a little preparation before navigation
   - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
   }
 */

@end
