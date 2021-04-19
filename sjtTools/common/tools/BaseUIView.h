//
//  BaseView.h
//  testDemo
//
//  Created by sjt on 2021/4/18.
//  Copyright © 2021 sjt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"

NS_ASSUME_NONNULL_BEGIN
IB_DESIGNABLE
@interface BaseUIView : UIView
@property(nonatomic,assign) IBInspectable CGFloat cornerRadius;
@property(nonatomic,assign) IBInspectable CGFloat borderWidth;
@property(nonatomic,assign) IBInspectable UIColor *borderColor;
@property(nonatomic,assign) IBInspectable BOOL masksToBounds;
@property(nonatomic,assign) IBInspectable CGFloat shadowRadius;
@property(nonatomic,assign) IBInspectable float shadowOpacity;
@property(nonatomic,assign) IBInspectable CGSize shadowOffset;
@property(nonatomic,assign) IBInspectable UIColor *shadowColor;


@end

///  定制化圆角
@interface BaseCornerView : BaseUIView
@property (nonatomic, assign) IBInspectable BOOL top_left;
@property (nonatomic, assign) IBInspectable BOOL top_right;
@property (nonatomic, assign) IBInspectable BOOL bottom_left;
@property (nonatomic, assign) IBInspectable BOOL bottom_right;
@property (nonatomic, assign) IBInspectable BOOL cornerAll;
@property (nonatomic, assign) UIRectCorner corners;
@end

@interface BaseUIImageView : UIImageView

@property(nonatomic,assign) IBInspectable CGFloat cornerRadius;
@property(nonatomic,assign) IBInspectable CGFloat borderWidth;
@property(nonatomic,assign) IBInspectable UIColor *borderColor;
@property(nonatomic,assign) IBInspectable BOOL masksToBounds;
@property(nonatomic,assign) IBInspectable CGFloat shadowRadius;
@property(nonatomic,assign) IBInspectable float shadowOpacity;
@property(nonatomic,assign) IBInspectable CGSize shadowOffset;
@property(nonatomic,assign) IBInspectable UIColor *shadowColor;

@end
///  定制化圆角
@interface BaseCornerImageView : BaseUIImageView
@property (nonatomic, assign) IBInspectable BOOL top_left;
@property (nonatomic, assign) IBInspectable BOOL top_right;
@property (nonatomic, assign) IBInspectable BOOL bottom_left;
@property (nonatomic, assign) IBInspectable BOOL bottom_right;
@property (nonatomic, assign) IBInspectable BOOL cornerAll;
@property (nonatomic, assign) UIRectCorner corners;
@end

@interface BaseUILabel : UILabel
@property(nonatomic,assign) IBInspectable CGFloat cornerRadius;
@property(nonatomic,assign) IBInspectable CGFloat borderWidth;
@property(nonatomic,assign) IBInspectable UIColor *borderColor;
@property(nonatomic,assign) IBInspectable BOOL masksToBounds;
@property(nonatomic,assign) IBInspectable CGFloat shadowRadius;
@property(nonatomic,assign) IBInspectable float shadowOpacity;
@property(nonatomic,assign) IBInspectable CGSize shadowOffset;
@property(nonatomic,assign) IBInspectable UIColor* shadowColors;
@property (nonatomic, assign) UIEdgeInsets padding;

@property (nonatomic, assign) IBInspectable CGFloat top_padding;
@property (nonatomic, assign) IBInspectable CGFloat left_padding;
@property (nonatomic, assign) IBInspectable CGFloat right_padding;
@property (nonatomic, assign) IBInspectable CGFloat bottom_padding;

@end
@interface BaseCornerLabel : BaseUILabel
@property (nonatomic, assign) IBInspectable BOOL top_left;
@property (nonatomic, assign) IBInspectable BOOL top_right;
@property (nonatomic, assign) IBInspectable BOOL bottom_left;
@property (nonatomic, assign) IBInspectable BOOL bottom_right;
@property (nonatomic, assign) IBInspectable BOOL cornerAll;
@property (nonatomic, assign) UIRectCorner corners;
@end

