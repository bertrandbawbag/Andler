//
//  Winch.h
//  Spring
//
//  Created by Claire Wright on 19/01/2014.
//  Copyright (c) 2014 Claire Wright. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Winch : SKSpriteNode

@property (nonatomic) CGVector force;
@property (nonatomic) float speed;

@property (nonatomic, strong) NSString *operatingMode;

-(instancetype)initWithColor:(UIColor *)color size:(CGSize)size position:(CGPoint) position;


-(void) didEvaluateActions;
-(void) didSimulatePhysics;

@end
