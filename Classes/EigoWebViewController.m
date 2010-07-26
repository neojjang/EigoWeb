//
//  EigoWebViewController.m
//  EigoWeb
//
//  Created by Yuumi Yoshida on 10/07/20.
//  Copyright EY-Office 2010. All rights reserved.
//

#import "EigoWebViewController.h"

#pragma mark -
@interface EigoWebViewController ()

@property (nonatomic, retain) DictionaryViewController *dictionaryViewController;
@property (nonatomic, retain) BookmarkViewController   *bookmarkViewController;
@property (nonatomic, retain) UIPopoverController      *popover;

- (void)lookUpWord:(NSString *)word direction:(NSString *)dir;

@end

#pragma mark -
@implementation EigoWebViewController
@synthesize browser;
@synthesize activeIndicator;
@synthesize leftDictonaryButton;
@synthesize rightDictonaryButton;
@synthesize dictionaryViewController;
@synthesize bookmarkViewController;
@synthesize popover;


#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
	
	dictionaryViewController = [[DictionaryViewController alloc] init];
	dictionaryViewController.contentSizeForViewInPopover = CGSizeMake(320, 480);
	
	bookmarkViewController = [[BookmarkViewController alloc] init];
	bookmarkViewController.contentSizeForViewInPopover = CGSizeMake(320, 480);
	
	browser.delegate = self;
	browser.scalesPageToFit = YES;
	browser.lookUpDelegate = self;
	browser.lookUpSelector = @selector(lookUpWord:direction:);
	
}

- (void)viewDidUnload {
	self.browser = nil;
	self.activeIndicator = nil;
	self.leftDictonaryButton = nil;
	self.rightDictonaryButton = nil;
	self.dictionaryViewController = nil;
	self.bookmarkViewController = nil;
	self.popover = nil;	
}

- (void)dealloc {
	[browser release];
	[activeIndicator release];
	[leftDictonaryButton release];
	[rightDictonaryButton release];
	[dictionaryViewController release];
	[bookmarkViewController release];
	[popover release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	activeIndicator.hidden = YES;
	
	[browser loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.google.co.jp"]]];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

#pragma mark -

- (IBAction) pushBackButton:(id)sender {
	[browser goBack];
}

- (IBAction) pushForwardButton:(id)sender {
	[browser goForward];
}

- (IBAction) pushStopButton:(id)sender{
	[browser stopLoading];
}

- (IBAction) pushReloadButton:(id)sender{
	[browser reload];
}


- (IBAction) pushBookMarkButton:(id)sender {
	self.popover = [[UIPopoverController alloc] initWithContentViewController:bookmarkViewController];
	popover.delegate = self;
	bookmarkViewController.browser = self.browser;
	[popover presentPopoverFromBarButtonItem:(UIBarButtonItem *)sender
					permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (IBAction) pushDictionaryButton:(id)sender {
	dictionaryViewController.searchWord = nil;
	self.popover = [[UIPopoverController alloc] initWithContentViewController:dictionaryViewController];
	popover.delegate = self;
	[popover presentPopoverFromBarButtonItem:(UIBarButtonItem *)sender
					permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}


#pragma mark -

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
	activeIndicator.hidden = NO;
	[activeIndicator startAnimating];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	[activeIndicator stopAnimating];
	activeIndicator.hidden = YES;

	if (popover) {
		[popover dismissPopoverAnimated:YES];
		self.popover = nil;
	}
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	[activeIndicator stopAnimating];
	activeIndicator.hidden = YES;

	if (popover) {
		[popover dismissPopoverAnimated:YES];
		self.popover = nil;
	}
}

#pragma mark -

- (void)lookUpWord:(NSString *)word direction:(NSString *)dir {
	//NSLog(@"++ lookUpWord: %@ %@", word, dir); 
	dictionaryViewController.searchWord = word;
	self.popover = [[UIPopoverController alloc] initWithContentViewController:dictionaryViewController];
	popover.delegate = self;
	
	[popover presentPopoverFromBarButtonItem:
	 [dir isEqualToString:@"R"] ? leftDictonaryButton : rightDictonaryButton
					permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}




@end
