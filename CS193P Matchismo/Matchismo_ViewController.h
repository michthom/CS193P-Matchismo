//
//  Matchismo_ViewController.h
//  CS193P Matchismo
//
//  Created by Michael Thomson on 17/03/2013.
//  Copyright (c) 2013 Michael Thomson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayingCard.h"
#import "PlayingCardDeck.h"
#import "SetCard.h"
#import "SetCardDeck.h"
#import "CardMatchingGame.h"

@interface Matchismo_ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISlider *flipSlider;
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *narrativeLabel;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

@property (strong, nonatomic) CardMatchingGame *game;


// Abstract methods - please implement
- (Deck *)createDeck;
- (void)setupGame:(CardMatchingGame *)game;
- (void)updateUI;

@end