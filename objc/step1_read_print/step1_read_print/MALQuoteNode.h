//
//  MALQuoteNode.h
//  step1_read_print
//
//  Created by Heath Borders on 11/10/15.
//  Copyright © 2015 Heath Borders. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MALContainerNode.h"

@class MALLiteralNode;

typedef NS_ENUM(NSInteger, MALQuoteNodeType) {
    MALQuoteNodeTypeQuote,
    MALQuoteNodeTypeQuasiQuote,
    MALQuoteNodeTypeUnquote,
};

@interface MALQuoteNode : NSObject<MALContainerNode>

+ (nonnull instancetype)new NS_UNAVAILABLE;
- (nonnull instancetype)init NS_UNAVAILABLE;
- (nonnull instancetype)initWithParentContainerNode:(nonnull id<MALContainerNode>)parentContainerNode
                                               type:(MALQuoteNodeType)type;

@end
