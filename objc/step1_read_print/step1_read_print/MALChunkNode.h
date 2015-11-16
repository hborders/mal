//
//  MALChunkNode.h
//  step1_read_print
//
//  Created by Heath Borders on 11/9/15.
//  Copyright © 2015 Heath Borders. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MALNode.h"

@interface MALChunkNode : NSObject<MALNode>

+ (nonnull instancetype)new NS_UNAVAILABLE;
- (nonnull instancetype)init NS_UNAVAILABLE;
- (nonnull instancetype)initWithString:(nonnull NSString *)string;

+ (nonnull instancetype)spaceChunkNode;
+ (nonnull instancetype)openParensChunkNode;
+ (nonnull instancetype)closeParensChunkNode;
+ (nonnull instancetype)singleQuoteChunkNode;
+ (nonnull instancetype)backQuoteChunkNode;
+ (nonnull instancetype)tildeChunkNode;
+ (nonnull instancetype)doubleQuoteChunkNode;
+ (nonnull instancetype)backslashChunkNode;
+ (nonnull instancetype)commaChunkNode;
+ (nonnull instancetype)atChunkNode;
+ (nonnull instancetype)openSquareBracketChunkNode;
+ (nonnull instancetype)closeSquareBracketChunkNode;

@end
