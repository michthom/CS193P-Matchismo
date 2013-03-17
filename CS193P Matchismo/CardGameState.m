//
//  CardGameState.m
//  Matchismo
//
//  Created by Michael Thomson on 22/02/2013.
//  Copyright (c) 2013 Michael Thomson. All rights reserved.
//

#import "CardGameState.h"

@implementation CardGameState

- (id)init
{
    self = [super init];
    if (self) {
        self.score = 0;
        self.disabledCards = @[];
        self.faceUpCards = @[];
    }
    return self;
}

- (id)initWithScore:(int)score
      disabledCards:(NSArray *)disabledCards
        faceUpCards:(NSArray *)faceUpCards
          narrative:(NSString *)narrative
{
    self = [super init];
    if (self) {
        self.score = @(score);
        
        // Do I need to copy here?
        self.disabledCards = [disabledCards copy];
        self.faceUpCards = [faceUpCards copy];
        self.narrative = [narrative copy];
    }
    return self;
}

- (NSString *)description
{
    NSString *result = [[NSString alloc] init];
    result = [result stringByAppendingFormat:@"Score   : %@\n", self.score];
    result = [result stringByAppendingFormat:@"Disabled: %lu\n", (unsigned long)[self.disabledCards count]];
    result = [result stringByAppendingFormat:@"Face Up : %lu\n", (unsigned long)[self.faceUpCards count]];
    return result;
}


@end
