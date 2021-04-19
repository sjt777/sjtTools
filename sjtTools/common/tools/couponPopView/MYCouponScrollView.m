//
//  MYCouponScrollView.m
//  antQueen
//
//  Created by 寇广超 on 2019/4/9.
//  Copyright © 2019 yibyi. All rights reserved.
//

#import "MYCouponScrollView.h"
#import "MYCoponPageControl.h"

@interface MYCouponScrollView () <UIScrollViewDelegate>

@property BOOL hasTimer;
@property (nonatomic, assign) NSUInteger interval;

@property (nonatomic, strong) UIImage *placeHolder;

@property (nonatomic, strong) NSArray * imageArray;

@property (nonatomic, strong) UIScrollView *wheelScrollView;        // scrollView
//@property (nonatomic, strong) UIPageControl *wheelPageControl;      // pageControl
@property (nonatomic, strong) MYCoponPageControl *wheelPageControl;      // pageControl


@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSUInteger currentImageIndex;

@property (nonatomic, strong) UIImageView *image1;
@property (nonatomic, strong) UIImageView *image2;
@property (nonatomic, strong) UIImageView *image3;

@property (nonatomic, assign) NSUInteger imageNum;

@property (nonatomic, strong) UIImageView *mask;
@property (nonatomic, assign) BOOL isLocal;

@end
@implementation MYCouponScrollView

#pragma mark - init
+ (instancetype)initWithFrame:(CGRect)frame
                    withArray:(NSArray*)array
                     hasTimer:(BOOL)hastimer
                     interval:(NSUInteger)inter
{
    MYCouponScrollView * carousel = [[MYCouponScrollView alloc] initWithFrame:frame];
    carousel.hasTimer = hastimer;
    carousel.interval = inter;
    
    [carousel setupWithArray:array];
    return carousel;
}

+ (instancetype)initWithFrame:(CGRect)frame
                     hasTimer:(BOOL)hastimer
                     interval:(NSUInteger)inter
                  placeHolder:(UIImage*)image
{
    MYCouponScrollView * carousel = [[MYCouponScrollView alloc] initWithFrame:frame];
    carousel.placeHolder = image;
    carousel.hasTimer = hastimer;
    carousel.interval = inter;
    carousel.mask.image = image;
    
    
    return carousel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.mask = [[UIImageView alloc] initWithFrame:frame];
        [self addSubview:self.wheelScrollView];
        [self addSubview:self.wheelPageControl];
        [self addSubview:self.mask];
        self.wheelScrollView.scrollEnabled = NO;
    }
    return self;
}


- (void)setupWithArray:(NSArray *)array
{
    self.wheelScrollView.scrollEnabled = YES;
    self.mask.hidden = YES;
    self.imageArray = array;
    self.imageNum = self.imageArray.count;
    self.currentImageIndex = 0;
    
    if (self.imageNum == 1) {
        self.hasTimer = NO;
        self.wheelPageControl.hidden = YES;
        self.wheelScrollView.scrollEnabled = NO;
    }
    
    [self setup];
}

- (void)setupWithLocalArray:(NSArray *)array
{
    self.isLocal = YES;
    self.wheelScrollView.scrollEnabled = YES;
    self.mask.hidden = YES;
    self.imageArray = array;
    self.imageNum = self.imageArray.count;
    self.currentImageIndex = 0;
    
    if (self.imageNum == 1) {
        self.hasTimer = NO;
        self.wheelPageControl.hidden = YES;
        self.wheelScrollView.scrollEnabled = NO;
    }
    
    [self setup];
}

/**
 *  初始化，启动定时器；轮播图片
 */
- (void)setup
{

    if (self.hasTimer) {
        [self setupTimer];
    }
    [self updateImage];
}

/**
 *  图片更新
 */
- (void)updateImage
{
    self.imageNum = (int)self.imageArray.count;
    self.wheelPageControl.numberOfPages = self.imageNum;
    
    [self updateScrollImage];
}



