//
//  VectorUtils.h
//  Anchor Handler
//
//  Created by Claire Wright on 16/02/2014.
//  Copyright (c) 2014 Brian. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>
#import <SpriteKit/SpriteKit.h>

#ifndef Anchor_Handler_VectorUtils_h
#define Anchor_Handler_VectorUtils_h
#endif


#define SKT_INLINE      static __inline__

#define ARC4RANDOM_MAX      0xFFFFFFFFu

#define DegreesToRadians(d) (M_PI * (d) / 180.0f)
#define RadiansToDegrees(r) ((r) * 180.0f / M_PI)


SKT_INLINE CGVector CGVectorAdd (CGVector vector1, CGVector vector2) {
    return CGVectorMake(vector1.dx + vector2.dx, vector1.dy + vector2.dy);
}

SKT_INLINE CGVector CGVectorSubtract (CGVector vector1, CGVector vector2) {
    return CGVectorMake(vector1.dx - vector2.dx, vector1.dy - vector2.dy);
}

SKT_INLINE CGVector CGVectorMultiplyScalar (CGVector vector, float value)   {
    return CGVectorMake(vector.dx * value, vector.dy * value);
}

SKT_INLINE CGVector CGVectorMultiply (CGVector vector1, CGVector vector2)   {
    return CGVectorMake (vector1.dx * vector2.dx, vector1.dy * vector2.dy);
}

SKT_INLINE CGVector CGPointDivide(CGVector vector1, CGVector vector2) {
    return CGVectorMake(vector1.dx / vector2.dx, vector1.dy / vector2.dy);
}

SKT_INLINE float CGVectorLength (CGVector vector)   {
    return sqrt(powf(vector.dx, 2) + powf(vector.dy,2));
}

SKT_INLINE CGVector CGVectorNormalise (CGVector vector) {
    float length = CGVectorLength(vector);
    return CGVectorMake(vector.dx / length, vector.dy / length );
}

SKT_INLINE float CGVectorAngle (CGVector vector)    {
    return atan2f (vector.dx, vector.dy);
}
/**
 * Takes an angle and returns a normalised vector
 * @param angle float
 * @return CGVector
 */

SKT_INLINE CGVector CGVectorAngleToVector (float angle)  {
    float opposite = sin(angle);
    float adjacent = cos(angle);
    return CGVectorMake (adjacent, opposite);
    
}
/**
 * Returns shortest angle between two angles, between -M_PI and M_PI
 * @param CGVector CGVector
 * @return CGFloat
 */
SKT_INLINE CGFloat ScalarShortestAngleBetween(CGVector vector1, CGVector vector2) {
    
    float vector1Angle = CGVectorAngle(vector1);
    float vector2Angle = CGVectorAngle(vector2);
    
    CGFloat difference = vector2Angle - vector1Angle;
    CGFloat angle = fmodf(difference, M_PI * 2);
    if (angle >= M_PI) {
        angle -= M_PI * 2;
    }
    if (angle <= -M_PI) {
        angle += M_PI * 2;
    }
    return angle;
}

