//
//  WindArrow.m
//  Spring
//
//  Created by Claire Wright on 25/01/2014.
//  Copyright (c) 2014 Claire Wright. All rights reserved.
//

#import "WindArrow.h"

@implementation WindArrow


-(instancetype)initWithImageNamed:(NSString *)name
{
    if ([super initWithImageNamed:name]) {
        
    }
    
    return self;
}

-(float)windArrowAngleForVector:(CGVector)vector
{
    float windAngle;
    
    windAngle = atan2f(vector.dy, vector.dx) - 3.14/2;
    
    return windAngle;
}


@end
