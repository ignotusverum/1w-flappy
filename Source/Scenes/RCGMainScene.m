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


#pragma - Scene init logic


- (void) didLoadFromCCB
{
    self.userInteractionEnabled = YES;
    
    self.arrayOfGroundNodes = @[self.ground1Node, self.ground2Node];
}


#pragma - Scene update logic


- (void) update:(CCTime)delta
{
    self.heroSprite.position = ccp(self.heroSprite.position.x + delta * RCGScrollSpeed, self.heroSprite.position.y);
    self.mainPhysicsNode.position = ccp(self.mainPhysicsNode.position.x - delta * RCGScrollSpeed, self.mainPhysicsNode.position.y);
    
    [self updateGroundUI];
    
    [self updateHeroVelocity];
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


#pragma mark - User interactions


- (void) touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    [self.heroSprite.physicsBody applyImpulse:ccp(0, 400.0)];
}


#pragma mark - Utility


- (void) updateHeroVelocity
{
    CGFloat speedVelocity = clampf(self.heroSprite.physicsBody.velocity.y, -1 * MAXFLOAT, 200.0f);
    self.heroSprite.physicsBody.velocity = ccp(0, speedVelocity);
}


@end
