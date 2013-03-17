//
//  PlayingCardDeck.m
//  HW1
//
//  Created by Michael Thomson on 20/02/2013.
//  Copyright (c) 2013 Michael Thomson. All rights reserved.
//

#import "PlayingCardDeck.h"

@implementation PlayingCardDeck

- (id)init
{
    self = [super init];
    if (self) {
        for (NSString *suit in [PlayingCard validSuits]) {
            for (NSUInteger rank = 1; rank < [PlayingCard maxRank]; rank++) {
                PlayingCard *card = [[PlayingCard alloc] init];
                card.rank = rank;
                card.suit = suit;
                [self addCard:card atTop:YES];
            }
        }
    }
    return self;
}

- (PlayingCard *)drawRandomCard
{
    return (PlayingCard *)[super drawRandomCard];
}

@end
