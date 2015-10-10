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

@property (nonatomic, weak) CCNode * ground1Node;
@property (nonatomic, weak) CCNode * ground2Node;
@property (nonatomic, strong) NSArray * arrayOfGroundNodes;

@end

@implementation RCGMainScene


- (void) didLoadFromCCB
{
    self.arrayOfGroundNodes = @[self.ground1Node, self.ground2Node];
}


- (void) update:(CCTime)delta
{
    self.heroSprite.position = ccp(self.heroSprite.position.x + delta * RCGScrollSpeed, self.heroSprite.position.y);
    self.mainPhysicsNode.position = ccp(self.mainPhysicsNode.position.x - delta * RCGScrollSpeed, self.mainPhysicsNode.position.y);
    
    [self updateGroundUI];
}


- (void) updateGroundUI
{
    for (CCNode * groundNode in self.arrayOfGroundNodes) {
        CGPoint groundWorldPosition = [self.mainPhysicsNode convertToWorldSpace:groundNode.position];
        
        CGPoint groundScreenPosition = [self convertToNodeSpace:groundWorldPosition];
        
        if (groundScreenPosition.x <= (-1 * groundNode.contentSize.width)) {
            groundNode.position = ccp(groundNode.position.x + 2 * groundNode.contentSize.width, groundNode.position.y);
        }
    }
}


@end
