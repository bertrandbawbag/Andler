//
//  AnchorWire.m
//  Spring
//
//  Created by Claire Wright on 19/01/2014.
//  Copyright (c) 2014 Claire Wright. All rights reserved.
//

#import "AnchorWire.h"



@implementation AnchorWire
{
    BOOL _anchorMoved;
    BOOL _winchMoved;
    
    CGPoint _lastWinchPosition;
    CGPoint _lastAnchorPosition;
    
}

-(id)init
{
    if (self = [super init]) {
        
    }
    
    return self;
}

- (id) initWithAnchor: (Anchor *) anchor andWinch: (Winch *) winch
{
    if (self = [super init]) {
        self.winchEndNode = winch;
        self.anchorEndNode = anchor;
        self.strokeColor = [SKColor blackColor];
        [self redrawWirePath];
        
        // testing only
        self.relaxedLength = 200.0f;
        self.k = 0.5f;
        self.c = 5.0f;
    }
    
    
    return self;
}

#pragma mark Run Loop

-(void)update:(CFTimeInterval)currentTime
{
    
    
}


-(void)didEvaluateActions
{
    [self calculateWireLength];
    [self calculateForce];
    

}

-(void) didSimulatePhysics
{

    [self redrawWirePath];
    
}

#pragma mark Calculations

-(void) redrawWirePath
{
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, Nil, self.winchEndNode.position.x, self.winchEndNode.position.y);
    CGPathAddLineToPoint(path, Nil, self.anchorEndNode.position.x, self.anchorEndNode.position.y);
    self.path = path;
    
}

-(void) calculateWireLength
{
        self.currentLength = sqrtf(powf(self.anchorEndNode.position.x - self.winchEndNode.position.x, 2) + powf(self.anchorEndNode.position.y - self.winchEndNode.position.y, 2));
}

-(void) calculateForce
{
    float forceFactor = self.k * (self.currentLength - self.relaxedLength);
    
    if (forceFactor < 0) {
        forceFactor = 0;
    }
    
    CGVector wireVector = CGVectorMake(self.anchorEndNode.position.x - self.winchEndNode.position.x, self.anchorEndNode.position.y - self.winchEndNode.position.y);
    
    CGVector normalisedWireVector = CGVectorMake(wireVector.dx / self.currentLength, wireVector.dy / self.currentLength);
    
    CGVector force = CGVectorMake(normalisedWireVector.dx * forceFactor, normalisedWireVector.dy * forceFactor);
    
    self.winchEndNode.force = force;
    self.anchorEndNode.force = CGVectorMake(-force.dx, -force.dy);
    
}

@end
