//
//  Anchor.m
//  Anchor Handler
//
//  Created by Claire Wright on 09/02/2014.
//  Copyright (c) 2014 Brian. All rights reserved.
//

#import "Anchor.h"

@implementation Anchor


- (void) didSimulatePhysics
{

}

- (void)didEvaluateActions
{
    [self.physicsBody applyImpulse:self.force];

}

- (void)update:(CFTimeInterval)currentTime
{
    
}

-(id) initWithPosition:(CGPoint)position
{
    if (self = [super init]) {
        
        self.position = position;
        self.texture = [SKTexture textureWithImage:[UIImage imageNamed:@"anchor"]];

        [self setUpPhysics];
    }
    return self;
}

-(void) setUpPhysics
{
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    self.physicsBody.dynamic = NO;
    self.physicsBody.mass = 1.0;
    self.physicsBody.affectedByGravity = NO;
}

@end
