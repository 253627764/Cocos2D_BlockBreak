//
//  GameStartLayer.m
//  Cocos2D_BlockBreak
//
//  Created by 何遵祖 on 11-10-22.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
// bvvg

#import "GameStartLayer.h"
#import "Paddle.h"

@implementation GameStartLayer

@synthesize score;
@synthesize lifes;
@synthesize gameState;
@synthesize level;

-(id) init
{
	self=[super initWithColor:ccc4(220, 250, 255, 200)];//init With Backgound Color
	if (self) {
		
		CGSize winSize=[[CCDirector sharedDirector]winSize];
		
		self.isTouchEnabled=YES;
		
		score=0;
		lifes=3;
		
		gameState=NO;
		gameOver=NO;
		gameIsBegin=NO;
		
		//add Background
		BackgroundLayer *background=[BackgroundLayer node];
		[self addChild:background];
		
		[self gameStartAnimation];

		//live and liveCount
		CCLabelTTF *liveLabel=[CCLabelTTF labelWithString:@"Live:" fontName:@"ArialHebrew" fontSize:20];
		liveLabel.position=ccp(40,winSize.height-20);
		
		liveCount=[CCLabelBMFont labelWithString:@"3" fntFile:@"font01.fnt"];
		liveCount.position=ccp(100,winSize.height-18);
		
		[self addChild:liveLabel];
		[self addChild:liveCount];
		
		//score and scoreCount
		CCLabelTTF *scoreLabel=[CCLabelTTF labelWithString:@"score:" fontName:@"ArialHebrew" fontSize:20];
		scoreLabel.position=ccp(winSize.width-100,winSize.height-20);
		
		scoreCount=[CCLabelBMFont labelWithString:@"0" fntFile:@"font01.fnt"];
		scoreCount.position=ccp(winSize.width-40,winSize.height-18);
		
		[self addChild:scoreLabel];
		[self addChild:scoreCount];
		
		//loaded the paddle and add it to window  
		gamePaddle=[Paddle node];
		[self addChild:gamePaddle];
		
		//loaded the ball and add it to window
		movingBall=[MovingBall node];
		[self addChild:movingBall];
		
		//loaded the brick and add it to window
		bricks=[Bricks node];
		CCLOG(@"!%d",level);
		[bricks initWithBricks:level];
		[self addChild:bricks];
		
		
		//setting goBack label in order to go back main Menu
		CCLabelBMFont *goBackLabel=[CCLabelBMFont labelWithString:@"Menu" fntFile:@"font01.fnt" ];
		CCMenuItemLabel *goBack=[CCMenuItemLabel itemWithLabel:goBackLabel target:self selector:@selector(goBack:)];
		
		CCMenu *mn=[CCMenu menuWithItems:goBack,nil];
		[mn alignItemsInRows:
		 [NSNumber numberWithUnsignedInt:1],
		 nil];
		
		[self addChild:mn];
		 mn.position=ccp(winSize.width-70 ,20);
		
		[self schedule:@selector(gameLoop:)];
	}
	return self;
}

-(void) gameStartAnimation
{
	
	CGSize winSize=[[CCDirector sharedDirector]winSize];
	
	gameStartLabel=[CCLabelTTF labelWithString:@"Game Start" fontName:@"ArialHebrew" fontSize:16];
	
	[gameStartLabel setPosition:ccp(winSize.width/2,winSize.height/2)];
	
	[self addChild:gameStartLabel];
//	
//	id labelAction=[CCSpawn actions:
//					[CCScaleBy actionWithDuration:2.0f scale:4],
//					[CCFadeOut actionWithDuration:2.0f],
//					nil];
	
		[gameStartLabel runAction:[CCFadeOut actionWithDuration:2.0f]];
}

