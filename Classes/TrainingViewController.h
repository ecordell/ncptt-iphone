//
//  FirstViewController.h
//  NCPTT
//
//  Created by Evan Cordell on 7/28/10.
//  Copyright NCPTT 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TrainingTableViewCell.h"

@interface TrainingViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, NSXMLParserDelegate> {
    IBOutlet UITableView *trainingTableView;
    UIActivityIndicatorView * activityIndicator; 
    CGSize cellSize; 
    NSXMLParser * rssParser; 
    NSMutableArray * stories; 
    NSMutableDictionary * item;
    NSString * currentElement; 
    NSMutableString * currentTitle, * currentDate, * currentSummary, * currentLink; 
}

@property (nonatomic, retain) UITableView *trainingTableView;

@end