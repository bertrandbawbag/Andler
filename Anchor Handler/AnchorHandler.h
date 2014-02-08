//
//  AnchorHandler.h
//  Anchor Handler
//
//  Created by Claire Wright on 08/02/2014.
//  Copyright (c) 2014 Brian. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>


@interface AnchorHandler : SKSpriteNode

@property (nonatomic) NSString *dpMode;
@property CGPoint dpHoldingMode;
@property float maxThrustForce;

-(id)initWithColor:(UIColor *)color size:(CGSize)size position:(CGPoint) position;
-(void)update:(CFTimeInterval)currentTime;
-(void)didSimulatePhysics;
-(void)didEvaluateActions;

-(void) transitToPoint: (CGPoint) point;
-(void) holdStationAtPoint: (CGPoint) point;


@end