-(void) gameLoop:(ccTime)dt
{
	//[movingBall pauseBallMoving];
	
	CGSize winSize=[[CCDirector sharedDirector]winSize];
	
	id labelAction=[CCSpawn actions:
					[CCScaleBy actionWithDuration:2.0f scale:4],
					[CCFadeOut actionWithDuration:2.0f],
					nil];

	//if (gameIsBegin) 
//	{
//		[movingBall resumeBallMoving];
//	}
	
	[gamePaddle paddleHitBall:movingBall];
	
	if (!movingBall.gameState&&lifes>=0) 
	{
		lifes-=1;
		
		if (lifes!=-1) {
			
		[self setLives];
			
		movingBall.gameState=TRUE;//解决由于定时器循环时间过快导致不符合游戏常理的问题;
		
		//add test to window－－BallOutOfBounds
		
		CCLabelTTF *gamePauseLabel=[CCLabelTTF labelWithString:@"Ball Out Of Bounds" fontName:@"ArialHebrew" fontSize:16];
		
		[gamePauseLabel setPosition:ccp(winSize.width/2,winSize.height/2-100)];
		
		[self addChild:gamePauseLabel];
		
		[gamePauseLabel runAction:labelAction];
		
		gameState=YES;
			
		}
		else 
		{
			gameOver=YES;
		}
	}
	
	if ([bricks removeBrick:movingBall]) 
	{
		score+=10;
		[self setScore];
	}
	
	if ([bricks bricksArrayIsEmety]) 
	{
		//add Test To Window--You Win
		
		CCLabelTTF *gameWinLabel=[CCLabelTTF labelWithString:@"You Win" fontName:@"ArialHebrew" fontSize:16];
		
		[gameWinLabel setPosition:ccp(winSize.width/2,winSize.height/2-100)];
		
		[self addChild:gameWinLabel];
		
		[gameWinLabel runAction:labelAction];
		
		[movingBall pauseBallMoving];
		[self pauseSchedulerAndActions];
		
		[self showWinExplosion];
		
		gameState=YES;
	}
	
	if (gameOver) 
	{
		lifes=3;
		score=0;
		
		[self setLives];
		[self setScore];
		
		//add Test To Window--Game Over
		CCLabelTTF *gameOverLabel=[CCLabelTTF labelWithString:@"Game Over" fontName:@"ArialHebrew" fontSize:16];
		
		[gameOverLabel setPosition:ccp(winSize.width/2,winSize.height/2-100)];
		
		[self addChild:gameOverLabel];
		
		[gameOverLabel runAction:labelAction];
		
		[movingBall pauseBallMoving];
		[self pauseSchedulerAndActions];
		
		gameState=YES;
		
	}
}


-(void) ccTouchesEnded:(NSSet *) touches withEvent:(UIEvent *) event
{
	if (gameIsBegin) {
		
		if (gameState) {
			
			CGSize winSize=[[CCDirector sharedDirector]winSize];
			
			if ([bricks bricksArrayIsEmety]||gameOver) 
			{
				[self resumeSchedulerAndActions];
				[bricks initWithBricks:level];
				
				if (gameOver) 
				{
					movingBall.gameState=YES;
					gameOver=NO;
				}
			}
			
			movingBall.ball.position=ccp(winSize.width/2,winSize.height/2);
			movingBall.speedX=2*movingBall.level;
			movingBall.speedY=-2*movingBall.level;
			
			[movingBall resumeBallMoving];
			
			gameState=NO;
			
		}

	}
	else 
	{
		gameIsBegin=YES;
	}

}

-(void) goBack:(id)sender
{
	//CCScene *sc=[CCScene node];
	//[sc addChild:[HelloWorldLayer node]];
	[[CCDirector sharedDirector] popScene];
	//[[CCDirector sharedDirector] pushScene:[CCTransitionFlipAngular transitionWithDuration:1.0f scene:[HelloWorldLayer scene]]];
	
}

-(void) setLives
{
	NSString *liveString=[NSString stringWithFormat:@"%d",lifes];
	[liveCount setString:liveString];
}

-(void) setScore
{
	NSString *scoreString=[NSString stringWithFormat:@"%d",score];
	[scoreCount setString:scoreString];
}

-(void) showWinExplosion
{
	CGSize winSize=[[CCDirector sharedDirector]winSize];
	
	CCParticleSystem *winExplosion=[CCParticleSystemQuad particleWithFile:@"winAnimation.plist"];
	winExplosion.autoRemoveOnFinish=YES;
	winExplosion.position=ccp(winSize.width/2,winSize.height/2);
	
	[self addChild:winExplosion z:1];
}

-(void) dealloc
{
	[super dealloc];
}

@end
