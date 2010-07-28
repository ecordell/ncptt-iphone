//
//  FirstViewController.h
//  NCPTT
//
//  Created by Evan Cordell on 7/28/10.
//  Copyright NCPTT 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BlogTableViewCell.h"
#import "BlogEntryViewController.h"

@interface BlogViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, NSXMLParserDelegate> {
    IBOutlet UITableView *blogTableView;
    UIActivityIndicatorView * activityIndicator; 
    CGSize cellSize; 
    NSXMLParser * rssParser; 
    NSMutableArray * stories; 
    NSMutableDictionary * item;
    NSString * currentElement; 
    NSMutableString * currentTitle, * currentDate, * currentDescription, * currentCreator, * currentUrl;
    BlogEntryViewController *entryController;
}

@property (nonatomic, retain) UITableView *blogTableView;
@property (nonatomic, retain) BlogEntryViewController *entryController;
- (NSString *)flattenHTML:(NSString *)html;

@end
