//
//  EigoWebAppDelegate.h
//  EigoWeb
//
//  Created by Yuumi Yoshida on 10/07/20.
//  Copyright EY-Office 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EigoWebViewController;

@interface EigoWebAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    EigoWebViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet EigoWebViewController *viewController;

@end

