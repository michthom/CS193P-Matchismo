//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Michael Thomson on 23/02/2013.
//  Copyright (c) 2013 Michael Thomson. All rights reserved.
//

#import "PlayingCardGameViewController.h"

@implementation PlayingCardGameViewController

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (void)setupGame:(CardMatchingGame *)game
{
    game.flipCostValue = 1;
    game.misMatchPenaltyValue = 2;
    game.matchBonusValue = 4;
    game.numberOfCardsToMatch = 2;
}

- (void)updateUI
{

#define CURRENT_ALPHA 1.0
#define HISTORIC_ALPHA 0.3

    if (self.game.flipCount != [self.game.previousStates count] - 1) {
        self.flipsLabel.alpha = HISTORIC_ALPHA;
        self.scoreLabel.alpha = HISTORIC_ALPHA;
        self.narrativeLabel.alpha = HISTORIC_ALPHA;
    } else {
        self.flipsLabel.alpha = CURRENT_ALPHA;
        self.scoreLabel.alpha = CURRENT_ALPHA;
        self.narrativeLabel.alpha = CURRENT_ALPHA;
    }
    
    UIImage *cardBackImage = [UIImage imageNamed:@"cardback.png"];
    for (UIButton *cardButton in self.cardButtons) {
        
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        
#define IMAGEINSET 3.0
        [cardButton setImageEdgeInsets:UIEdgeInsetsMake(IMAGEINSET, IMAGEINSET, IMAGEINSET, IMAGEINSET)];
        
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected | UIControlStateDisabled];
        
        if (card.isFaceUp) {
            cardButton.selected = YES;
        } else {
            cardButton.selected = NO;
        }
        
        if (cardButton.selected) {
            [cardButton setImage:nil forState:UIControlStateNormal];
        } else {
            [cardButton setImage:cardBackImage forState:UIControlStateNormal];
        }
        
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = (card.isUnplayable) ? 0.3 : 1.0;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.game.flipCount];

    self.narrativeLabel.text = self.game.narrative;
}

@end