@interface BaseUIButton : UIButton
@property(nonatomic,assign) IBInspectable CGFloat cornerRadius;
@property(nonatomic,assign) IBInspectable CGFloat borderWidth;
@property(nonatomic,assign) IBInspectable UIColor *borderColor;
@property(nonatomic,assign) IBInspectable BOOL masksToBounds;
@property(nonatomic,assign) IBInspectable CGFloat shadowRadius;
@property(nonatomic,assign) IBInspectable float shadowOpacity;
@property(nonatomic,assign) IBInspectable CGSize shadowOffset;
@property(nonatomic,assign) IBInspectable UIColor *shadowColor;

@property(nonatomic,assign) BOOL isSelectImg;


@end

@interface BaseCornerButton : BaseUIButton
@property (nonatomic, assign) IBInspectable BOOL top_left;
@property (nonatomic, assign) IBInspectable BOOL top_right;
@property (nonatomic, assign) IBInspectable BOOL bottom_left;
@property (nonatomic, assign) IBInspectable BOOL bottom_right;
@property (nonatomic, assign) IBInspectable BOOL cornerAll;
@property (nonatomic, assign) UIRectCorner corners;
@end

@interface BaseUITextField : UITextField
@property(nonatomic,assign) IBInspectable CGFloat cornerRadius;
@property(nonatomic,assign) IBInspectable CGFloat borderWidth;
@property(nonatomic,assign) IBInspectable UIColor *borderColor;
@property(nonatomic,assign) IBInspectable BOOL masksToBounds;
@property(nonatomic,assign) IBInspectable CGFloat shadowRadius;
@property(nonatomic,assign) IBInspectable float shadowOpacity;
@property(nonatomic,assign) IBInspectable CGSize shadowOffset;
@property(nonatomic,assign) IBInspectable UIColor *shadowColor;
@property (nonatomic, assign)IBInspectable float fixFont;
@property (nonatomic, assign) IBInspectable float placeholderFont;
@property (nonatomic, strong) IBInspectable NSString *placeholderColor;
@property (nonatomic, strong) NSDictionary *attPlaceholder;
-(void)attPlaceholderFont:(UIFont *)font placeholderColor:(UIColor *)color;
@end

@interface BaseCornerTextField : BaseUITextField
@property (nonatomic, assign) IBInspectable BOOL top_left;
@property (nonatomic, assign) IBInspectable BOOL top_right;
@property (nonatomic, assign) IBInspectable BOOL bottom_left;
@property (nonatomic, assign) IBInspectable BOOL bottom_right;
@property (nonatomic, assign) IBInspectable BOOL cornerAll;
@property (nonatomic, assign) UIRectCorner corners;
@end

@interface BaseUITextView : UITextView
@property(nonatomic,assign) IBInspectable CGFloat cornerRadius;
@property(nonatomic,assign) IBInspectable CGFloat borderWidth;
@property(nonatomic,assign) IBInspectable UIColor *borderColor;
@property(nonatomic,assign) IBInspectable BOOL masksToBounds;
@property(nonatomic,assign) IBInspectable CGFloat shadowRadius;
@property(nonatomic,assign) IBInspectable float shadowOpacity;
@property(nonatomic,assign) IBInspectable CGSize shadowOffset;
@property(nonatomic,assign) IBInspectable UIColor *shadowColor;

@end

@interface BaseCornerTextView : BaseUITextView
@property (nonatomic, assign) IBInspectable BOOL top_left;
@property (nonatomic, assign) IBInspectable BOOL top_right;
@property (nonatomic, assign) IBInspectable BOOL bottom_left;
@property (nonatomic, assign) IBInspectable BOOL bottom_right;
@property (nonatomic, assign) IBInspectable BOOL cornerAll;
@property (nonatomic, assign) UIRectCorner corners;
@end

