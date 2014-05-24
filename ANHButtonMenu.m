//
//  ANHButtonMenu.m
//  Anchor Handler
//
//  Created by Claire Wright on 19/05/2014.
//  Copyright (c) 2014 Brian. All rights reserved.
//

#import "ANHButtonMenu.h"
#import "SKBButtonNode.h"

@implementation ANHButtonMenu
{
    NSDictionary *_dictionaryFromPList;
}

- (id)initWithContentsOfPList:(NSString *)plistPath
{
    if ([super init]) {
        
        _dictionaryFromPList = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    }
    
    NSLog(@"%@", _dictionaryFromPList.description);
    
    return self;
}

@end
