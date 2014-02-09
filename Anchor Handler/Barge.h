//
//  Barge.h
//  Spring
//
//  Created by Claire Wright on 26/01/2014.
//  Copyright (c) 2014 Claire Wright. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "AnchorAssembly.h"

@interface Barge : SKNode

@property (nonatomic, strong) NSMutableDictionary *anchorAssemblies;
@property (nonatomic, strong) SKSpriteNode *hull;

-(id) init;
-(void) setUpAnchorPattern;
-(void) update:(CFTimeInterval)currentTime;
-(void) didEvaluateActions;
-(void) didSimulatePhysics;


@end
