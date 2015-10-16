//
//  RCGGoalNode.m
//  Flappy
//
//  Created by Vlad Zagorodnyuk on 10/11/15.
//  Copyright © 2015 Apportable. All rights reserved.
//

#import "RCGGoalNode.h"

@implementation RCGGoalNode


#pragma mark - Node init logic


- (void)didLoadFromCCB
{
    self.physicsBody.collisionType = @"RCGGoal";
    self.physicsBody.sensor = YES;
}


@end
