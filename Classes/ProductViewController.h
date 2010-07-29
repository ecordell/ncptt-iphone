//
//  FirstViewController.h
//  NCPTT
//
//  Created by Evan Cordell on 7/28/10.
//  Copyright NCPTT 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductTableViewCell.h"
#import "ProductItemViewController.h"

@interface ProductViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, NSXMLParserDelegate> {
    IBOutlet UITableView *productTableView;
    UIActivityIndicatorView * activityIndicator; 
    CGSize cellSize; 
    NSXMLParser * rssParser; 
    NSMutableArray * stories; 
    NSMutableDictionary * item;
    NSString * currentElement; 
    NSMutableString * currentTitle, * currentDescription, * currentLink; 
    ProductItemViewController *itemController;
}

@property (nonatomic, retain) UITableView *productTableView;
@property (nonatomic, retain) ProductItemViewController *itemController;

@end
