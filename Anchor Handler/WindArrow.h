//
//  WindArrow.h
//  Spring
//
//  Created by Claire Wright on 25/01/2014.
//  Copyright (c) 2014 Claire Wright. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface WindArrow : SKSpriteNode

-(instancetype)initWithImageNamed:(NSString *)name;
-(float)windArrowAngleForVector: (CGVector) vector;


@end
