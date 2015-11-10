//
//  MALChunkNodeScanner.m
//  step1_read_print
//
//  Created by Heath Borders on 11/10/15.
//  Copyright © 2015 Heath Borders. All rights reserved.
//

#import "MALChunkNodeScanner.h"
#import "MALChunkNode.h"

@implementation MALChunkNodeScanner

+ (nonnull NSMutableArray<MALChunkNode *> *)chunkNodesFromString:(nonnull NSString *)string {
    NSMutableArray<MALChunkNode *> *chunkNodes = [NSMutableArray new];
    [string enumerateSubstringsInRange:NSMakeRange(0,
                                                        [string length])
                                    options:NSStringEnumerationByComposedCharacterSequences
                                 usingBlock:^(NSString * _Nullable substring,
                                              NSRange substringRange,
                                              NSRange enclosingRange,
                                              BOOL * _Nonnull stop) {
                                     NSAssert(substring, @"should never receive a nil composed character sequence");
                                     MALChunkNode *chunkNode = [[MALChunkNode alloc] initWithString:substring];
                                     [chunkNodes addObject:chunkNode];
                                 }];
    return chunkNodes;
}

@end
