//
//  NSAttributedString+add.m
//  ZHCustomer
//
//  Created by  蔡卓越 on 2016/12/26.
//  Copyright © 2016年  caizhuoyue. All rights reserved.
//

#import "NSAttributedString+add.h"

@implementation NSAttributedString (add)

+ (NSAttributedString *)convertImg:(UIImage *)img bounds:(CGRect)bounds {

    
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
    textAttachment.image = img;
    textAttachment.bounds = bounds;
    return [NSAttributedString attributedStringWithAttachment:textAttachment];

}

- (NSMutableAttributedString *)getAttributedStringWithImgStr:(NSString *)imgStr bounds:(CGRect)bounds num:(NSString *)num {
    
    NSAttributedString *string = [NSAttributedString convertImg:[UIImage imageNamed:imgStr] bounds:bounds];
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:num];
    
    [attrStr insertAttributedString:string atIndex:0];
    
    return attrStr;
}

@end
