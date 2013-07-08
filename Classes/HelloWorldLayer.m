//
//  HelloWorldLayer.m
//  Cocos2D_BlockBreak
//
//  Created by 何遵祖 on 11-10-22.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// HelloWorldLayer implementation
@implementation HelloWorldLayer

#define LABEL_SCALE 1
 
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super initWithColor:ccc4(180,180,180,200)])) {
		
		//Windows Size
		CGSize winSize=[[CCDirector sharedDirector] winSize];
		
		CCLabelTTF *version=[CCLabelTTF labelWithString:@"Cocos2D Version:1.0.1" fontName:@"Marker Felt" fontSize:25];
		version.position=ccp(winSize.width-120,50);
		[self addChild:version];
		
		//Title
		CCLabelTTF *titleLabel=[CCLabelTTF labelWithString:@"BlockBreak Game" fontName:@"Marker Felt" fontSize:30];
		CCMenuItemLabel *title=[CCMenuItemLabel itemWithLabel:titleLabel target:nil selector:nil];
		title.position=ccp(winSize.width/2,winSize.height/2+150);
		
		//GameStart
		CCLabelBMFont *gameStartLabel=[CCLabelBMFont labelWithString:@"Start Game" fntFile:@"font01.fnt"];
		CCMenuItemLabel *gameStart=[CCMenuItemLabel itemWithLabel:gameStartLabel target:self selector:@selector(gameStart:)];
		gameStart.scale=LABEL_SCALE;
		
		//MainMenu
		CCMenu *mn=[CCMenu menuWithItems:title,gameStart,nil];
		[mn alignItemsInColumns:
		[NSNumber numberWithUnsignedInt:1],
		[NSNumber numberWithUnsignedInt:1],
		 nil];
		
		[mn alignItemsVerticallyWithPadding:190];
		
		[self addChild:mn z:1 tag:1];
		mn.position=ccp(winSize.width/2,winSize.height/2+30);
		
		//add picture
		CCSprite *menuPic=[CCSprite spriteWithFile:@"mainMenuPic.png"];
		[self addChild:menuPic];
		menuPic.position=ccp(mn.position.x,mn.position.y);
		menuPic.scale=0.8;
		
		[self changeBackgroundColor];
	}
	
	return self;
}

-(void) gameStart:(id) sender
{
	CCScene *sc=[CCScene node];
	[sc addChild:[GameStartLayer node]];
	[[CCDirector sharedDirector] pushScene:[CCTransitionRotoZoom transitionWithDuration:2.2f scene:sc]];

}

-(void) changeBackgroundColor
{
	//改变背景颜色
	CCTintTo *tint1=[CCTintTo actionWithDuration:3 red:255 green:0 blue:0];
	CCCallFunc *func=[CCCallFunc actionWithTarget:self selector:@selector(onCallFunc)];
	
	CCTintTo *tint2=[CCTintTo actionWithDuration:3 red:0 green:0 blue:255];
	CCCallFuncN *funcN=[CCCallFuncN actionWithTarget:self selector:@selector(onCallFuncN:)];
	
	CCTintTo *tint3=[CCTintTo actionWithDuration:3 red:100 green:255 blue:0];
	
	CCSequence *sequence=[CCSequence actions:tint1,func,tint2,funcN,tint3,nil];
	[self runAction:[CCRepeatForever actionWithAction:sequence]];
}

-(void) onCallFunc
{
	CCLOG(@"end of tint1,CallFunc has begin");
}

-(void) onCallFuncN:(id) sender
{
	CCLOG(@"end of tint2,CallFuncN has begin sender:%@",sender);
}


// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
