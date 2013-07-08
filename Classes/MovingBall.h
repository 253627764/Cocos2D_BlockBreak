//
//  MovingBall.h
//  Cocos2D_BlockBreak
//
//  Created by studenth01 on 11-10-24.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface MovingBall : CCLayer {
	CCSprite *ball;
	float speedX,speedY;
	int level;
	CGSize winSize;
	BOOL gameState;
}

@property (assign) CCSprite *ball;
@property (assign) float speedX,speedY;
@property (assign) int level;
@property (assign) BOOL gameState;

-(void) ballMoving:(ccTime) dt;
-(void) pauseBallMoving;
-(void) resumeBallMoving;















@end
