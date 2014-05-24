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
#import "Weather.h"
#import "ANHButtonMenu.h"


@interface MyScene ()

@property (nonatomic, strong) SKNode *gameLayer;
@property (nonatomic, strong) SKNode *hudLayer;

@end

@implementation MyScene
{
    

    WindArrow *_windArrow;
    Barge* _barge;
    AnchorHandler *_anchorHandler;
    Weather *_weather;
    
    BOOL _anchorHandlerSelected;
    
}


-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.physicsWorld.gravity = CGVectorMake(0.0, -0.1);
        self.backgroundColor = [SKColor whiteColor];
        
        self.gameLayer = [SKNode node];
        self.hudLayer = [SKNode node];
        
        [self addChild:self.gameLayer];
        [self addChild:self.hudLayer];
    }

    
    return self;
}

-(void)didMoveToView:(SKView *)view
{
    [self addWindArrow];
    _barge = [[Barge alloc] init];
    [self.gameLayer addChild:_barge];
    [_barge setUpAnchorPattern];
    
    _anchorHandler = [[AnchorHandler alloc] initWithImageNamed:@"AnchorHandler" position:CGPointMake(500, 450)];
    [self.gameLayer addChild:_anchorHandler];
    
// TODO: Remove these lines when done testing
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"ButtonMenus" ofType:@"plist"];
    ANHButtonMenu *buttonMenu = [[ANHButtonMenu alloc] initWithContentsOfPList:plistPath];
    
    [self.hudLayer addChild:buttonMenu];

}
/**
 * Adds the arrow showing the wind direction
 * @param None
 * @param None
 * @return Void
 */
-(void) addWindArrow
{
    _windArrow = [WindArrow spriteNodeWithImageNamed:@"Dark_Green_Arrow_Up"];
    _windArrow.position = CGPointMake(CGRectGetMinX(self.scene.frame) + 50, CGRectGetMaxY(self.scene.frame) - 100);
    _windArrow.xScale = 0.1;
    _windArrow.yScale = 0.1;
    
    [self.hudLayer addChild:_windArrow];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        
        CGPoint location = [touch locationInNode:self];
        SKNode *node = [self nodeAtPoint:location];
        
        NSNotification *notification = [[NSNotification alloc] initWithName:@"tapInScene" object:node userInfo:Nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        
        if ([node isKindOfClass:[Anchor class]]) {
            Anchor *anchor = (Anchor *)node;
            if (_anchorHandlerSelected) {
                [_anchorHandler recoverAnchor:anchor];
            }
            
            anchor.physicsBody.dynamic = !anchor.physicsBody.dynamic;
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
                [_anchorHandler holdStationAtPoint];
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
    [_anchorHandler didSimulatePhysics];
}

-(void)didEvaluateActions
{
    [_barge didEvaluateActions];
    [_anchorHandler didEvaluateActions];
}

@end


