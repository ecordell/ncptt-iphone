//
//  FirstViewController.m
//  NCPTT
//
//  Created by Evan Cordell on 7/28/10.
//  Copyright NCPTT 2010. All rights reserved.
//

#import "ProductViewController.h"


@implementation ProductViewController

@synthesize productTableView, itemController;

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

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/
- (void)parseXMLFileAtURL:(NSString *)URL { 
    NSAutoreleasePool *apool = [[NSAutoreleasePool alloc] init];
    stories = [[NSMutableArray alloc] init]; //you must then convert the path to a proper NSURL or it won't work
    NSURL *xmlURL = [NSURL URLWithString:URL]; // here, for some reason you have to use NSClassFromString when trying to alloc NSXMLParser, otherwise you will get an object not found error 
    // this may be necessary only for the toolchain 
    rssParser = [[NSXMLParser alloc] initWithContentsOfURL:xmlURL]; // Set self as the delegate of the parser so that it will receive the parser delegate methods callbacks. 
    [rssParser setDelegate:self]; // Depending on the XML document you're parsing, you may want to enable these features of NSXMLParser. 
    [rssParser setShouldProcessNamespaces:NO]; 
    [rssParser setShouldReportNamespacePrefixes:NO]; 
    [rssParser setShouldResolveExternalEntities:NO]; 
    [rssParser parse]; 
    [apool release];
}
- (void)viewDidAppear:(BOOL)animated { 
    [super viewDidAppear:animated]; 
    if ([stories count] == 0) { 
        NSString * path = @"http://www.ncptt.nps.gov/category/product-catalog/feed/"; 
        [self performSelectorInBackground:@selector(parseXMLFileAtURL:) withObject:path]; 
    } 
    cellSize = CGSizeMake([productTableView bounds].size.width, 60); 
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
        currentDescription = [[NSMutableString alloc] init]; 
        currentLink = [[NSMutableString alloc] init];
        currentImageUrl = [[NSMutableString alloc] init];
        currentImage = [[UIImage alloc] init];
    } 
} 
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{ 
    //NSLog(@"ended element: %@", elementName); 
    if ([elementName isEqualToString:@"item"]) { 
        currentImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://www.ncptt.nps.gov/wp-content/themes/ncptt-remix/thumb.php?src=http://www.ncptt.nps.gov/wp-content/uploads/ncptt-logo-large.png&h=80&w=80&zc=1&q=95"]]];
        // save values to an item, then store that item into the array... 
        [item setObject:currentTitle forKey:@"title"]; 
        [item setObject:currentDescription forKey:@"description"]; 
        [item setObject:currentLink forKey:@"link"];
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
    } else if ([currentElement isEqualToString:@"description"]) { 
        [currentDescription appendString:string]; 
    } else if ([currentElement isEqualToString:@"link"]) { 
        [currentLink appendString:string]; 
    } else if ([currentElement isEqualToString:@"image"]) {
        [currentImageUrl appendString:string];
    }
}
- (void)parserDidEndDocument:(NSXMLParser *)parser { 
    [activityIndicator setHidden:YES]; 
    [activityIndicator removeFromSuperview]; 
    NSLog(@"all done!"); 
    NSLog(@"stories array has %d items", [stories count]); 
    [productTableView reloadData]; 
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
    static NSString *productCell = @"ProductTableViewCell"; 
    ProductTableViewCell *cell = (ProductTableViewCell *)[tableView dequeueReusableCellWithIdentifier:productCell]; 
    if (cell == nil) { 
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ProductViewCell" owner:nil options:nil];
        for (id currentObject in topLevelObjects) {
            if ([currentObject isKindOfClass:[UITableViewCell class]]) {
                cell = (ProductTableViewCell *) currentObject;
                break;
            }
        }
    } // Set up the cell 
    int storyIndex = [indexPath indexAtPosition: [indexPath length] - 1]; 
    cell.title.text = [[stories objectAtIndex:storyIndex] objectForKey:@"title"];
    cell.description.text = [[stories objectAtIndex:storyIndex] objectForKey:@"description"];
    cell.imageView.image = [[stories objectAtIndex:storyIndex] objectForKey:@"image"];
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [stories count];
}
- (void)tableView: (UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *)indexPath {
    
    int storyIndex = [indexPath indexAtPosition: [indexPath length] - 1];
    if (itemController == nil) {
        self.itemController = [[ProductItemViewController alloc] initWithNibName:@"ProductItemView" bundle:[NSBundle mainBundle]];
    }
    itemController.url = [[stories objectAtIndex:storyIndex] objectForKey:@"link"];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:itemController.view cache:YES];
    [self.view addSubview:[itemController view]];
    [itemController loadUrl];
    [UIView commitAnimations];
}
- (void)dealloc {
    [currentElement release]; 
    [rssParser release]; 
    [stories release]; 
    [item release]; 
    [currentTitle release];
    [currentDescription release];
    [super dealloc];
}

@end
