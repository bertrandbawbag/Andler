//
//  AnchorHandler.m
//  Anchor Handler
//
//  Created by Claire Wright on 08/02/2014.
//  Copyright (c) 2014 Brian. All rights reserved.
//

#import "AnchorHandler.h"

@implementation AnchorHandler

-(id)initWithColor:(UIColor *)color size:(CGSize)size position:(CGPoint) position
{
    if ([super initWithColor:color size:size]) {
        [self setUpPhysics];
    }
    return self;
}
-(void)update:(CFTimeInterval)currentTime
{
    
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
-(void) holdStationAtPoint: (CGPoint) point
{
    
}

-(void) setUpPhysics
{
    
}

@end
