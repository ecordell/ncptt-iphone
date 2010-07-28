//
//  BlogTableViewCell.h
//  NCPTT
//
//  Created by Evan Cordell on 7/28/10.
//  Copyright 2010 NCPTT. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BlogTableViewCell : UITableViewCell {
    IBOutlet UILabel *title;
    IBOutlet UILabel *description;
    IBOutlet UIImageView *blogImage;
}
@property (nonatomic, retain) UILabel *title;
@property (nonatomic, retain) UILabel *description;
@property (nonatomic, retain) UIImageView *blogImage;
@end
