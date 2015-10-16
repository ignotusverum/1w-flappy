//
//  RCGMainScene.h
//  Flappy
//
//  Created by Vlad Zagorodnyuk on 10/10/15.
//  Copyright © 2015 Apportable. All rights reserved.
//

#import "CCNode.h"

typedef NS_ENUM(NSInteger, RCGDrawingOrder) {
    RCGDrawingOrderObstacle,
    RCGDrawingOrderGround,
    RCGDrawingOrderHero
};

@interface RCGMainScene : CCNode

@end
