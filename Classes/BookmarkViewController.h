//
//  BookmarkViewController.h
//  EigoWeb
//
//  Created by Yuumi Yoshida on 10/07/21.
//  Copyright 2010 EY-Office. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BookmarkViewController : UIViewController <UITableViewDelegate> {
	UITableView    *bookmarkTable;
	UIWebView      *browser;
@private
	NSMutableArray *bookmarks;
}
@property (nonatomic, retain) IBOutlet UITableView  *bookmarkTable;
@property (nonatomic, retain) UIWebView      *browser;

- (IBAction) pushAddButton:(id)sender;
- (IBAction) pushEditButton:(id)sender;

@end
