//
//  Bricks.m
//  Cocos2D_BlockBreak
//
//  Created by studenth01 on 11-10-24.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Bricks.h"

@implementation Bricks

-(id)init
{
	self=[super init];
	if (self) 
	{
		bricks=[[NSMutableArray alloc]init];
		[[SimpleAudioEngine sharedEngine]preloadEffect:@"gun.mp3"];
		
	}
	return self;
}

-(void) initWithBricks:(int) level
{
	
	int count=0;
	
	brickType[0]=@"bricktype1.png";
	brickType[1]=@"bricktype2.png";
	brickType[2]=@"bricktype3.png";
	brickType[3]=@"bricktype4.png";
	
	for(int i=0;i<Bricks_Height;i++)
	{
		for (int j=0; j<Bricks_Width; j++) 
		{
			brick[i][j]=[CCSprite spriteWithFile:brickType[count++ % 4]];
			[self addChild:brick[i][j] z:1 tag:1];
			[bricks addObject:brick[i][j]];
			brick[i][j].position=ccp(brick[i][j].contentSize.width*j+32,brick[i][j].contentSize.height*i+300);
		} 	
	}
}

-(BOOL) removeBrick:(MovingBall *) sprite
{
	
	CGRect spriteRect=CGRectMake(sprite.ball.position.x-(sprite.ball.contentSize.width/2), 
								 sprite.ball.position.y-(sprite.ball.contentSize.height/2), 
								 sprite.ball.contentSize.width, sprite.ball.contentSize.height);
	
	for(CCSprite *tempArray in bricks)
	{
		
		CGRect brickRect=CGRectMake(tempArray.position.x-(tempArray.contentSize.width/2), 
									tempArray.position.y-(tempArray.contentSize.height/2), 
									tempArray.contentSize.width, tempArray.contentSize.height);
		
		
		if (CGRectIntersectsRect(spriteRect, brickRect)) 
		{
			[[SimpleAudioEngine sharedEngine]playEffect:@"gun.mp3"];
			
			[self showExplosion:ccp(sprite.ball.position.x,sprite.ball.position.y)];			
			
			[bricks removeObject:tempArray];
			
			[tempArray runAction:[CCSpawn actions:
								  [CCFadeOut actionWithDuration:1.0f],
								  [CCScaleBy actionWithDuration:1.0f],
								  nil]];
			
			
			
			
			if (brickRect.origin.y==spriteRect.origin.y-14||brickRect.origin.y==spriteRect.origin.y+14) 
			{
				
				sprite.speedY=-sprite.speedY;
			}
			
			if(brickRect.origin.y-spriteRect.origin.y>0&&brickRect.origin.y-spriteRect.origin.y<14)
			{
				sprite.speedX=-sprite.speedX;
			}
			
			
		    return TRUE;
		}
	}

	return FALSE;
	
}

-(void) showExplosion:(CGPoint) pos
{
	CCParticleSystem *explosion=[CCParticleSystemQuad particleWithFile:@"fx-explosion.plist"];
	
	explosion.autoRemoveOnFinish=YES;
	explosion.position=pos;
	[self addChild:explosion z:1];
}

-(BOOL) bricksArrayIsEmety
{
	if ([bricks count]==0) 
	{
		return TRUE;
	}
	
	return FALSE;
}

-(void) dealloc
{
	[bricks release];
	[super dealloc];
}

@end
