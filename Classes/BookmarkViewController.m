    //
//  BookmarkViewController.m
//  EigoWeb
//
//  Created by Yuumi Yoshida on 10/07/21.
//  Copyright 2010 EY-Office. All rights reserved.
//

#import "BookmarkViewController.h"

#define CONFIG_BOOKMARK_KEY	@"Bookmark"

#pragma mark -
@interface BookmarkViewController () 

@property (nonatomic, retain) NSMutableArray *bookmarks;

- (void) saveBookmark:(NSArray *)aBookmarks;
- (NSMutableArray *) loadBookmark;

@end


#pragma mark -
@implementation BookmarkViewController
@synthesize bookmarkTable;
@synthesize bookmarks;
@synthesize browser;


#pragma mark -

- (void) viewDidLoad {
	[super viewDidLoad];
	self.bookmarks = [self loadBookmark];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)viewDidUnload {
	self.bookmarkTable = nil;
	self.bookmarks = nil;
	self.browser = nil;
    [super viewDidUnload];
}


- (void)dealloc {
	[bookmarkTable release];
	[bookmarks release];
	[browser release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}


#pragma mark -

- (IBAction) pushAddButton:(id)sender {
	[bookmarks addObject:[NSString stringWithFormat:@"%@\t%@",
						  [browser stringByEvaluatingJavaScriptFromString:@"document.title"],
						  [browser stringByEvaluatingJavaScriptFromString:@"document.URL"]]];

	[self saveBookmark:bookmarks];
	[bookmarkTable reloadData];
}

- (IBAction) pushEditButton:(id)sender {
	if (bookmarkTable.editing) {
		((UIBarButtonItem *)sender).title = @"Edit";
		[bookmarkTable setEditing:NO animated:YES];
	} else {
		((UIBarButtonItem *)sender).title = @"Done";
		[bookmarkTable setEditing:YES animated:YES];
	}
}


#pragma mark -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [bookmarks count];
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {	
	static NSString *CellIdentifier = @"Bookmark";
	
	UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
	}
	
	NSArray *bookmarkItems = [[bookmarks objectAtIndex:[indexPath row]] componentsSeparatedByString:@"\t"];
	cell.textLabel.text = [bookmarkItems objectAtIndex:0];
	cell.detailTextLabel.text = [bookmarkItems objectAtIndex:1];
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSString *bookmark = [bookmarks objectAtIndex:[indexPath row]];
	[browser loadRequest:[NSURLRequest requestWithURL:
						  [NSURL URLWithString:[[bookmark componentsSeparatedByString:@"\t"] objectAtIndex:1]]]];
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	[bookmarks removeObjectAtIndex:[indexPath row]];
	[self saveBookmark:bookmarks];
	[bookmarkTable reloadData];
}



#pragma mark -

- (void) saveBookmark:(NSArray *)aBookmarks {
	[[NSUserDefaults standardUserDefaults] setObject:aBookmarks forKey:CONFIG_BOOKMARK_KEY];
}

- (NSMutableArray *) loadBookmark {
	id aBookmarks = [[NSUserDefaults standardUserDefaults] stringArrayForKey:CONFIG_BOOKMARK_KEY];
	if (aBookmarks) {
		return [[NSMutableArray alloc] initWithArray:aBookmarks];
	} else {
		return [[NSMutableArray alloc] init];
	}
}

@end
