//
//  Winch.m
//  Spring
//
//  Created by Claire Wright on 19/01/2014.
//  Copyright (c) 2014 Claire Wright. All rights reserved.
//

/* Anchor modes
 Constant tension
 Stop
 */


#import "Winch.h"

@implementation Winch
{
    SKLabelNode *_tensionLabel;
}


-(instancetype)initWithColor:(UIColor *)color size:(CGSize)size position:(CGPoint) position
{
    if (self = [super initWithColor:color size:size]) {

        // add initialisation code here
        self.position = position;
        [self setUpPhysics];
        [self setUpLabel];
    }
    
    
    return self;
}

-(void) setUpPhysics
{
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.dynamic = YES;
    self.physicsBody.mass = 50;
    self.physicsBody.allowsRotation = YES;
}

-(void) didEvaluateActions
{
    [self.physicsBody applyImpulse:self.force];


}

-(void) didSimulatePhysics
{
    CGFloat magnitude = sqrtf(powf(self.force.dx, 2) + pow(self.force.dy, 2));
    _tensionLabel.text = [NSString stringWithFormat:@"%.0f", magnitude];
}

-(void) setUpLabel
{
    _tensionLabel = [SKLabelNode labelNodeWithFontNamed:@"Thonburi"];
    _tensionLabel.fontColor = [SKColor blueColor];
    _tensionLabel.fontSize = 13.0f;
    _tensionLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    
    [self addChild:_tensionLabel];
    
  }

@end
