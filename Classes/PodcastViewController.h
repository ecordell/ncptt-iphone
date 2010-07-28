//
//  FirstViewController.h
//  NCPTT
//
//  Created by Evan Cordell on 7/28/10.
//  Copyright NCPTT 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PodcastTableViewCell.h"

@interface PodcastViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, NSXMLParserDelegate> {
    IBOutlet UITableView *podcastTableView;
    IBOutlet UIButton *subscribeButton;
    IBOutlet UIButton *rateButton;
    
    UIActivityIndicatorView * activityIndicator; 
    CGSize cellSize; 
    NSXMLParser * rssParser; 
    NSMutableArray * stories; 
    NSMutableDictionary * item;
    NSString * currentElement; 
    NSMutableString * currentTitle, * currentDate, * currentDescription, * currentLength; 
}

@property (nonatomic, retain) UITableView *podcastTableView;
@property (nonatomic, retain) UIButton *subscribeButton;
@property (nonatomic, retain) UIButton *rateButton;

-(IBAction)subscribeButtonClicked;
-(IBAction)rateButtonClicked;

@end
