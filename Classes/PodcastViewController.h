//
//  FirstViewController.h
//  NCPTT
//
//  Created by Evan Cordell on 7/28/10.
//  Copyright NCPTT 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PodcastTableViewCell.h"
#import "PodcastDetailViewController.h"

@interface PodcastViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, NSXMLParserDelegate> {
    IBOutlet UITableView *podcastTableView;
    IBOutlet UIButton *subscribeButton;
    IBOutlet UIButton *rateButton;
    IBOutlet UIActivityIndicatorView * activityIndicator; 
    
    CGSize cellSize; 
    NSXMLParser * rssParser; 
    NSMutableArray * stories; 
    NSMutableDictionary * item;
    NSString * currentElement; 
    NSMutableString * currentTitle, * currentDate, * currentDescription, * currentLength, * currentUrl; 
    PodcastDetailViewController * detailController;
}

@property (nonatomic, retain) UITableView *podcastTableView;
@property (nonatomic, retain) UIButton *subscribeButton;
@property (nonatomic, retain) UIButton *rateButton;
@property (nonatomic, retain) PodcastDetailViewController * detailController;

-(IBAction)subscribeButtonClicked;
-(IBAction)rateButtonClicked;

@end
