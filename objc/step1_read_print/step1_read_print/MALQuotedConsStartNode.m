//
//  MALQuotedConsStartNode.m
//  step1_read_print
//
//  Created by Heath Borders on 11/12/15.
//  Copyright © 2015 Heath Borders. All rights reserved.
//

#import "MALQuotedConsStartNode.h"
#import "MALConsNode.h"
#import "MALLiteralNode.h"
#import "MALChunkNode.h"

@interface MALQuotedConsStartNode ()

@property (nonatomic) MALConsNode * _Nonnull consNode;

@end

@implementation MALQuotedConsStartNode

#pragma mark - init/dealloc

- (nonnull instancetype)initWithParentContainerNode:(nonnull id<MALContainerNode>)parentContainerNode
                                               type:(MALQuotedConsStartNodeType)type {
    self = [super init];
    if (self) {
        _consNode = [[MALConsNode alloc] initWithType:MALConsNodeTypeList
                                  parentContainerNode:parentContainerNode];
        MALLiteralNode *quoteLiteralNode;
        switch (type) {
            case MALQuotedConsStartNodeTypeQuote:
                quoteLiteralNode = [[MALLiteralNode alloc] initWithParentContainerNode:_consNode
                                                                                string:@"quote"];
                break;
            case MALQuotedConsStartNodeTypeQuasiQuote:
                quoteLiteralNode = [[MALLiteralNode alloc] initWithParentContainerNode:_consNode
                                                                                string:@"quasiquote"];
                break;
        }
        [_consNode appendLiteralNode:quoteLiteralNode];
    }
    return self;
}

#pragma mark - MALNode

- (nonnull NSString *)description {
    return self.consNode.description;
}

#pragma mark - MALContainerNode

- (nonnull id<MALContainerNode>)containerNodeAfterConsumingChunkNode:(nonnull MALChunkNode *)chunkNode {
    return [self.consNode containerNodeAfterConsumingChunkNode:chunkNode];
}

@end
