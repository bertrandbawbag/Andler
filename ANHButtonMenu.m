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
    NSDictionary *_dictionaryOfAnchorHandlerData;
    NSArray *_arrayOfButtonData;
}

- (SKNode *)initWithContentsOfPList:(NSString *)plistPath
{
    if ([super init]) {
        
        _dictionaryFromPList = [NSDictionary dictionaryWithContentsOfFile:plistPath];
        _dictionaryOfAnchorHandlerData = [NSDictionary dictionaryWithDictionary:[_dictionaryFromPList objectForKey:@"AnchorHandlerMenu"]];
        _arrayOfButtonData = [NSArray arrayWithArray:[_dictionaryOfAnchorHandlerData objectForKey:@"buttons"]];
        
        CGFloat spacing = [(NSNumber *)[_dictionaryOfAnchorHandlerData objectForKey:@"button spacing"] floatValue] ;
        CGFloat buttonX = spacing;
        NSString *sizeString = [_dictionaryOfAnchorHandlerData objectForKey:@"button size"];

        
        for (NSDictionary *buttonData in _arrayOfButtonData) {
            
            SKTexture *texture = [SKTexture textureWithImageNamed:[buttonData objectForKey:@"image"]];
            SKTexture *texturePressed = [SKTexture textureWithImageNamed:[buttonData objectForKey:@"imagepressed"]];
            
            SKBButtonNode *newButton = [[SKBButtonNode alloc] initWithTextureNormal:texture selected:texturePressed];
            newButton.size = CGSizeFromString(sizeString);
            newButton.title.text = [buttonData objectForKey:@"text"];
            newButton.title.fontColor = [SKColor blackColor];
            newButton.title.fontSize = [(NSNumber *) [_dictionaryOfAnchorHandlerData objectForKey:@"button font size"] floatValue];
            newButton.alpha =  [ (NSNumber *)[buttonData objectForKey:@"opacity"] floatValue];
            
            newButton.position = CGPointMake(buttonX, spacing);
            buttonX = buttonX + newButton.size.width + spacing;
            
            [self addChild:newButton];

        }
        
    }
    
    NSLog(@"%@", _dictionaryFromPList.description);
    
    
    self.userInteractionEnabled = YES;
    return self;
}

@end
