//
//  AnchorHandler.m
//  Anchor Handler
//
//  Created by Claire Wright on 08/02/2014.
//  Copyright (c) 2014 Brian. All rights reserved.
//

#import "AnchorHandler.h"

@implementation AnchorHandler

-(id)initWithImageNamed:(NSString *)name position: (CGPoint) position;
{
    if ([super initWithImageNamed:name]) {
        self.position = position;
        self.xScale = 0.4;
        self.yScale = 0.4;
        self.dpMode = @"holdStation";
        self.dpHoldingPosition = self.position;
        [self setUpPhysics];

    }
    return self;
}

-(id)initWithColor:(UIColor *)color size:(CGSize)size position:(CGPoint) position
{
    if ([super initWithColor:color size:size]) {
        self.position = position;
        [self setUpPhysics];
    }
    return self;
}
-(void)update:(CFTimeInterval)currentTime
{
    if ([self.dpMode isEqualToString:@"holdStation"]) {
        [self holdStationAtPoint];
    }
}
-(void)didSimulatePhysics
{
    
}
-(void)didEvaluateActions
{
    
}

-(void) transitToPoint: (CGPoint) point
{
    
}
-(void) holdStationAtPoint
{
    // applies force in the opposite direction that the vessel is drifting away from dpHoldingPosition
    CGVector offset = CGVectorMake(self.dpHoldingPosition.x - self.position.x, self.dpHoldingPosition.y - self.position.y);
    [self.physicsBody applyForce:offset];
}

-(void) setUpPhysics
{
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

@end
