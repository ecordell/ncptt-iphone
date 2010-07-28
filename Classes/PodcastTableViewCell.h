//
//  BlogTableViewCell.h
//  NCPTT
//
//  Created by Evan Cordell on 7/28/10.
//  Copyright 2010 NCPTT. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PodcastTableViewCell : UITableViewCell {
    IBOutlet UILabel *title;
    IBOutlet UILabel *description;
    IBOutlet UILabel *date;
    IBOutlet UILabel *length;
}
@property (nonatomic, retain) UILabel *title;
@property (nonatomic, retain) UILabel *description;
@property (nonatomic, retain) UILabel *date;
@property (nonatomic, retain) UILabel *length;

@end
