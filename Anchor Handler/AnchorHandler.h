//
//  AnchorHandler.h
//  Anchor Handler
//
//  Created by Claire Wright on 08/02/2014.
//  Copyright (c) 2014 Brian. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Anchor.h"

typedef enum OperatingModeTypes {
    kHoldStationOperationMode,
    kTransitOperationMode,
} OperatingMode;

typedef enum ActivityModeType   {
    kStandbyActivityMode,
    kRecoverAnchorActivityMode,
    kDeployAnchorMode,
    kAnchorDeckedMode
} ActivityMode;

@interface AnchorHandler : SKSpriteNode



@property (nonatomic) OperatingMode operatingMode;             // holdstation, move to point, transittopoint
@property (nonatomic) ActivityMode activityMode;      // recover anchor, move anchor, standby
@property (nonatomic) Anchor *targetAnchor;         // used with operating mode
@property CGPoint dpHoldingPosition;
@property float maxThrustForce;
@property float draft;

-(id)initWithImageNamed:(NSString *)name position: (CGPoint) position;
-(id)initWithColor:(UIColor *)color size:(CGSize)size position:(CGPoint) position;

-(void)update:(CFTimeInterval)currentTime;
-(void)didSimulatePhysics;
-(void)didEvaluateActions;

-(void) transitToPoint: (CGPoint) point;
-(void) holdStationAtPoint;

-(BOOL) recoverAnchor: (Anchor *) anchor;


@end

