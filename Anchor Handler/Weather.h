//
//  Weather.h
//  Anchor Handler
//
//  Created by Claire Wright on 15/03/2014.
//  Copyright (c) 2014 Brian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Weather : NSObject

@property (nonatomic, readonly) float currentStrength;
@property (nonatomic, readonly) float currentDirection;

@property (nonatomic, readonly) float windStrength;
@property (nonatomic, readonly) float windDirection;

@end
