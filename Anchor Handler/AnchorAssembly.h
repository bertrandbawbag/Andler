//
//  AnchorAssembly.h
//  Spring
//
//  Created by Claire Wright on 21/01/2014.
//  Copyright (c) 2014 Claire Wright. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Winch.h"
#import "AnchorWire.h"
#import "Anchor.h"



@interface AnchorAssembly : SKNode

@property (nonatomic, strong) Winch *winch;
@property (nonatomic, strong) AnchorWire *wire;
@property (nonatomic, strong) Anchor *anchor;


-(id)initWithWinchPosition: (CGPoint) winchPosition andAnchorPosition: (CGPoint) anchorPosition;
-(void)update:(CFTimeInterval)currentTime;
-(void)didSimulatePhysics;
-(void)didEvaluateActions;

@end
