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
    if (self = [super initWithImageNamed:@"anchor"]) {
        
        self.position = position;

        [self setUpPhysics];
    }
    return self;
}

-(void) setUpPhysics
{
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
    self.physicsBody.dynamic = NO;
    self.physicsBody.mass = 20.0;
    self.physicsBody.affectedByGravity = NO;
}

@end
