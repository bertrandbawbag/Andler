//
//  AnchorWire.h
//  Spring
//
//  Created by Claire Wright on 19/01/2014.
//  Copyright (c) 2014 Claire Wright. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Winch.h"
#import "Anchor.h"

@interface AnchorWire : SKShapeNode

@property (nonatomic) float currentLength;
@property (nonatomic) float relaxedLength;
@property (nonatomic) float MBL;
@property (nonatomic) BOOL intact;
@property (nonatomic) float wear;
@property (nonatomic) float k; // spring constant
@property (nonatomic) float c; // spring damping

@property (nonatomic, strong) Anchor *anchorEndNode;
@property (nonatomic, strong) Winch *winchEndNode;


- (id) initWithAnchor: (Anchor *) anchor andWinch: (Winch *) winch;
- (void) didSimulatePhysics;
- (void)didEvaluateActions;
- (void)update:(CFTimeInterval)currentTime;




@end
