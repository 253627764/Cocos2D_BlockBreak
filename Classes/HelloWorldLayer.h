//
//  HelloWorldLayer.h
//  Cocos2D_BlockBreak
//
//  Created by 何遵祖 on 11-10-22.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "GameStartLayer.h"
//#import "GameStartLayer.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayerColor
{
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

-(void) changeBackgroundColor;

@end
