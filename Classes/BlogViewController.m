//
//  FirstViewController.m
//  NCPTT
//
//  Created by Evan Cordell on 7/28/10.
//  Copyright NCPTT 2010. All rights reserved.
//

#import "BlogViewController.h"


@implementation BlogViewController

@synthesize blogTableView, entryController;

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (YES);
}

- (void)parseXMLFileAtURL:(NSString *)URL { 
    stories = [[NSMutableArray alloc] init]; //you must then convert the path to a proper NSURL or it won't work
    NSURL *xmlURL = [NSURL URLWithString:URL]; // here, for some reason you have to use NSClassFromString when trying to alloc NSXMLParser, otherwise you will get an object not found error 
    // this may be necessary only for the toolchain 
    rssParser = [[NSXMLParser alloc] initWithContentsOfURL:xmlURL]; // Set self as the delegate of the parser so that it will receive the parser delegate methods callbacks. 
    [rssParser setDelegate:self]; // Depending on the XML document you're parsing, you may want to enable these features of NSXMLParser. 
    [rssParser setShouldProcessNamespaces:NO]; 
    [rssParser setShouldReportNamespacePrefixes:NO]; 
    [rssParser setShouldResolveExternalEntities:NO]; 
    [rssParser parse]; 
}
- (void)viewDidAppear:(BOOL)animated { 
    [super viewDidAppear:animated]; 
    if ([stories count] == 0) { 
        NSString * path = @"http://www.ncptt.nps.gov/feed/"; 
        [self parseXMLFileAtURL:path]; 
    } 
    cellSize = CGSizeMake([blogTableView bounds].size.width, 60); 
}

- (void)parserDidStartDocument:(NSXMLParser *)parser {
    NSLog(@"found file and started parsing"); 
} 
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError { 
    NSString * errorString = [NSString stringWithFormat:@"Unable to download story feed from web site (Error code %i )", [parseError code]]; 
    NSLog(@"error parsing XML: %@", errorString); 
    UIAlertView * errorAlert = [[UIAlertView alloc] initWithTitle:@"Error loading content" message:errorString delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil]; 
    [errorAlert show]; 
} 
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{ 
    //NSLog(@"found this element: %@", elementName); 
    currentElement = [elementName copy]; 
    if ([elementName isEqualToString:@"item"]) { // clear out our story item caches... 
        item = [[NSMutableDictionary alloc] init]; 
        currentTitle = [[NSMutableString alloc] init]; 
        currentDate = [[NSMutableString alloc] init]; 
        currentDescription = [[NSMutableString alloc] init]; 
        currentCreator = [[NSMutableString alloc] init]; 
        currentUrl = [[NSMutableString alloc] init];
        currentImage = [[NSMutableString alloc] init];
    } 
} 
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{ 
    //NSLog(@"ended element: %@", elementName); 
    if ([elementName isEqualToString:@"item"]) { 
        // save values to an item, then store that item into the array... 
        [item setObject:currentTitle forKey:@"title"]; 
        [item setObject:currentCreator forKey:@"dc:creator"]; 
        [item setObject:currentDescription forKey:@"description"]; 
        [item setObject:currentDate forKey:@"pubDate"]; 
        [item setObject:currentUrl forKey:@"link"];
        [item setObject:currentImage forKey:@"image"];
        [stories addObject:[item copy]]; 
        NSLog(@"adding story: %@", currentTitle); 
    } 
} 
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{ 
    //NSLog(@"found characters: %@", string); 
    // save the characters for the current item... 
    if ([currentElement isEqualToString:@"title"]) { 
        [currentTitle appendString:string]; 
    } else if ([currentElement isEqualToString:@"dc:creator"]) { 
        [currentCreator appendString:string]; 
    } else if ([currentElement isEqualToString:@"description"]) { 
        [currentDescription appendString:string]; 
    } else if ([currentElement isEqualToString:@"pubDate"]) { 
        [currentDate appendString:string]; 
    } else if ([currentElement isEqualToString:@"link"]) { 
        [currentUrl appendString:string]; 
    } else if ([currentElement isEqualToString:@"image"]) { 
        [currentImage appendString:string]; 
    } 
}
- (void)parserDidEndDocument:(NSXMLParser *)parser { 
    [activityIndicator stopAnimating]; 
    [activityIndicator removeFromSuperview]; 
    NSLog(@"all done!"); 
    NSLog(@"stories array has %d items", [stories count]); 
    [blogTableView reloadData]; 
}
- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


//UITableView Methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath { 
    static NSString *blogCell = @"BlogTableViewCell"; 
    BlogTableViewCell *cell = (BlogTableViewCell *)[tableView dequeueReusableCellWithIdentifier:blogCell]; 
    if (cell == nil) { 
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"BlogViewCell" owner:nil options:nil];
        for (id currentObject in topLevelObjects) {
            if ([currentObject isKindOfClass:[UITableViewCell class]]) {
                cell = (BlogTableViewCell *) currentObject;
                break;
            }
        }
    } // Set up the cell 
    int storyIndex = [indexPath indexAtPosition: [indexPath length] - 1]; 
    cell.title.text = [[stories objectAtIndex:storyIndex] objectForKey:@"title"];
    cell.description.text = [self flattenHTML:[[stories objectAtIndex:storyIndex] objectForKey:@"description"]];
    cell.date.text = [[[stories objectAtIndex:storyIndex] objectForKey:@"pubDate"] substringToIndex:16];
    cell.creator.text = [[stories objectAtIndex:storyIndex] objectForKey:@"dc:creator"];
    //cell.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://cvcl.mit.edu/hybrid/cat2.jpg"]]];
    return cell; 
}

- (NSString *)flattenHTML:(NSString *)html {
    
    NSScanner *theScanner;
    NSString *text = nil;
    
    theScanner = [NSScanner scannerWithString:html];
    
    while ([theScanner isAtEnd] == NO) {
        
        // find start of tag
        [theScanner scanUpToString:@"<" intoString:NULL] ; 
        
        // find end of tag
        [theScanner scanUpToString:@">" intoString:&text] ;
        
        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        html = [html stringByReplacingOccurrencesOfString:
                [ NSString stringWithFormat:@"%@>", text]
                                               withString:@" "];
        
    } // while //
    
    return html;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [stories count];
}
- (void)tableView: (UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *)indexPath {
    
    int storyIndex = [indexPath indexAtPosition: [indexPath length] - 1];
    if (entryController == nil) {
        self.entryController = [[BlogEntryViewController alloc] initWithNibName:@"BlogEntryView" bundle:[NSBundle mainBundle]];
    }
    entryController.url = [[stories objectAtIndex:storyIndex] objectForKey:@"link"]; 
    if((self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft)||(self.interfaceOrientation == UIInterfaceOrientationLandscapeRight))
    {
        CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
        CGRect newFrame =  CGRectMake(0.0, 0.0, applicationFrame.size.height, applicationFrame.size.width);
        [entryController.view setFrame:newFrame];
    } else {
        CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
        CGRect newFrame =  CGRectMake(0.0, 0.0, applicationFrame.size.width, applicationFrame.size.height);
        [entryController.view setFrame:newFrame];
    }

    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:entryController.view cache:NO];
    [self.view addSubview:[entryController view]];
    [entryController loadUrl];
    [UIView commitAnimations];
}
- (void)dealloc {
    [entryController release];
    [currentElement release]; 
    [rssParser release]; 
    [stories release]; 
    [item release]; 
    [currentTitle release];
    [currentDate release];
    [currentDescription release]; 
    [currentCreator release]; 
    [super dealloc];
}

@end
