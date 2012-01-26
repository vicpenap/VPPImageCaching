//
//  XMLParserExample.m
//  VPPLibraries
//
//  Created by Víctor on 26/10/11.
//  Copyright 2011 Víctor Pena Placer. All rights reserved.
//

#import "ImageCachingExample.h"
#import "XMLReader.h"
#import "VPPImageCachingHelper.h"

@implementation ImageCachingExample
@synthesize images;

- (void) loadImages {
    // let's get some images
	loading = YES;
    [self.tableView reloadData];
	NSOperationQueue *q = [[NSOperationQueue alloc] init];
	[q addOperationWithBlock:^(void) {
		NSString *url = @"http://api.flickr.com/services/rest/?method=flickr.interestingness.getList&api_key=fd7d47bde71949d18d089a795d81818a&extras=url_sq&per_page=20&format=rest";
        
		NSError *error;
		
		NSString *contents = [NSString stringWithContentsOfURL:[NSURL URLWithString:url] encoding:NSUTF8StringEncoding error:&error];
		
		NSDictionary *parsed = [XMLReader dictionaryForXMLString:contents error:&error];
		
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.images = [[[parsed objectForKey:@"rsp"] objectForKey:@"photos"] objectForKey:@"photo"];
            
            loading = NO;
            [self.tableView reloadData];            
        }];
	}];
	
	[q release];
}

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];

    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(loadImages)] autorelease];
	
    [self loadImages];
}


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	
    if (loading) {
        return 1;
    }
    
    return [self.images count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }

	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	
	if (loading) {
		cell.textLabel.text = @"Loading...";
        cell.imageView.image = nil;
		return cell;
	}
	
    NSDictionary *dic = [self.images objectAtIndex:indexPath.row];
	cell.textLabel.text = [dic objectForKey:@"title"];
	cell.imageView.image = [UIImage imageNamed:@"Placeholder"];
	NSURL *url = [NSURL URLWithString:[dic objectForKey:@"url_sq"]];
	[[VPPImageCachingHelper sharedInstance] imageForURL:url 
                                             completion:^(UIImage *image) {
                                                 cell.imageView.image = image;
                                             }];
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	/*
	 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
	 */
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    [[VPPImageCachingHelper sharedInstance] flushCache];
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    self.images = nil;
    [super dealloc];
}


@end

