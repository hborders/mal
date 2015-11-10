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

@end
