//
//  AboutViewController.m
//  NCPTT
//
//  Created by Evan Cordell on 7/28/10.
//  Copyright 2010 NCPTT. All rights reserved.
//

#import "AboutViewController.h"


@implementation AboutViewController
@synthesize supportButton, contactButton;

/*
- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
    }
    return self;
}
*/
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)supportButtonClicked {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.apple.com"]];
}
- (IBAction)reviewButtonClicked {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.apple.com"]];
}
- (IBAction)contactButtonClicked {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.ncptt.nps.gov/about-us/contact-staff/"]];
}

- (void)dealloc {
    [super dealloc];
}


@end
