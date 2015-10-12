//
//  RCGConstants.h
//  Flappy
//
//  Created by Vlad Zagorodnyuk on 10/10/15.
//  Copyright © 2015 Apportable. All rights reserved.
//

#define ARC4RANDOM_MAX      0x100000000

extern CGFloat const RCGScrollSpeed;

extern CGFloat const RCGFirstObstaclePos;
extern CGFloat const RCGDistanceBetweenObstacles;

// visibility on a 3,5-inch iPhone ends a 88 points and we want some meat
extern CGFloat const RCGMinimumYPositionTopPipe;

// visibility ends at 480 and we want some meat
extern CGFloat const RCGMaximumYPositionBottomPipe;

// distance between top and bottom pipe
extern CGFloat const RCGPipeDistance;

// calculate the end of the range of top pipe
extern CGFloat const RCGMaximumYPositionTopPipe;
