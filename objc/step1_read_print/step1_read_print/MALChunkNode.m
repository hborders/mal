//
//  MALChunkNode.m
//  step1_read_print
//
//  Created by Heath Borders on 11/9/15.
//  Copyright © 2015 Heath Borders. All rights reserved.
//

#import "MALChunkNode.h"

@interface MALChunkNode()

@property (nonatomic) NSString * _Nonnull string;

@end

static MALChunkNode * _Nonnull spaceChunkNode;
static MALChunkNode * _Nonnull openParensChunkNode;
static MALChunkNode * _Nonnull closeParensChunkNode;
static MALChunkNode * _Nonnull singleQuoteChunkNode;
static MALChunkNode * _Nonnull backQuoteChunkNode;
static MALChunkNode * _Nonnull tildeChunkNode;
static MALChunkNode * _Nonnull doubleQuoteChunkNode;
static MALChunkNode * _Nonnull backslashChunkNode;
static MALChunkNode * _Nonnull commaChunkNode;
static MALChunkNode * _Nonnull atChunkNode;
static MALChunkNode * _Nonnull openSquareBracketChunkNode;
static MALChunkNode * _Nonnull closeSquareBracketChunkNode;
static MALChunkNode * _Nonnull openCurlyBraceChunkNode;
static MALChunkNode * _Nonnull closeCurlyBraceChunkNode;

@implementation MALChunkNode

#pragma mark - init/dealloc

+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        spaceChunkNode = [[MALChunkNode alloc] initWithString:@" "];
        openParensChunkNode = [[MALChunkNode alloc] initWithString:@"("];
        closeParensChunkNode = [[MALChunkNode alloc] initWithString:@")"];
        singleQuoteChunkNode = [[MALChunkNode alloc] initWithString:@"'"];
        backQuoteChunkNode = [[MALChunkNode alloc] initWithString:@"`"];
        tildeChunkNode = [[MALChunkNode alloc] initWithString:@"~"];
        doubleQuoteChunkNode = [[MALChunkNode alloc] initWithString:@"\""];
        backslashChunkNode = [[MALChunkNode alloc] initWithString:@"\\"];
        commaChunkNode = [[MALChunkNode alloc] initWithString:@","];
        atChunkNode = [[MALChunkNode alloc] initWithString:@"@"];
        openSquareBracketChunkNode = [[MALChunkNode alloc] initWithString:@"["];
        closeSquareBracketChunkNode = [[MALChunkNode alloc] initWithString:@"]"];
        openCurlyBraceChunkNode = [[MALChunkNode alloc] initWithString:@"{"];
        closeCurlyBraceChunkNode = [[MALChunkNode alloc] initWithString:@"}"];
    });
}

- (nonnull instancetype)initWithString:(nonnull NSString *)string {
    self = [super init];
    if (self) {
        NSParameterAssert([string length] == 1);
        _string = string;
    }
    
    return self;
}

#pragma mark - NSObject

- (BOOL)isEqual:(id)object {
    if ([object isKindOfClass:[MALChunkNode class]]) {
        MALChunkNode *thatChunkNode = (MALChunkNode *)object;
        return [self.string isEqualToString:thatChunkNode.string];
    } else {
        return NO;
    }
}

- (NSUInteger)hash {
    return self.string.hash;
}

#pragma mark - MALNode

- (nonnull NSString *)description {
    return self.string;
}

#pragma mark - Public API

+ (nonnull instancetype)spaceChunkNode {
    return spaceChunkNode;
}

+ (nonnull instancetype)openParensChunkNode {
    return openParensChunkNode;
}

+ (nonnull instancetype)closeParensChunkNode {
    return closeParensChunkNode;
}

+ (nonnull instancetype)singleQuoteChunkNode {
    return singleQuoteChunkNode;
}

+ (nonnull instancetype)backQuoteChunkNode {
    return backQuoteChunkNode;
}

+ (nonnull instancetype)tildeChunkNode {
    return tildeChunkNode;
}

+ (nonnull instancetype)doubleQuoteChunkNode {
    return doubleQuoteChunkNode;
}

+ (nonnull instancetype)backslashChunkNode {
    return backslashChunkNode;
}

+ (nonnull instancetype)commaChunkNode {
    return commaChunkNode;
}

+ (nonnull instancetype)atChunkNode {
    return atChunkNode;
}

+ (nonnull instancetype)openSquareBracketChunkNode {
    return openSquareBracketChunkNode;
}

+ (nonnull instancetype)closeSquareBracketChunkNode {
    return closeSquareBracketChunkNode;
}

+ (nonnull instancetype)openCurlyBraceChunkNode {
    return openCurlyBraceChunkNode;
}

+ (nonnull instancetype)closeCurlyBraceChunkNode {
    return closeCurlyBraceChunkNode;
}

@end
