//
//  BlogEnteryView.m
//  NCPTT
//
//  Created by Evan Cordell on 7/28/10.
//  Copyright 2010 NCPTT. All rights reserved.
//

#import "BlogEntryView.h"


@implementation BlogEntryView
@synthesize webview, url;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)dealloc {
    [super dealloc];
}


@end
