//
//  RCGMainScene.m
//  Flappy
//
//  Created by Vlad Zagorodnyuk on 10/10/15.
//  Copyright © 2015 Apportable. All rights reserved.
//

#import "RCGMainScene.h"

// Nodes
#import "RCGObstacle.h"

@interface RCGMainScene () <CCPhysicsCollisionDelegate>


@property (nonatomic, weak) CCSprite * heroSprite;
@property (nonatomic, weak) CCPhysicsNode * mainPhysicsNode;

// Ground logic
@property (nonatomic, weak) CCNode * ground1Node;
@property (nonatomic, weak) CCNode * ground2Node;
@property (nonatomic, strong) NSArray * groundNodesArray;

// Interaction logic
@property (nonatomic, assign) NSTimeInterval timeSinceTouch;

// Obstacles logic
@property (nonatomic, strong) NSMutableArray * obstacleNodesArray;

// Buttons
@property (nonatomic, strong) CCButton * restartButton;

// Game Logic
@property (nonatomic, assign) BOOL isGameOver;
@property (nonatomic, assign) CGFloat currentScrollSpeed;

@end

@implementation RCGMainScene


#pragma mark - Scene init logic


- (void) didLoadFromCCB
{
    self.userInteractionEnabled = YES;
    self.mainPhysicsNode.collisionDelegate = self;
    
    self.groundNodesArray = @[self.ground1Node, self.ground2Node];
 
    self.obstacleNodesArray = [NSMutableArray new];
    [self spawnNewObstacles];
    [self spawnNewObstacles];
    [self spawnNewObstacles];
    
    [self drawingOrder];
}


- (void) drawingOrder
{
    for (CCNode * groundNode in self.groundNodesArray) {
        groundNode.zOrder = RCGDrawingOrderGround;
        groundNode.physicsBody.collisionType = @"RCGLevel";
    }
    
    self.heroSprite.zOrder = RCGDrawingOrderHero;
    self.heroSprite.physicsBody.collisionType = @"RCGHero";
    
    self.currentScrollSpeed = RCGScrollSpeed;
}


#pragma mark - Scene update logic


- (void) update:(CCTime)delta
{
    self.heroSprite.position = ccp(self.heroSprite.position.x + delta * self.currentScrollSpeed, self.heroSprite.position.y);
    self.mainPhysicsNode.position = ccp(self.mainPhysicsNode.position.x - delta * self.currentScrollSpeed, self.mainPhysicsNode.position.y);
    
    [self updateGroundUI];
    
    [self updateHeroVelocity];
    [self updateHeroRotationWithDelta:delta];
}


- (void) updateGroundUI
{
    for (CCNode * groundNode in self.groundNodesArray) {
        CGPoint groundWorldPosition = [self.mainPhysicsNode convertToWorldSpace:groundNode.position];
        
        CGPoint groundScreenPosition = [self convertToNodeSpace:groundWorldPosition];
        
        if (groundScreenPosition.x <= (-1 * groundNode.contentSize.width)) {
            groundNode.position = ccp(groundNode.position.x + 2.0f * groundNode.contentSize.width, groundNode.position.y);
        }
    }
}


#pragma mark - Game logic


- (void) gameOver
{
    if (!self.isGameOver) {
        
        self.currentScrollSpeed = 0;
        self.isGameOver = YES;
        
        self.restartButton.visible = YES;
        
        [self.heroSprite stopAllActions];
        self.heroSprite.rotation = 90.0f;
        self.heroSprite.physicsBody.allowsRotation = NO;
        
        CCActionMoveBy * moveBy = [CCActionMoveBy actionWithDuration:0.2f position:ccp(-2, 2)];
        
        CCActionInterval * reverseMovement = [moveBy reverse];
        
        CCActionSequence * shakeSequence = [CCActionSequence actionWithArray:@[moveBy, reverseMovement]];
        
        CCActionEaseBounce * bounce = [CCActionEaseBounce actionWithAction:shakeSequence];
        
        [self runAction:bounce];
    }
}


#pragma mark - Obstacles logic


- (void) spawnNewObstacles
{
    CCNode * previousObstacle = [self.obstacleNodesArray lastObject];
    CGFloat previousObstaclePos = previousObstacle.position.x;
    
    if (!previousObstacle) {
        previousObstaclePos = RCGFirstObstaclePos;
    }
    
    RCGObstacle * obstacle = (RCGObstacle *)[CCBReader load:@"RCGObstacle"];
    
    obstacle.zOrder = RCGDrawingOrderObstacle;
    obstacle.position = ccp(previousObstaclePos + RCGDistanceBetweenObstacles, 0);
    
    [obstacle setupRandomPosition];
    
    [self.mainPhysicsNode addChild:obstacle];
    [self.obstacleNodesArray addObject:obstacle];
}


#pragma mark - User interactions


- (void) touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    if (!self.isGameOver) {
        [self.heroSprite.physicsBody applyImpulse:ccp(0, 400.0f)];
        [self.heroSprite.physicsBody applyAngularImpulse:1000.0f];

        self.timeSinceTouch = 0.0f;
    }
}


#pragma mark - Actions


- (void) restartButtonPressed
{
    CCScene * mainScene = [CCBReader loadAsScene:@"RCGMainScene"];
    [[CCDirector sharedDirector] replaceScene:mainScene];
}


#pragma mark - Utility


- (void) updateHeroVelocity
{
    CGFloat speedVelocity = clampf(self.heroSprite.physicsBody.velocity.y, -1 * MAXFLOAT, 200.0f);
    self.heroSprite.physicsBody.velocity = ccp(0.0f, speedVelocity);
}


- (void) updateHeroRotationWithDelta:(CCTime)delta
{
    self.timeSinceTouch += delta;
    self.heroSprite.rotation = clampf(self.heroSprite.rotation, -30.0f, 90.0f);
    
    if (self.heroSprite.physicsBody.allowsRotation) {
        CGFloat angularVelocity = clampf(self.heroSprite.physicsBody.angularVelocity, -2.0f, 1.0f);
        
        self.heroSprite.physicsBody.angularVelocity = angularVelocity;
    }
    
    if (self.timeSinceTouch > 0.5f) {
        [self.heroSprite.physicsBody applyAngularImpulse:-4000.f * delta];
    }
}


#pragma mark - Collision delegate


- (BOOL) ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair RCGHero:(CCNode *)RCGHero RCGLevel:(CCNode *)RCGLevel
{
    [self gameOver];
    return TRUE;
}



@end
