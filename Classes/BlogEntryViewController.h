//
//  BlogEntryViewController.h
//  NCPTT
//
//  Created by Evan Cordell on 7/28/10.
//  Copyright 2010 NCPTT. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BlogEntryViewController : UIViewController <UIWebViewDelegate> {
    IBOutlet UIWebView *webview;
    NSString *url;
}
@property (nonatomic, retain) NSString *url;
@property (nonatomic, retain) UIWebView *webview;
@end
