//
//  RCGObstacle.m
//  Flappy
//
//  Created by Vlad Zagorodnyuk on 10/11/15.
//  Copyright © 2015 Apportable. All rights reserved.
//

#import "RCGObstacle.h"

@interface RCGObstacle ()

@property (nonatomic, weak) CCNode * topObject;
@property (nonatomic, weak) CCNode * bottomObject;

@end

@implementation RCGObstacle

- (void) setupRandomPosition
{
    CGFloat randomFloat = ((double)arc4random() / ARC4RANDOM_MAX);
    CGFloat range = (RCGMaximumYPositionTopPipe - RCGMinimumYPositionTopPipe);
    
    self.topObject.position = ccp(self.topObject.position.x, RCGMinimumYPositionTopPipe + (randomFloat * range));
    self.bottomObject.position = ccp(self.bottomObject.position.x, self.topObject.position.y + RCGPipeDistance);
}

@end
