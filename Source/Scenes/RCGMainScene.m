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

@end

@implementation RCGMainScene


- (void) update:(CCTime)delta
{
    self.heroSprite.position = ccp(self.heroSprite.position.x + delta * RCGScrollSpeed, self.heroSprite.position.y);
}


@end