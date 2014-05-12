//
//  AnchorAssembly.m
//  Spring
//
//  Created by Claire Wright on 21/01/2014.
//  Copyright (c) 2014 Claire Wright. All rights reserved.
//

#import "AnchorAssembly.h"


@implementation AnchorAssembly

BOOL _anchorMoved;
BOOL _winchMoved;


CGPoint _lastWinchPosition;
CGPoint _lastAnchorPosition;



#pragma mark - Initialisation and Set Up
-(id)initWithWinchPosition: (CGPoint) position  {
    
    if (self = [super init]) {
        
        [self setUpWinch:position];
        [self setUpAnchor];
        [self setUpWire];
        
    }
    
    
    return self;
}


-(void) setUpWinch: (CGPoint) position
{
    self.winch = [[Winch alloc] initWithColor:[SKColor greenColor] size:CGSizeMake(10, 10) position:position];
    
    
    _lastWinchPosition = self.winch.position;
    [self addChild:self.winch];
}

- (void) setUpAnchor
{
    self.anchor = [[Anchor alloc] initWithPosition]:
    
    self.anchor.zPosition = self.winch.zPosition;
    

    
    _lastAnchorPosition = self.anchor.position;
    [self addChild:self.anchor];
}

-(void) setUpWire
{
    self.wire = [[AnchorWire alloc] initWithAnchor:self.anchor andWinch:self.winch];
    self.wire.zPosition = self.anchor.zPosition - 1;
    
    [self addChild:self.wire];
    
    // testing only

}

-(void)update:(CFTimeInterval)currentTime
{

    
}


-(void)didEvaluateActions
{
    
    [self.wire didEvaluateActions];
    [self.winch didEvaluateActions];
    [self.anchor didEvaluateActions];
}

-(void) didSimulatePhysics
{

    [self.wire didSimulatePhysics];
    [self.winch didSimulatePhysics];
    [self.anchor didSimulatePhysics];
}



-(void) calculateForces
{
    
}
@end

