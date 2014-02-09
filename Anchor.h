//
//  Anchor.h
//  Anchor Handler
//
//  Created by Claire Wright on 09/02/2014.
//  Copyright (c) 2014 Brian. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Anchor : SKSpriteNode

@property CGVector force;

- (void) didSimulatePhysics;
- (void)didEvaluateActions;
- (void)update:(CFTimeInterval)currentTime;

@end
