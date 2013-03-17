//
//  CardGameState.h
//  Matchismo
//
//  Created by Michael Thomson on 22/02/2013.
//  Copyright (c) 2013 Michael Thomson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CardGameState : NSObject

@property (nonatomic, strong) NSArray *disabledCards;
@property (nonatomic, strong) NSArray *faceUpCards;
@property (nonatomic) NSNumber *score;
@property (nonatomic, strong) NSString *narrative;

- (id)initWithScore:(int)score
      disabledCards:(NSArray *)disabledCards
        faceUpCards:(NSArray *)faceUpCards
          narrative:(NSString *)narrative;

@end

