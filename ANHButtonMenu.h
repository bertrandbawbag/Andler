//
//  ANHButtonMenu.h
//  Anchor Handler
//
//  Created by Claire Wright on 19/05/2014.
//  Copyright (c) 2014 Brian. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface ANHButtonMenu : SKNode

@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic) BOOL visible;

- (id)initWithContentsOfPList: (NSString *) plistPath;


@end
