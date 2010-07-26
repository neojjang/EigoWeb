//
//  EigoWebViewController.h
//  EigoWeb
//
//  Created by Yuumi Yoshida on 10/07/20.
//  Copyright EY-Office 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DictionaryViewController.h"
#import "BookmarkViewController.h"
#import "DictionayWebView.h"

@interface EigoWebViewController : UIViewController <UIWebViewDelegate, UIPopoverControllerDelegate> {
	DictionayWebView         *browser;
	UIActivityIndicatorView  *activeIndicator;
	UIBarButtonItem          *leftDictonaryButton;
	UIBarButtonItem          *rightDictonaryButton;
@private
	DictionaryViewController *dictionaryViewController;
	BookmarkViewController   *bookmarkViewController;
	UIPopoverController      *popover;
}
@property (nonatomic, retain) IBOutlet DictionayWebView         *browser;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView  *activeIndicator;
@property (nonatomic, retain) IBOutlet UIBarButtonItem          *leftDictonaryButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem          *rightDictonaryButton;

- (IBAction) pushBackButton:(id)sender;
- (IBAction) pushForwardButton:(id)sender;
- (IBAction) pushBookMarkButton:(id)sender;
- (IBAction) pushDictionaryButton:(id)sender;
- (IBAction) pushStopButton:(id)sender;
- (IBAction) pushReloadButton:(id)sender;

@end

