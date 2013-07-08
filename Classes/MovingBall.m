//
//  MovingBall.m
//  Cocos2D_BlockBreak
//
//  Created by studenth01 on 11-10-24.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MovingBall.h"

@implementation MovingBall

@synthesize ball;
@synthesize speedX,speedY;
@synthesize level;
@synthesize gameState;

-(id) init
{
	self=[super init];
	if (self) {
		
		self.isTouchEnabled=YES;
		
		//init GameState
		gameState=TRUE;
		
		//init level
		level=3;
		
		//initlaize speed X and Y
		speedX=2*level;
		speedY=-2*level;
		
		//setting windows size
		winSize=[[CCDirector sharedDirector]winSize];
		
		//add Bitmap-ball
		ball=[CCSprite spriteWithFile:@"ball.png"]; 
		[self addChild:ball];
		ball.position=ccp(winSize.width/2-80,150);
		
		float intervalRang=1.0/30.0;
		[self schedule:@selector(ballMoving:) interval:intervalRang];
		
	}
	
	return self;
	
}

-(void) ballMoving:(ccTime) dt
{
	CCLOG(@"123");
	if (ball.position.x>winSize.width-ball.contentSize.width/2||ball.position.x<ball.contentSize.width/2) {
		speedX=-speedX;
	}
	
	if (ball.position.y>winSize.height-ball.contentSize.height/2||ball.position.y<ball.contentSize.height/2) {
		speedY=-speedY;		
	}
	
	[ball runAction:[CCSequence actions:[CCMoveBy actionWithDuration:1.0/100.0f position:ccp(speedX,speedY)],nil]];
	
	gameState=TRUE;
	
	if (ball.position.y<ball.contentSize.height/2) 
	{
		gameState=FALSE;
		[self pauseBallMoving];
	}
}

-(void) pauseBallMoving
{
	[self pauseSchedulerAndActions];
}

-(void) resumeBallMoving
{
	[self resumeSchedulerAndActions];
}

@end
