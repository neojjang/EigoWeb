//
//  DictionayWebView.h
//  EigoWeb
//
//  Created by Yuumi Yoshida on 10/07/21.
//  Copyright 2010 EY-Office. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DictionayWebView : UIWebView <UIGestureRecognizerDelegate> {
	id		lookUpDelegate;
	SEL		lookUpSelector;
}
@property (nonatomic, assign) id       lookUpDelegate;
@property (nonatomic)         SEL      lookUpSelector;


@end
