//
//  UIView+Custom.m
//  YS_iOS
//
//  Created by 蔡卓越 on 2017/6/21.
//  Copyright © 2017年 caizhuoyue. All rights reserved.
//

#import "UIView+Custom.h"

@implementation UIView (Custom)
- (CALayer *)getLayerWithDirection:(NSString *)direction size:(CGSize)size {
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    
    if ([direction isEqualToString:@"left"]) {
        
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerBottomLeft) cornerRadii:size];
        
        maskLayer.frame = self.bounds;
        maskLayer.path = maskPath.CGPath;
        
    } else if ([direction isEqualToString:@"right"]) {
        
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:(UIRectCornerTopRight | UIRectCornerBottomRight) cornerRadii:size];
        
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        
        maskLayer.frame = self.bounds;
        maskLayer.path = maskPath.CGPath;
    }
    
    return maskLayer;
    
}
@end
