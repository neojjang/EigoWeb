//
//  DictionayWebView.m
//  EigoWeb
//
//  Created by Yuumi Yoshida on 10/07/21.
//  Copyright 2010 EY-Office. All rights reserved.
//

#import "DictionayWebView.h"

#pragma mark Private properties and methods definition

@interface DictionayWebView ()
- (void)lookUpDictionary:(id)sender;
- (IBAction)longPressGesture:(UIGestureRecognizer *)sender;
- (void)installGestureRecognizer;
@end

@implementation DictionayWebView
@synthesize lookUpDelegate;
@synthesize lookUpSelector;


#pragma mark -

- (id)initWithCoder:(NSCoder*)coder {
	if (self = [super initWithCoder:coder]) {
		[self installGestureRecognizer];
	}
	return self;
}

- (id)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		[self installGestureRecognizer];
	}
	return self;
}


#pragma mark -

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
	return YES;
}

- (BOOL)canBecomeFirstResponder {
	return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
	return action == @selector(copy:) ||  action == @selector(lookUpDictionary:);
}


#pragma mark -

- (void)installGestureRecognizer {
	UILongPressGestureRecognizer *longPressRecognizer = [[UILongPressGestureRecognizer alloc]
														 initWithTarget:self action:@selector(longPressGesture:)];
	longPressRecognizer.delegate = self;
	longPressRecognizer.minimumPressDuration = 0.3;
	[self addGestureRecognizer:longPressRecognizer];
	[longPressRecognizer release];
}


- (IBAction)longPressGesture:(UIGestureRecognizer *)sender {
	if ([sender state] == UIGestureRecognizerStateBegan) {
		
		[self becomeFirstResponder];
		UIMenuItem *menuItem = [[UIMenuItem alloc] initWithTitle:@"Look up"
								action:@selector(lookUpDictionary:)];
		UIMenuController *menuCont = [UIMenuController sharedMenuController];
		CGPoint p = [sender locationInView:sender.view];
		[menuCont setTargetRect:CGRectMake(p.x, p.y, 20, 20) inView:self];
		menuCont.arrowDirection = UIMenuControllerArrowDown;
		menuCont.menuItems = [NSArray arrayWithObject:menuItem];
		[menuCont setMenuVisible:NO animated:NO];
	}
}

- (void)lookUpDictionary:(id)sender {
	
	UIMenuController *menuCont = [UIMenuController sharedMenuController];
	CGPoint p = [self.window convertPoint:menuCont.menuFrame.origin toView:self];
	NSString *dir = p.x > self.frame.size.width / 2.0 ? @"R" : @"L";
	
	[self performSelector:@selector(copy:) withObject:sender];
	NSString *word = [UIPasteboard generalPasteboard].string;
	if (lookUpDelegate && lookUpSelector) {
		//NSLog(@" call %@ %@", word, dir);
		[lookUpDelegate performSelector:lookUpSelector withObject:word withObject:dir];
	}
}


@end
