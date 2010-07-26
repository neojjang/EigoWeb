//
//  DictionaryViewController.h
//  EigoWeb
//
//  Created by Yuumi Yoshida on 10/07/20.
//  Copyright 2010 EY-Office. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DictionaryViewController : UIViewController <UIWebViewDelegate> {
	UIWebView               *eijiroWebView;
	UISearchBar             *eijiroSearchBar;
	UIActivityIndicatorView *activeIndicator;
	NSString                *searchWord;
}
@property (nonatomic, retain) IBOutlet UIWebView               *eijiroWebView;
@property (nonatomic, retain) IBOutlet UISearchBar             *eijiroSearchBar;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activeIndicator;
@property (nonatomic, retain) NSString    *searchWord;

@end
