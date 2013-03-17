//
//  Deck.h
//  HW1
//
//  Created by Michael Thomson on 20/02/2013.
//  Copyright (c) 2013 Michael Thomson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (Card *)drawRandomCard;

@end
