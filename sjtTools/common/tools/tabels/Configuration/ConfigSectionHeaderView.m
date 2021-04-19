//
//  ParameterSectionHeaderView.m
//  antQueen
//
//  Created by 寇广超 on 2019/5/30.
//  Copyright © 2019 yibyi. All rights reserved.
//

#import "ConfigSectionHeaderView.h"

@implementation ConfigSectionHeaderView
{
    /// 标题
    __weak IBOutlet UILabel *_title;
    /// 向下箭头
    __weak IBOutlet UIImageView *_arrow;
}

-(void)awakeFromNib {
    [super awakeFromNib];
}

+ (instancetype)creatView {
    return [[[NSBundle mainBundle] loadNibNamed:@"ConfigSectionHeaderView" owner:self options:nil] objectAtIndex:0];
}
- (IBAction)unfoldClick:(id)sender {
    !_unfoldBlock ? :_unfoldBlock();
}


@end
