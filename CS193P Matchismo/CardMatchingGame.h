//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Michael Thomson on 20/02/2013.
//  Copyright (c) 2013 Michael Thomson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CardGameState.h"
#import "Card.h"
#import "Deck.h"

@interface CardMatchingGame : NSObject

@property (nonatomic) NSUInteger flipCostValue;
@property (nonatomic) NSUInteger misMatchPenaltyValue;
@property (nonatomic) NSUInteger matchBonusValue;
@property (nonatomic) NSUInteger numberOfCardsToMatch;

@property (nonatomic) NSUInteger score;
@property (nonatomic) NSUInteger flipCount;

@property (strong, nonatomic) NSMutableArray *cards; // of Card
@property (strong, nonatomic) NSMutableArray *faceUpCards;
@property (strong, nonatomic) NSMutableArray *lastMatchedCards;

@property (strong, nonatomic) NSString *narrative;
@property (strong, nonatomic) NSMutableArray *previousStates; // of CardGameState

@property (nonatomic, getter = isInProgress) BOOL inProgress;

// Designated initialiser!
- (id)initWithCardCount:(NSUInteger)cardCount
               usingDeck:(Deck *)deck;

- (void)flipCardAtIndex:(NSUInteger)index; // abstract
- (void)storeState;
- (void)restoreStateForFlipCount:(int)flipCount;

- (Card *)cardAtIndex:(NSUInteger)index;

@end
