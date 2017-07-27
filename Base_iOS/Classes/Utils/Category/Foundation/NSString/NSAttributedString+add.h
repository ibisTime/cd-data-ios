//
//  NSAttributedString+add.h
//  ZHCustomer
//
//  Created by  蔡卓越 on 2016/12/26.
//  Copyright © 2016年  caizhuoyue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (add)

+ (NSAttributedString *)convertImg:(UIImage *)img bounds:(CGRect)bounds;

- (NSMutableAttributedString *)getAttributedStringWithImgStr:(NSString *)imgStr bounds:(CGRect)bounds num:(NSString *)num;

@end
