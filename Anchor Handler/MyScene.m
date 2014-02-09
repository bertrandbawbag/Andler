//
//  MyScene.m
//  Spring
//
//  Created by Claire Wright on 17/01/2014.
//  Copyright (c) 2014 Claire Wright. All rights reserved.
//

#import "MyScene.h"
#import "WindArrow.h"
#import "Barge.h"
#import "AnchorHandler.h"



@implementation MyScene
{

    WindArrow *_windArrow;
    Barge* _barge;
    AnchorHandler *_anchorHandler;
    
    BOOL _anchorHandlerSelected;
    
}


-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.physicsWorld.gravity = CGVectorMake(0.1, 0.1);
        self.backgroundColor = [SKColor whiteColor];
 
    }

    
    return self;
}

-(void)didMoveToView:(SKView *)view
{
    [self addWindArrow];
    _barge = [[Barge alloc] init];
    [self addChild:_barge];
    [_barge setUpAnchorPattern];
    
    _anchorHandler = [[AnchorHandler alloc] initWithImageNamed:@"AnchorHandler" position:CGPointMake(500, 450)];
    [self addChild:_anchorHandler];

}

-(void) addWindArrow
{
    _windArrow = [WindArrow spriteNodeWithImageNamed:@"Dark_Green_Arrow_Up"];
    _windArrow.position = CGPointMake(CGRectGetMinX(self.scene.frame) + 50, CGRectGetMaxY(self.scene.frame) - 100);
    _windArrow.xScale = 0.1;
    _windArrow.yScale = 0.1;
    
    [self addChild:_windArrow];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        
        CGPoint location = [touch locationInNode:self];
        SKNode *node = [self nodeAtPoint:location];
        
        if ([node isKindOfClass:[Anchor class]]) {
            Anchor *anchor = (Anchor *)node;
            anchor.physicsBody.dynamic = !(anchor.physicsBody.dynamic);
            anchor.color = [SKColor redColor];
            anchor.colorBlendFactor = 0.5;
            
        }
        
        if ([node isKindOfClass:[AnchorHandler class]]) {
            if (_anchorHandlerSelected) {
                _anchorHandler.colorBlendFactor = 0.0;
                _anchorHandlerSelected = NO;
            } else{
                _anchorHandler.color = [SKColor purpleColor];
                _anchorHandler.colorBlendFactor = 0.3;
                _anchorHandlerSelected = YES;
            }
        }
        
        if ([node isKindOfClass:[SKScene class]]) {
            if (_anchorHandlerSelected) {
                _anchorHandlerSelected = NO;
                _anchorHandler.colorBlendFactor = 0.3;
                _anchorHandler.dpHoldingPosition = location;
                _anchorHandler.dpMode = @"holdStation";
            }
        }
    }
}

-(void)update:(CFTimeInterval)currentTime {

    _windArrow.zRotation = [_windArrow windArrowAngleForVector:self.physicsWorld.gravity];
    [_barge update:currentTime];
    [_anchorHandler update:currentTime];
}

-(void)didSimulatePhysics
{
    [_barge didSimulatePhysics];
}

-(void)didEvaluateActions
{
    [_barge didEvaluateActions];
    [_anchorHandler didEvaluateActions];
}

@end

