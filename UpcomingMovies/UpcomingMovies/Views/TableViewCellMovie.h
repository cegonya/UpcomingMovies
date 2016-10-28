//
//  TableViewCellMovie.h
//  UpcomingMovies
//
//  Created by Santex on 10/28/16.
//  Copyright © 2016 Cegonya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCellMovie : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageViewPoster;
@property (weak, nonatomic) IBOutlet UILabel     *title;
@property (weak, nonatomic) IBOutlet UILabel     *genres;
@property (weak, nonatomic) IBOutlet UILabel     *releaseDate;

@end
