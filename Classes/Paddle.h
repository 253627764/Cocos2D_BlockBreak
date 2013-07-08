//
//  Paddle.h
//  Cocos2D_BlockBreak
//
//  Created by 何遵祖 on 11-10-23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

/*本类为Paddle类，也就是挡板类，主要负责的功能就是图片的加载还有就是挡板的移动，挡板移动的主要原理就是触碰屏幕进行移动.*/

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "HelloWorldLayer.h"

@interface Paddle : CCLayer {
	CCSprite *paddle;
}

-(void) paddleHitBall:(MovingBall *) playingBall;

@end
