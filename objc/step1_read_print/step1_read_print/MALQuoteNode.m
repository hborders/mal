//
//  MALQuoteNode.m
//  step1_read_print
//
//  Created by Heath Borders on 11/10/15.
//  Copyright © 2015 Heath Borders. All rights reserved.
//

#import "MALQuoteNode.h"
#import "MALConsNode.h"
#import "MALLiteralNode.h"
#import "MALChunkNode.h"
#import "MALChunkNodeScanner.h"

@interface MALQuoteNode ()

@property (nonatomic) MALConsNode * _Nonnull consNode;
@property (nonatomic) MALChunkNode * _Nullable ignorableChunkNode;

@end

@implementation MALQuoteNode

#pragma mark - init/dealloc

- (nonnull instancetype)initWithParentContainerNode:(nonnull id<MALContainerNode>)parentContainerNode
                                               type:(MALQuoteNodeType)type {
    self = [super init];
    if (self) {
        _consNode = [[MALConsNode alloc] initWithParentContainerNode:parentContainerNode];
        MALLiteralNode *quoteLiteralNode;
        switch (type) {
            case MALQuoteNodeTypeQuote:
                quoteLiteralNode = [[MALLiteralNode alloc] initWithParentContainerNode:self
                                                                                string:@"quote"];
                break;
            case MALQuoteNodeTypeQuasiQuote:
                quoteLiteralNode = [[MALLiteralNode alloc] initWithParentContainerNode:self
                                                                                string:@"quasiquote"];
                break;
            case MALQuoteNodeTypeUnquote:
                quoteLiteralNode = [[MALLiteralNode alloc] initWithParentContainerNode:self
                                                                                string:@"unquote"];
                break;
        }
        [_consNode appendLiteralNode:quoteLiteralNode];
        
        _ignorableChunkNode = [MALChunkNode openParensChunkNode];
    }
    return self;
}

#pragma mark - MALNode

- (nonnull NSString *)description {
    return self.consNode.description;
}

#pragma mark - MALContainerNode

- (nonnull id<MALContainerNode>)containerNodeAfterConsumingChunkNode:(nonnull MALChunkNode *)chunkNode {
    if ([self.ignorableChunkNode isEqual:chunkNode]) {
        self.ignorableChunkNode = nil;
        return self;
    } else {
        return [self.consNode containerNodeAfterConsumingChunkNode:chunkNode];
    }
}

@end
