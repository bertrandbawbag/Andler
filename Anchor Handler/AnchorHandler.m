//
//  AnchorHandler.m
//  Anchor Handler
//
//  Created by Claire Wright on 08/02/2014.
//  Copyright (c) 2014 Brian. All rights reserved.
//

#import "AnchorHandler.h"

@implementation AnchorHandler
{
    CGMutablePathRef _pathToFollow;
}

-(id)initWithImageNamed:(NSString *)name position: (CGPoint) position;
{
    if ([super initWithImageNamed:name]) {
        self.position = position;
        self.xScale = 0.4;
        self.yScale = 0.4;
        self.dpMode = @"holdStation";
        self.dpHoldingPosition = self.position;

        self.maxThrustForce = 50;
        [self setUpPhysics];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationOfTouchReceived:) name:@"tapInScene" object:nil];

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
    
    if ([self.dpMode isEqualToString:@"transitToPoint"]) {
        [self transitToPoint:CGPointMake(500, 700)];
    }
    
    if ([self.operatingMode isEqualToString:@"recoverAnchor"]) {
        [self recoverAnchor:self.targetAnchor];
    }
    

    
}
-(void)didSimulatePhysics
{
    
}
-(void)didEvaluateActions
{
    
}
/**
 * Transit from one point to another. Vessel turns to face travel. Calculates complex route using Lee algorithm.
 * @param CGPoint point
 * @return void
 * @warning Uses max force to limit the total force applied to bring the vessel back
 */
-(void) transitToPoint: (CGPoint) point
{
// calculate route and draw invisible path to follow
    
    _pathToFollow = CGPathCreateMutable();
    CGPathMoveToPoint(_pathToFollow, nil,  self.position.x, self.position.y);
    CGPathAddLineToPoint(_pathToFollow, nil, point.x, point.y);
    
// rotate to path direction
// follow path
// hold position at end point
}

/**
 * DP function to keep the vessel on station. Applies force to bring the vessel back to the desired point
 * @param None
 * @return void
 * @warning Uses max force to limit the total force applied to bring the vessel back
 */
-(void) holdStationAtPoint
{
    // applies force in the opposite direction that the vessel is drifting away from dpHoldingPosition
    CGVector offset = CGVectorMake(self.dpHoldingPosition.x - self.position.x, self.dpHoldingPosition.y - self.position.y);
    if (fabsf(offset.dx)  > self.maxThrustForce ) {
        if (offset.dx < 0) {
            offset.dx = -self.maxThrustForce;
        }   else    {
            offset.dx = self.maxThrustForce;

        }
    }
    if (fabsf(offset.dy)  > self.maxThrustForce ) {
        if (offset.dy < 0) {
            offset.dy = -self.maxThrustForce;
        }   else    {
            offset.dy = self.maxThrustForce;
        }
    }
    
    [self.physicsBody applyImpulse:offset];
    [self rotateToDirection:CGVectorMake(0, -0.1)];
}

/**
 * Get vessel in position and get the anchor off the seabed
 * @param Anchor anchor
 * @return BOOL
 * @see transitToPoint
 */

-(BOOL) recoverAnchor:(Anchor *)anchor
{
    NSLog(@"%s %d %s %s", __FILE__, __LINE__, __PRETTY_FUNCTION__, __FUNCTION__);
    BOOL anchorOnDeck = false;
    
    // calculate pickup point
    // go to pickup point
    // rotate vessel
    // connect to anchor
    // increase force to hold
    
    return anchorOnDeck;
}

-(void) rotateToDirection: (CGVector) direction
{
    float angleToRotate = CGVectorScalarShortestAngleBetween(CGVectorAngleToVector(self.zRotation) , direction);
    float torqueToApply = angleToRotate;
    [self.physicsBody applyTorque:torqueToApply];
    
}



-(void) setUpPhysics
{
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
    self.physicsBody.linearDamping = 0.9;
    self.physicsBody.angularDamping = 0.9;
    self.physicsBody.mass = 100;
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

-(void) notificationOfTouchReceived: (NSNotification *) notification
{
    NSLog(@"tapInScene notification received in node type %@", [notification.object class]);
    
}

@end
