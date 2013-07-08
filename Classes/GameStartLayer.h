//
//  GameStartLayer.h
//  Cocos2D_BlockBreak
//
//  Created by 何遵祖 on 11-10-22.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "MovingBall.h"
#import "Bricks.h"
#import "BackgroundLayer.h"
#import "HelloWorldLayer.h"

@class Paddle;

@interface GameStartLayer : CCLayerColor 
{
	MovingBall *movingBall;
	Bricks *bricks;
	Paddle *gamePaddle;
	
	int score;
	int lifes;
	
	CCLabelTTF *gameStartLabel;
	
	CCLabelBMFont *scoreCount;
	CCLabelBMFont *liveCount;
	
	BOOL gameState;
	BOOL gameOver;
	BOOL gameIsBegin;
	
	NSString *klivesKey;
	NSString *kScoreKey;
	
	int level;
}

@property (assign) int score;
@property (assign) int lifes;
@property (assign) BOOL gameState;
@property (assign) int level;

-(void) gameStartAnimation;
-(void) setLives;
-(void) setScore;
-(void) showWinExplosion;

@end
