//
//  Cocos2D_BlockBreakAppDelegate.h
//  Cocos2D_BlockBreak
//
//  Created by 何遵祖 on 11-10-22.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface Cocos2D_BlockBreakAppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
