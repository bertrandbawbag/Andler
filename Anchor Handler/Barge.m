//
//  Barge.m
//  Spring
//
//  Created by Claire Wright on 26/01/2014.
//  Copyright (c) 2014 Claire Wright. All rights reserved.
//

#import "Barge.h"
#import "AnchorAssembly.h"



@implementation Barge

-(id)init
{
    if (self = [super init]) {
        [self setUpHull];
        
    }
    
    
    return self;
}


/**
 * Creates spritenode for the hull of the vessel
 * @see SKSpriteNode
 * @warning The position of the hull in the scene is hardwired. We need a new method to initiate with arbitrary position. Be careful with initiation of physics body.
 */

-(void) setUpHull
{
    self.hull = [SKSpriteNode spriteNodeWithColor:[SKColor grayColor] size:CGSizeMake(50, 100)];
    self.hull.name = @"hull";
    self.hull.position = CGPointMake(350, 350);
    self.hull.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.hull.size];
    self.hull.physicsBody.affectedByGravity = YES;
    self.hull.physicsBody.mass = 100;
    self.hull.physicsBody.allowsRotation = YES;
    self.hull.physicsBody.linearDamping = 0.5;
    self.hull.physicsBody.angularDamping = 0.5;
    // self.zPosition = _assembly.winch.zPosition - 1;
    // self.anchorPoint = CGPointMake(1, 1);
    
    [self addChild:self.hull];

}


/**
 * Sets up 4 anchor pattern based on vessel position. Should be called following init of class
 * @param None
 * @return Void
 * @see setUpHull
 * @warning Currently hard coded. No allowance for changes in vessel size currently
 */

-(void) setUpAnchorPattern
{
    self.anchorAssemblies = [NSMutableDictionary dictionary];
    
    NSString *portOrStarboard;
    NSString *name;
    
    for (int i=1; i<=2; i++) { // fore and aft
        CGFloat anchorX;
        CGFloat winchX;
        CGFloat jointAnchorXOffset;
        UIColor *winchColor;
        switch (i) {
            case 1:
                winchX = CGRectGetMinX(self.hull.frame);
                anchorX = winchX - 100;
                jointAnchorXOffset = -0;
                portOrStarboard = @"P";
                winchColor = [SKColor redColor];
                break;
            case 2:
                winchX = CGRectGetMaxX(self.hull.frame);
                portOrStarboard = @"S";
                anchorX = winchX + 100;
                jointAnchorXOffset = 0;
                winchColor = [SKColor greenColor];
                break;
            default:
                break;
        }
        
        for (int j = 1; j<=2; j++) { // port and starboard
            
            CGFloat anchorY;
            CGFloat winchY;
            CGFloat jointAnchorYOffset;
            name = [portOrStarboard stringByAppendingString:[NSString stringWithFormat:@"%i", j]];
            if (j==1) {
                winchY = CGRectGetMaxY(self.hull.frame);
                anchorY = winchY + 200;
                jointAnchorYOffset = 0;
            } else{
                winchY = CGRectGetMinY(self.hull.frame);
                anchorY = winchY - 200;
                jointAnchorYOffset = -0;

            }
            
            
            AnchorAssembly *assembly = [[AnchorAssembly alloc] initWithWinchPosition:CGPointMake(winchX, winchY) andAnchorPosition:CGPointMake(anchorX, anchorY)];
            assembly.winch.color = winchColor;
            assembly.name = name;
            
            
            [self addChild:assembly];
            
            NSLog(@"%@, %@, %@", assembly.name, NSStringFromCGPoint(assembly.winch.position), NSStringFromCGPoint(assembly.wire.position));
    
            
            
            CGPoint jointAnchor = CGPointMake(winchX, winchY);
            SKPhysicsJointPin *joint = [SKPhysicsJointPin jointWithBodyA:assembly.winch.physicsBody  bodyB:self.hull.physicsBody anchor:jointAnchor];
            [self.scene.physicsWorld addJoint:joint];
            
            [self.anchorAssemblies setObject:assembly forKey:assembly.name];

        } // next j
        
        
    } // next i
    
//    [self enumerateChildNodesWithName:@"*" usingBlock:^(SKNode *node, BOOL *stop){
//        NSLog(@"%@",node.name);
//        for (SKNode *item in node.children) {
//            
//            NSLog(@"%@", item.physicsBody);
//        }
//    }];
}



-(void)update:(CFTimeInterval)currentTime
{
    
    for (NSString *key in self.anchorAssemblies) {
        [[self.anchorAssemblies objectForKey:key] update:currentTime];
    }
}


-(void)didEvaluateActions
{
    for (NSString *key in self.anchorAssemblies) {
        [[self.anchorAssemblies objectForKey:key] didEvaluateActions];
    }
}

-(void) didSimulatePhysics
{
    for (NSString *key in self.anchorAssemblies) {
        [[self.anchorAssemblies objectForKey:key] didSimulatePhysics];
    }
}

@end
