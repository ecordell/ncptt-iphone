//
//  AboutViewController.h
//  NCPTT
//
//  Created by Evan Cordell on 7/28/10.
//  Copyright 2010 NCPTT. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AboutViewController : UIViewController {
    IBOutlet UIButton *supportButton;
    IBOutlet UIButton *contactButton;
}
@property (nonatomic, retain) UIButton *supportButton;
@property (nonatomic, retain) UIButton *contactButton;

- (IBAction)supportButtonClicked;
- (IBAction)contactButtonClicked;

@end
