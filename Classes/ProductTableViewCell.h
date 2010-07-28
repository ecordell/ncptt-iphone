//
//  BlogTableViewCell.h
//  NCPTT
//
//  Created by Evan Cordell on 7/28/10.
//  Copyright 2010 NCPTT. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ProductTableViewCell : UITableViewCell {
    IBOutlet UILabel *title;
    IBOutlet UILabel *description;
    IBOutlet UIImageView *productImage;
}
@property (nonatomic, retain) UILabel *title;
@property (nonatomic, retain) UILabel *description;
@property (nonatomic, retain) UIImageView *productImage;
@end
