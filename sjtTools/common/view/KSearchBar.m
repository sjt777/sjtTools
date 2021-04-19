//
//  KSearchBar.m
//  antQueen
//
//  Created by 王明星 on 15/7/29.
//  Copyright (c) 2015年 yibyi. All rights reserved.
//

#import "KSearchBar.h"

@implementation KSearchBar
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setFont:[UIFont systemFontOfSize:14]];

        self.textColor = [UIColor blackColor];
        self.placeholder = @"请输入备注信息";
        //[self setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
        
//        self.background = [UIImage imageNamed:@"searchbar_textfield_background"];
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius=8;
        
        self.height = 35;
        self.width=180;
        
        //左边放大镜
        UIImageView *searchImage = [[UIImageView alloc] init];
        searchImage.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        searchImage.height = 30;
        searchImage.width = 30;
        searchImage.contentMode = UIViewContentModeCenter;
        
        self.leftView = searchImage;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}

+ (instancetype)searchBar
{
    return [[self alloc] init];
}
@end
