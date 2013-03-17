//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Michael Thomson on 20/02/2013.
//  Copyright (c) 2013 Michael Thomson. All rights reserved.
//

#import "CardMatchingGame.h"

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

- (NSMutableArray *)faceUpCards
{
    if (!_faceUpCards) {
        _faceUpCards = [[NSMutableArray alloc] init];
    }
    return _faceUpCards;
}

- (NSMutableArray *)lastMatchedCards
{
    if (!_lastMatchedCards) {
        _lastMatchedCards = [[NSMutableArray alloc] init];
    }
    return _lastMatchedCards;
}

- (NSMutableArray *)previousStates
{
    if (!_previousStates) {
        _previousStates = [[NSMutableArray alloc] init];

        CardGameState *state = [[CardGameState alloc] init];
        [self.previousStates addObject:state];
    }
    return _previousStates;
}

- (void)storeState
{
    NSMutableArray *disabledCards = [[NSMutableArray alloc] init];
    
    for (Card *oneCard in self.cards) {
        if (oneCard.isUnplayable) {
            [disabledCards addObject:oneCard];
        }
    }
    
    CardGameState *state = [[CardGameState alloc] initWithScore:self.score
                                                  disabledCards:disabledCards
                                                    faceUpCards:[self.faceUpCards arrayByAddingObjectsFromArray:disabledCards]
                                                      narrative:self.narrative];
    [self.previousStates addObject:state];
}

- (void)restoreStateForFlipCount:(int)otherflipCount
{
    CardGameState *state;
    
    state = self.previousStates[otherflipCount];
    
    self.score = [state.score intValue];
    self.narrative = state.narrative;
    self.flipCount = otherflipCount;
    
    for (Card *oneCard in self.cards) {
        
        if ([state.disabledCards containsObject:oneCard]) {
            oneCard.unplayable = YES;
            oneCard.faceUp = YES;
        } else {
            oneCard.unplayable = NO;
        }
        
        if ([state.faceUpCards containsObject:oneCard]) {
            oneCard.faceUp = YES;
        } else {
            oneCard.faceUp = NO;
        }

    }
}

- (id)initWithCardCount:(NSUInteger)cardCount
              usingDeck:(Deck *)deck
{
    self = [super init];
    if (self) {
        for (int i = 0; i < cardCount; i++) {
            Card *card = [deck drawRandomCard];
            if (!card) {
                self = nil;
            } else {    
                [self.cards addObject:card];
            }
        }
    }
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    if (!card.isUnplayable) {
        [self.lastMatchedCards removeAllObjects];

        if (card.isFaceUp) {
            
            // Flip card down
            self.narrative = @"";
            [self.faceUpCards removeObject:card];
            card.faceUp = !card.isFaceUp;
            
            
        } else {
            
            NSArray *otherCards = [self.faceUpCards copy];

            if ([self.faceUpCards count] < self.numberOfCardsToMatch) {
                
                // Flip this card up
                self.narrative = [NSString stringWithFormat:@"Flipped up %@", [card description]];
                
                [self.faceUpCards addObject:card];
                card.faceUp = !card.isFaceUp;
                self.score -= self.flipCostValue;

                [self.lastMatchedCards addObject:card];
            }
            
            if ([self.faceUpCards count] == self.numberOfCardsToMatch) {
                
                // Have we got a match?
                
                [self.lastMatchedCards addObjectsFromArray:otherCards];

                int matchScore = [card match:otherCards];
                
                if (matchScore) {
                                        
                    self.score += matchScore * self.matchBonusValue;
                    
                    self.narrative = [NSString stringWithFormat:@"Matched %@ for %d points!", [self.faceUpCards componentsJoinedByString:@" & "], matchScore * self.matchBonusValue];
                    
                    for (Card *oneCard in self.faceUpCards) {
                        oneCard.unplayable = YES;
                    }
                    
                    [self.faceUpCards removeAllObjects];
                    
                } else {
                    
                    self.score -= self.misMatchPenaltyValue;
                    self.narrative = [NSString stringWithFormat:@"%@ don't match! %d point penalty.", [self.faceUpCards componentsJoinedByString:@" & "], self.misMatchPenaltyValue];
                    
                }
            }
            NSLog(@"%@", self.narrative);
        }
    }
}

@end