- (void)updateScrollImage
{
    int left;
    int right;
    
    // 计算页数
    int page = self.wheelScrollView.contentOffset.x / self.wheelScrollView.frame.size.width;
    if (page == 0)
    {
        // 计算当前图片索引
        self.currentImageIndex = (self.currentImageIndex + self.imageNum - 1) % self.imageNum;   // %限定当前索引不越界；
    }
    else if(page == 2)
    {
        // 计算当前图片索引
        self.currentImageIndex = (self.currentImageIndex + 1) % self.imageNum;
    }
    
    // 当前图片左右索引
    left = (int)(self.currentImageIndex + self.imageNum - 1) % self.imageNum;
    right = (int)(self.currentImageIndex + 1) % self.imageNum;
    
    // 更换UIImage
    if (self.isLocal)
    {
        self.image1.image = [UIImage imageNamed:self.imageArray[left]];
        self.image2.image = [UIImage imageNamed:self.imageArray[self.self.currentImageIndex]];
        self.image3.image = [UIImage imageNamed:self.imageArray[right]];
    }
    else
    {
        [self.image1 sd_setImageWithURL:[NSURL URLWithString:self.imageArray[left]]  placeholderImage:self.placeHolder options: SDWebImageAllowInvalidSSLCertificates];
        [self.image2 sd_setImageWithURL:[NSURL URLWithString:self.imageArray[self.currentImageIndex]] placeholderImage:self.placeHolder options: SDWebImageAllowInvalidSSLCertificates];
        [self.image3 sd_setImageWithURL:[NSURL URLWithString:self.imageArray[right]] placeholderImage:self.placeHolder];
    }
    
    self.wheelPageControl.currentPage = self.currentImageIndex;
    [self.wheelScrollView setContentOffset:CGPointMake(self.wheelScrollView.frame.size.width, 0) animated:NO];
}

#pragma mark - NSTimer
- (void)setupTimer
{
    if (self.interval == 0)
    {
        self.interval = 3;
    }
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.interval target:self selector:@selector(updateWheel) userInfo:nil repeats:YES];
    
    // 避免tableview滚动时，定时器停止；
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)updateWheel
{
    CGPoint offset = self.wheelScrollView.contentOffset;
    offset.x += self.wheelScrollView.frame.size.width;
    [self.wheelScrollView setContentOffset:offset animated:YES];
}



- (void)destroy
{
    [self.timer invalidate];
}

#pragma mark - UIScrollView
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self updateScrollImage];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self updateScrollImage];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.timer invalidate];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self setupTimer];
}


- (void)touchAction
{
    if ([self.delegate respondsToSelector:@selector(carouselTouch:atIndex:)]) {
        [self.delegate carouselTouch:self atIndex:self.currentImageIndex];
    }
    
    // 使用block的回调
    if (self.bannerTouchBlock)
    {
        self.bannerTouchBlock(self.currentImageIndex);
    }
}

#pragma mark - Getter

- (UIScrollView *)wheelScrollView
{
    if (!_wheelScrollView)
    {
        _wheelScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _wheelScrollView.backgroundColor = [UIColor clearColor];
        _wheelScrollView.pagingEnabled = YES;
        _wheelScrollView.delegate = self;
        _wheelScrollView.showsHorizontalScrollIndicator = NO;
        _wheelScrollView.showsVerticalScrollIndicator = NO;
        _wheelScrollView.backgroundColor = UIColor.clearColor;
        // 添加点击事件
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchAction)];
        [_wheelScrollView addGestureRecognizer:tap];
        
        // 使用3个UIImageView，
        _image1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _image2 = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
        _image3 = [[UIImageView alloc] initWithFrame:CGRectMake(2*self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
        _image2.image = self.placeHolder;
        
        for (UIImageView * img in @[_image1,_image2,_image3]) {
            img.backgroundColor = UIColor.clearColor;
            [_wheelScrollView addSubview:img];
        }
        
        [_wheelScrollView setContentOffset:CGPointMake(self.frame.size.width, 0) animated:NO];
        _wheelScrollView.scrollEnabled = YES;
        _wheelScrollView.contentSize = CGSizeMake(3*self.frame.size.width, self.frame.size.height);
    }
    return _wheelScrollView;
}

- (MYCoponPageControl *)wheelPageControl
{
    if (!_wheelPageControl)
    {
        _wheelPageControl = [[MYCoponPageControl alloc] init];
        _wheelPageControl.frame = CGRectMake(0, CGRectGetMaxY(self.frame) - 20, CGRectGetMaxX(self.frame), 10);
        [_wheelPageControl setBackgroundColor:[UIColor clearColor]];
        _wheelPageControl.currentPage = 0;
        _wheelPageControl.numberOfPages = self.imageNum;
        _wheelPageControl.userInteractionEnabled = NO;
        _wheelPageControl.inactiveImage = [self createImageWithColor:hexColor(f2f2f2)];
        _wheelPageControl.inactiveImageSize = CGSizeMake(10, 10);
        _wheelPageControl.inactiveRadius = 5;
        _wheelPageControl.currentImage = [self createImageWithColor:hexColor(ff773a)];
        _wheelPageControl.currentImageSize = CGSizeMake(10,10);
        _wheelPageControl.currentRadius = 5;
        _wheelPageControl.magrin = 10;
        //_wheelPageControl.centerX = self.frame.size.width * 0.5;
        //_wheelPageControl.y = CGRectGetMaxY(self.frame) - 20;
        //_wheelPageControl.height = 10;

    }
    
    return _wheelPageControl;
}
- (UIImage*)createImageWithColor:(UIColor*)color{
    CGRect rect=CGRectMake(0.0f,0.0f,1.0f,1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage*theImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
@end
