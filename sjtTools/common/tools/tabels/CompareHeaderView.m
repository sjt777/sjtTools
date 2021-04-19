//
//  ParameterCompareHeaderView.m
//  antQueen
//
//  Created by 寇广超 on 2019/5/30.
//  Copyright © 2019 yibyi. All rights reserved.
//

#import "CompareHeaderView.h"

@implementation CompareHiddenHeader
{
    __weak IBOutlet UILabel *_promptLabel;
}

+ (instancetype)creatView {
    
    return [[[NSBundle mainBundle] loadNibNamed:@"CompareHeaderView" owner:self options:nil] objectAtIndex:0];
}

- (IBAction)hidden:(UIButton *)sender {

}

@end

@implementation CompareRightHeader

- (void)awakeFromNib {
    [super awakeFromNib];

}

+ (instancetype)creatView {
    return [[[NSBundle mainBundle] loadNibNamed:@"CompareHeaderView" owner:self options:nil] objectAtIndex:1];
}
- (IBAction)selectedClick:(id)sender {
    if (self.selectBlock) {
        self.selectBlock();
    }
}

- (IBAction)delete:(UIButton *)sender {
    if (self.deleteBlock) {
        self.deleteBlock();
    }
}

@end

@implementation CompareAddHeader

+ (instancetype)creatView {
    return [[[NSBundle mainBundle] loadNibNamed:@"CompareHeaderView" owner:self options:nil] objectAtIndex:2];
}

- (IBAction)add:(UIButton *)sender {
    if (self.addBlock) {
        self.addBlock();
    }
}

@end
@implementation CompareDifferentHeader

+ (instancetype)creatView {
    return [[[NSBundle mainBundle] loadNibNamed:@"CompareHeaderView" owner:self options:nil] objectAtIndex:3];
}
- (IBAction)segmentControlClick:(UISegmentedControl *)sender {
    NSInteger index = sender.selectedSegmentIndex;

    if (self.compareBlock) {
        self.compareBlock(index);
    }
}


@end
