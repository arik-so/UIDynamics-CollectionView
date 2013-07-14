//
//  SCBouncyCollectionViewFlowLayout.m
//  SecuChat
//
//  Created by Arik Sosman on 7/13/13.
//  Copyright (c) 2013 Sosman & Perk. All rights reserved.
//

#import "SCBouncyCollectionViewFlowLayout.h"

@interface SCBouncyCollectionViewFlowLayout()

@property UIDynamicAnimator *dynamicAnimator;

@end

@implementation SCBouncyCollectionViewFlowLayout

- (void)prepareLayout{
    [super prepareLayout];
    
    // return;
    
    if(!self.dynamicAnimator){
        self.dynamicAnimator = [[UIDynamicAnimator alloc] initWithCollectionViewLayout:self];
        
        CGSize contentSize = self.collectionViewContentSize;
        NSArray *items = [super layoutAttributesForElementsInRect:CGRectMake(0, 0, contentSize.width, contentSize.height)];
        
        for(UICollectionViewLayoutAttributes *currentItem in items){
            
            UIAttachmentBehavior *spring = [[UIAttachmentBehavior alloc] initWithItem:currentItem attachedToAnchor:currentItem.center];
            
            spring.length = 0;
            spring.damping = 0.8;
            spring.frequency = 0.8;
            
            [self.dynamicAnimator addBehavior:spring];
            
        }
        
    }
    
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    // return [super layoutAttributesForElementsInRect:rect];
    
    return [self.dynamicAnimator itemsInRect:rect];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    // return [super layoutAttributesForItemAtIndexPath:indexPath];
    
    return [self.dynamicAnimator layoutAttributesForCellAtIndexPath:indexPath];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    
    // return [super shouldInvalidateLayoutForBoundsChange:newBounds];
    
    UIScrollView *scrollView = self.collectionView;
    CGFloat scrollDelta = newBounds.origin.y - scrollView.bounds.origin.y;
    CGPoint touchLocation = [scrollView.panGestureRecognizer locationInView:scrollView];
    
    // shift layout attributes by delta
    for(UIAttachmentBehavior *spring in self.dynamicAnimator.behaviors){
        UICollectionViewLayoutAttributes *currentItem = spring.items.firstObject;
        
        CGPoint anchorPoint = spring.anchorPoint;
        CGFloat touchDistance = fabsf(touchLocation.y - anchorPoint.y);
        CGFloat resistanceFactor = 0.002; // it simply works well
        
        CGPoint center = currentItem.center;
        // center.y += MIN(scrollDelta * touchDistance * resistanceFactor, scrollDelta);
        
        float resistedScroll = scrollDelta * touchDistance * resistanceFactor;
        float simpleScroll = scrollDelta;
        
        float actualScroll = MIN(abs(simpleScroll), abs(resistedScroll));
        if(simpleScroll < 0){
            actualScroll *= -1;
        }
        
        // NSLog(@"scrolls: %f, %f; %f", resistedScroll, simpleScroll, actualScroll);
        
        center.y += actualScroll;
        currentItem.center = center;
        
        [self.dynamicAnimator updateItemFromCurrentState:currentItem];
        
    }
    
    // notify dynamic animator
    return NO;
    
}

@end
