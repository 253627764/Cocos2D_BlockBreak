//
//  Paddle.m
//  Cocos2D_BlockBreak
//
//  Created by 何遵祖 on 11-10-23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Paddle.h"

@implementation Paddle

#define actionDuration 0.25//moving speed
#define paddleHight 60

-(id) init
{
	self=[super init];
	if (self) {
		
		self.isTouchEnabled=YES;
		
		CGSize winSize=[[CCDirector sharedDirector]winSize];
		paddle=[CCSprite spriteWithFile:@"paddle.png"];
		[self addChild:paddle];
		paddle.position=ccp(winSize.width/2,paddleHight);
		
	}
	return self;
}

-(void) paddleHitBall:(MovingBall *) playingBall
{

	CGRect paddleRect=CGRectMake(paddle.position.x-(paddle.contentSize.width/2), 
								 paddle.position.y-(paddle.contentSize.height/2), 
								 paddle.contentSize.width, paddle.contentSize.height);
	
	CGRect ballRect=CGRectMake(playingBall.ball.position.x-(playingBall.ball.contentSize.width/2), 
							   playingBall.ball.position.y-(playingBall.ball.contentSize.height/2), 
							   playingBall.ball.contentSize.width, playingBall.ball.contentSize.height);
	
	
	if (CGRectIntersectsRect(paddleRect, ballRect)) 
	{

		playingBall.speedY=-playingBall.speedY;
		
	}
	
}

-(void) ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	CGSize winSize=[[CCDirector sharedDirector]winSize];
	
	UITouch *touch=[touches anyObject];
	
	CGPoint location=[touch locationInView:[touch view]];
	location=[[CCDirector sharedDirector]convertToGL:location];
	
	if (location.x<=paddle.contentSize.width/2) {
		location.x=paddle.contentSize.width/2;
	}
	
	if (location.x>=winSize.width-paddle.contentSize.width/2) {
		location.x=winSize.width-paddle.contentSize.width/2;
	}
	
	[paddle runAction:[CCSequence actions:[CCMoveTo actionWithDuration:actionDuration position:ccp(location.x,paddleHight)],nil]];
}

@end
