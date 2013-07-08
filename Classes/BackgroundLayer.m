//
//  BackgroundLayer.m
//  Cocos2D_BlockBreak
//
//  Created by 何遵祖 on 12-1-9.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "BackgroundLayer.h"


@implementation BackgroundLayer

-(id) init
{
	self=[super init];
	if (self!=nil) {
		CCSprite *backGroundImage=[CCSprite spriteWithFile:@"background.png"];
		CGSize screenSize=[[CCDirector sharedDirector]winSize];
		[backGroundImage setPosition:ccp(screenSize.width/2,screenSize.height/2)];
		
		[self addChild:backGroundImage z:0 tag:1];
		
	}
	
	return self;
}

@end
