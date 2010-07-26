    //
//  DictionaryViewController.m
//  EigoWeb
//
//  Created by Yuumi Yoshida on 10/07/20.
//  Copyright 2010 EY-Office. All rights reserved.
//

#import "DictionaryViewController.h"

#pragma mark -
@interface DictionaryViewController ()

- (void) doSearch;

@end

#pragma mark -
@implementation DictionaryViewController
@synthesize eijiroWebView;
@synthesize eijiroSearchBar;
@synthesize activeIndicator;
@synthesize searchWord;


#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
	
	eijiroWebView.delegate = self;
	eijiroWebView.scalesPageToFit = YES;
	activeIndicator.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	if (searchWord) {
		eijiroSearchBar.text = searchWord;
		[self doSearch];
	} else {
		[eijiroSearchBar becomeFirstResponder];
	}
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
	self.eijiroWebView = nil;
	self.eijiroSearchBar = nil;
	self.activeIndicator = nil;
	self.searchWord = nil;
    [super viewDidUnload];
}

- (void)dealloc {
	[eijiroWebView release];
	[eijiroSearchBar release];
	[activeIndicator release];
	[searchWord release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

#pragma mark -

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
	[self doSearch];
	[searchBar resignFirstResponder];
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
	
	NSString *js = 
	  @"var meta = document.createElement('meta'); \
		meta.name = 'viewport'; meta.content = 'width=960; initial-scale=1.0;'; \
		document.getElementsByTagName('head')[0].appendChild(meta);window.scrollTo(0,300);";
	[eijiroWebView stringByEvaluatingJavaScriptFromString:js];
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	[activeIndicator stopAnimating];
	activeIndicator.hidden = YES;
}


#pragma mark -

- (void) doSearch {
	NSString *url = [NSString stringWithFormat:@"http://eow.alc.co.jp/%@", 
					 [eijiroSearchBar.text stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
	[eijiroWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}


@end
