//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Michael Thomson on 23/02/2013.
//  Copyright (c) 2013 Michael Thomson. All rights reserved.
//

#import "SetCardDeck.h"

@implementation SetCardDeck

- (id)init
{
    self = [super init];
    if (self) {
        
        for (NSString *shape in [SetCard validShapes]) {
            for (NSString *colour in [SetCard validColours]) {
                for (NSString *shading in [SetCard validShadings]) {
                    for (NSUInteger count = 1; count <= [SetCard maxCount]; count++) {
                        SetCard *card = [[SetCard alloc] init];

                        card.shape = shape;
                        card.colour = colour;
                        card.shading = shading;
                        card.count = count;
                        
                        [self addCard:card atTop:YES];

                    }
                }
            }
        }
    }
    return self;
}

@end
