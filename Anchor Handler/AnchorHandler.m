//
//  AnchorHandler.m
//  Anchor Handler
//
//  Created by Claire Wright on 08/02/2014.
//  Copyright (c) 2014 Brian. All rights reserved.
//

/*
What can my anchor handler do?
1. hold station
2. hold heading
3. move holding heading
4. transit to a point
5. pick up an anchor from the seabed
6. live anchor
7. move anchor
8. drop anchor
9. take an anchor from the barge
10. give an anchor to the barge
11. install yokohama
12. remove yokohama
*/

#import "AnchorHandler.h"

@interface AnchorHandler()

@property (nonatomic, strong) UIToolbar *buttonMenu;
@property (nonatomic, strong) UIButton *button;

@end

@implementation AnchorHandler

{
    CGMutablePathRef _pathToFollow;
}

-(id)initWithImageNamed:(NSString *)name position: (CGPoint) position;
{
    if ([super initWithImageNamed:name]) {
        self.position = position;
        self.xScale = 0.4;
        self.yScale = 0.4;
        self.operatingMode = kHoldStationOperationMode;
        self.activityMode = kStandbyActivityMode;
        self.dpHoldingPosition = self.position;

        self.maxThrustForce = 50;
        [self setUpPhysics];
        
//        self.buttonMenu = [[UIToolbar alloc] init];
//        self.buttonMenu.barTintColor = [UIColor redColor];
//        
//        UIBarButtonItem *button1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(toolbarItemPressed:)];
//        UIBarButtonItem *button2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(toolbarItemPressed:)];
//        UIBarButtonItem *button3 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(toolbarItemPressed:)];
//
//        
//        NSArray *buttonArray = @[button1, button2, button3];
//        [self.buttonMenu setItems:buttonArray animated:YES];
        
        
    // the scene does not exist yet
        
        self.button = [[UIButton alloc] init];
        self.button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.button addTarget:self action:@selector(toolbarItemPressed:) forControlEvents:UIControlEventTouchDown];
        [self.button setTitle:@"TEST" forState:UIControlStateNormal];
        self.button.layer.anchorPoint = self.position;
        self.button.frame = CGRectMake(self.position.x, self.position.y, 50, 100);
        

        

        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationOfTouchReceived:) name:@"tapInScene" object:nil];

    }
    return self;
}

-(id)initWithColor:(UIColor *)color size:(CGSize)size position:(CGPoint) position
{
    if ([super initWithColor:color size:size]) {
        self.position = position;
        [self setUpPhysics];
    }
    return self;
}
-(void)update:(CFTimeInterval)currentTime
{
    if (self.operatingMode == kHoldStationOperationMode) {
        [self holdStationAtPoint];
    }
    
    if (self.operatingMode == kTransitOperationMode) {
        [self transitToPoint:CGPointMake(500, 700)];
    }
    
    if (self.activityMode == kRecoverAnchorActivityMode) {
        [self recoverAnchor:self.targetAnchor];
    }
    
    // self.button.layer.anchorPoint = self.position;
    

    
}
-(void)didSimulatePhysics
{
    
}
-(void)didEvaluateActions
{
    
}
/**
 * Transit from one point to another. Vessel turns to face travel. Calculates complex route using Lee algorithm.
 * @param CGPoint point
 * @return void
 * @warning Uses max force to limit the total force applied to bring the vessel back
 */
-(void) transitToPoint: (CGPoint) point
{
// calculate route and draw invisible path to follow
    
    _pathToFollow = CGPathCreateMutable();
    CGPathMoveToPoint(_pathToFollow, nil,  self.position.x, self.position.y);
    CGPathAddLineToPoint(_pathToFollow, nil, point.x, point.y);
    
// rotate to path direction
// follow path
// hold position at end point
}

/**
 * DP function to keep the vessel on station. Applies force to bring the vessel back to the desired point
 * @param None
 * @return void
 * @warning Uses max force to limit the total force applied to bring the vessel back
 */
-(void) holdStationAtPoint
{
    self.operatingMode = kHoldStationOperationMode;
    // applies force in the opposite direction that the vessel is drifting away from dpHoldingPosition
    CGVector offset = CGVectorMake(self.dpHoldingPosition.x - self.position.x, self.dpHoldingPosition.y - self.position.y);
    if (fabsf(offset.dx)  > self.maxThrustForce ) {
        if (offset.dx < 0) {
            offset.dx = -self.maxThrustForce;
        }   else    {
            offset.dx = self.maxThrustForce;

        }
    }
    if (fabsf(offset.dy)  > self.maxThrustForce ) {
        if (offset.dy < 0) {
            offset.dy = -self.maxThrustForce;
        }   else    {
            offset.dy = self.maxThrustForce;
        }
    }
    
    [self.physicsBody applyImpulse:offset];
    [self rotateToDirection:CGVectorMake(0, -0.1)];
}

/**
 * Get vessel in position and get the anchor off the seabed
 * @param Anchor anchor
 * @return BOOL
 * @see transitToPoint
 */

-(BOOL) recoverAnchor:(Anchor *)anchor
{
    NSLog(@"%s %d %s %s", __FILE__, __LINE__, __PRETTY_FUNCTION__, __FUNCTION__);
    BOOL anchorOnDeck = false;
    
    self.targetAnchor = anchor;
    
    // calculate pickup point
    // go to pickup point
    // rotate vessel
    // connect to anchor
    // increase force to hold
    
    return anchorOnDeck;
}

-(void) rotateToDirection: (CGVector) direction
{
    float angleToRotate = CGVectorScalarShortestAngleBetween(CGVectorAngleToVector(self.zRotation) , direction);
    float torqueToApply = angleToRotate;
    [self.physicsBody applyTorque:torqueToApply];
    
}



-(void) setUpPhysics
{
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
    self.physicsBody.linearDamping = 0.9;
    self.physicsBody.angularDamping = 0.9;
    self.physicsBody.mass = 100;
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%s %d %s %s", __FILE__, __LINE__, __PRETTY_FUNCTION__, __FUNCTION__);


    [self.delegate showAnchorHandlerMenu];
}

-(void) notificationOfTouchReceived: (NSNotification *) notification
{
    NSLog(@"tapInScene notification received in node type %@", [notification.object class]);
    
    
    [self.scene.view addSubview:self.button];

}

-(void) toolbarItemPressed: (id) sender
{
    NSLog(@"%s %d %s %s", __FILE__, __LINE__, __PRETTY_FUNCTION__, __FUNCTION__);

    UIButton *button = (UIButton *) sender;
    NSLog(@"%@", button.description);
}

@end
