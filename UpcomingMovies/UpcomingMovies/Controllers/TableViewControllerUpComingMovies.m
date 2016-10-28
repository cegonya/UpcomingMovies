//
//  TableViewControllerUpComingMovies.m
//  UpcomingMovies
//
//  Created by Santex on 10/28/16.
//  Copyright © 2016 Cegonya. All rights reserved.
//

#import "TableViewControllerUpComingMovies.h"
#import "MoviesService.h"
#import "MoviesData.h"
#import "TableViewCellMovie.h"
#import "NSDate+Additions.h"

@interface TableViewControllerUpComingMovies ()

@property (strong, nonatomic) NSMutableArray *movies;

@end

@implementation TableViewControllerUpComingMovies

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    self.movies                       = [NSMutableArray new];
    self.tableView.rowHeight          = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 111.0f;

    [[MoviesService sharedInstance] requestUpcomingMoviesWithSuccess:^(NSArray *data){
         [self.movies addObjectsFromArray:data];
         [self.tableView reloadData];
     }
                                                             failure:^(NSError *error){
     }];

    [[MoviesService sharedInstance] requestGenresWithSuccess:^(NSArray *data){
         NSLog(@"%@", data);
     }
                                                     failure:^(NSError *error){
     }];

    [[MoviesService sharedInstance] requestConfigurationWithSuccess:^(NSArray *data){
     }
                                                            failure:^(NSError *error){
     }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewCellMovie *cell = [tableView dequeueReusableCellWithIdentifier:@"cellMovie" forIndexPath:indexPath];

    // Configure the cell...
    Movie *movie = self.movies[indexPath.row];

    cell.title.text       = movie.title;
    cell.releaseDate.text = [movie.releaseDate ISO8601String];
    cell.imageView.tag    = indexPath.row;
    UIImage *image = [[MoviesData sharedInstance] getSmallPosterFromMovie:movie
                                                               completion:^(BOOL finished){
                          if (finished) {
                              [tableView reloadRowsAtIndexPaths:@[indexPath]
                                               withRowAnimation:UITableViewRowAnimationNone];
                          }
                      }];

//    cell.imageView.contentMode = UIViewContentModeCenter;
//    if (cell.imageView.bounds.size.width > image.size.width && cell.imageView.bounds.size.height > image.size.height) {
//        cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
//    }

    cell.imageView.image = image;

    return cell;
}

/*
   // Override to support conditional editing of the table view.
   - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
   }
 */

/*
   // Override to support editing the table view.
   - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
   }
 */

/*
   // Override to support rearranging the table view.
   - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
   }
 */

/*
   // Override to support conditional rearranging of the table view.
   - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
   }
 */

   #pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"segueMovieDetail"])
    {
                
    }
}

@end