@interface BaseUIScrollView : UIScrollView
@property(nonatomic,assign) IBInspectable CGFloat cornerRadius;
@property(nonatomic,assign) IBInspectable CGFloat borderWidth;
@property(nonatomic,assign) IBInspectable UIColor *borderColor;
@property(nonatomic,assign) IBInspectable BOOL masksToBounds;
@property(nonatomic,assign) IBInspectable CGFloat shadowRadius;
@property(nonatomic,assign) IBInspectable float shadowOpacity;
@property(nonatomic,assign) IBInspectable CGSize shadowOffset;
@property(nonatomic,assign) IBInspectable UIColor *shadowColor;

-(void)endRefresh;

@end

@interface BaseCornerScrollView : BaseUIScrollView
@property (nonatomic, assign) IBInspectable BOOL top_left;
@property (nonatomic, assign) IBInspectable BOOL top_right;
@property (nonatomic, assign) IBInspectable BOOL bottom_left;
@property (nonatomic, assign) IBInspectable BOOL bottom_right;
@property (nonatomic, assign) IBInspectable BOOL cornerAll;
@property (nonatomic, assign) UIRectCorner corners;
@end


@interface BaseUICollectionView : UICollectionView
@property(nonatomic,assign) IBInspectable CGFloat cornerRadius;
@property(nonatomic,assign) IBInspectable CGFloat borderWidth;
@property(nonatomic,assign) IBInspectable UIColor *borderColor;
@property(nonatomic,assign) IBInspectable BOOL masksToBounds;
@property(nonatomic,assign) IBInspectable CGFloat shadowRadius;
@property(nonatomic,assign) IBInspectable float shadowOpacity;
@property(nonatomic,assign) IBInspectable CGSize shadowOffset;
@property(nonatomic,assign) IBInspectable UIColor *shadowColor;

@end

@interface BaseCornerCollectionView : BaseUICollectionView
@property (nonatomic, assign) IBInspectable BOOL top_left;
@property (nonatomic, assign) IBInspectable BOOL top_right;
@property (nonatomic, assign) IBInspectable BOOL bottom_left;
@property (nonatomic, assign) IBInspectable BOOL bottom_right;
@property (nonatomic, assign) IBInspectable BOOL cornerAll;
@property (nonatomic, assign) UIRectCorner corners;
@end


@interface BaseUITableView : UITableView

@property(nonatomic,assign) IBInspectable CGFloat cornerRadius;
@property(nonatomic,assign) IBInspectable CGFloat borderWidth;
@property(nonatomic,assign) IBInspectable UIColor *borderColor;
@property(nonatomic,assign) IBInspectable BOOL masksToBounds;
@property(nonatomic,assign) IBInspectable CGFloat shadowRadius;
@property(nonatomic,assign) IBInspectable float shadowOpacity;
@property(nonatomic,assign) IBInspectable CGSize shadowOffset;
@property(nonatomic,assign) IBInspectable UIColor *shadowColor;
@property (nonatomic, assign) NSInteger page; 
- (void)initHeaderRefresh;
- (void)initFooterRefresh;
-(void)endRefresh;
- (void)initRefresh;
-(void)beginRefreshing;
@end

@interface BaseCornerTableView : BaseUITableView
@property (nonatomic, assign) IBInspectable BOOL top_left;
@property (nonatomic, assign) IBInspectable BOOL top_right;
@property (nonatomic, assign) IBInspectable BOOL bottom_left;
@property (nonatomic, assign) IBInspectable BOOL bottom_right;
@property (nonatomic, assign) IBInspectable BOOL cornerAll;
@property (nonatomic, assign) UIRectCorner corners;
@end

@interface BaseGestureTableView : BaseUITableView
@end
@interface BaseUITableViewCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;
+(instancetype)cellWithTableView:(UITableView *)tableView identifier:(NSString *)identifier;
+ (instancetype)xibCellWithTableView:(UITableView *)tableView;
+ (instancetype)xibCellWithTableView:(UITableView *)tableView identifier:(NSString *)identifier;
+ (instancetype)xibCellWithTableView:(UITableView *)tableView index:(NSInteger)index;
+ (NSString*)reuseIdentifier;
-(void)setup;
@property (nonatomic, strong) NSIndexPath *indexPath;
@end

@interface BaseUICollectionViewCell : UICollectionViewCell

@end
NS_ASSUME_NONNULL_END
