//
//  ParameterCompareHeaderView.h
//  antQueen
//
//  Created by 寇广超 on 2019/5/30.
//  Copyright © 2019 yibyi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ParameterClickBlock)();
typedef void(^SegmentClickBlock)(NSInteger index);

@interface CompareHiddenHeader : UIView

@property (nonatomic, copy) ParameterClickBlock hiddenBlock;


+ (instancetype)creatView;

@end

@interface CompareRightHeader : UIView
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

@property (weak, nonatomic) IBOutlet UILabel *modelNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (nonatomic, copy) ParameterClickBlock deleteBlock;
@property (nonatomic, copy) ParameterClickBlock selectBlock;

+ (instancetype)creatView;

@end

@interface CompareAddHeader : UIView

@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (nonatomic, copy) ParameterClickBlock addBlock;

+ (instancetype)creatView;

@end

@interface CompareDifferentHeader : UIView


@property (nonatomic, copy) SegmentClickBlock compareBlock;

+ (instancetype)creatView;

@end
