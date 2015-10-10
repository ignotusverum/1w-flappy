//
//  RCGMainScene.m
//  Flappy
//
//  Created by Vlad Zagorodnyuk on 10/10/15.
//  Copyright © 2015 Apportable. All rights reserved.
//

#import "RCGMainScene.h"

@interface RCGMainScene ()

@property (nonatomic, weak) CCSprite * heroSprite;
@property (nonatomic, weak) CCPhysicsNode * mainPhysicsNode;

@end

@implementation RCGMainScene


- (void) update:(CCTime)delta
{
    self.heroSprite.position = ccp(self.heroSprite.position.x + delta * RCGScrollSpeed, self.heroSprite.position.y);
    self.mainPhysicsNode.position = ccp(self.mainPhysicsNode.position.x - delta * RCGScrollSpeed, self.mainPhysicsNode.position.y);
}


@end
