//
//  Bricks.h
//  Cocos2D_BlockBreak
//
//  Created by studenth01 on 11-10-24.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "MovingBall.h"
#import "SimpleAudioEngine.h"

#define Bricks_Width 5
#define Bricks_Height 4

@interface Bricks : CCLayer {
	
	CCSprite *brick[Bricks_Width][Bricks_Height];
	NSString *brickType[4];
	NSMutableArray *bricks;
}

-(void) initWithBricks:(int) level;
-(BOOL) removeBrick:(MovingBall *) sprite;
-(BOOL) bricksArrayIsEmety;
-(void) showExplosion:(CGPoint) pos;

@end
