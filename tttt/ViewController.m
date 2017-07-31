//
//  ViewController.m
//  tttt
//
//  Created by Yong Yang on 2017/7/31.
//  Copyright © 2017年 wly. All rights reserved.
//

#import "ViewController.h"

#define random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]
#define randomColor random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))


static int lineWidth = 40;
static int spacing = 70;
static int pageWidth = 300.0;

@interface ViewController ()<UIScrollViewDelegate>

@property (nonatomic, retain) UIView *lineView;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) NSArray *centerArr;
@property (nonatomic, assign) NSInteger currentPage;

@property (nonatomic, assign) NSInteger location1;
@property (nonatomic, assign) NSInteger location2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _centerArr = @[@70,@140,@210,@280];
    
    _lineView = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 40, 3)];
    _lineView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_lineView];
    
    _location1 = CGRectGetMinX(_lineView.frame);
    _location2 = CGRectGetMaxX(_lineView.frame);
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 100, 300 , 400)];
    _scrollView.contentSize = CGSizeMake(300 * 4, 400);
    _scrollView.pagingEnabled = YES;
    
    for (int i = 0; i < 4; i ++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(i * 300, 0, 300, 400)];
        view.backgroundColor = randomColor;
        [_scrollView addSubview:view];
    }
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20, 200, 100, 50)];
    btn.backgroundColor = [UIColor orangeColor];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
}
- (void)btnClick {
    
    if (_scrollView.contentOffset.x == pageWidth * 3) {
        
            _scrollView.contentOffset = CGPointMake(0, 0);
        _lineView.frame = CGRectMake(50, 50, 40, 3);
        
    } else {
        [UIView animateWithDuration:2 animations:^{
        _scrollView.contentOffset = CGPointMake(_scrollView.contentOffset.x + pageWidth, 0);
        }];
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    float remainder = scrollView.contentOffset.x  - pageWidth * _currentPage;
 
    if (remainder == 0) {
        return;
    }
    
    if (remainder < pageWidth/2 ) {
        float halfPageWidth = pageWidth / 2.0;
        float halfLineWidth = lineWidth / 2.0;
        NSLog(@"动画1 %f",remainder / halfPageWidth);
        float inscert1 = (remainder / halfPageWidth) * halfLineWidth;
        float inscert2 = (remainder / halfPageWidth) * (spacing - lineWidth);
        _lineView.frame = CGRectMake(_location1 + inscert1, 50, lineWidth + inscert2, 3);
    
    } else if (remainder == pageWidth/2 ) {
        _lineView.frame = CGRectMake([_centerArr[_currentPage] floatValue] - (lineWidth /2), 50, spacing, 3);
    } else
    {
        NSLog(@"动画2 %f",remainder / (pageWidth/2.0));
        float inscert1 = ((remainder / (pageWidth/2.0)) -1) * (spacing - lineWidth);
        float inscert2 = ((remainder / (pageWidth/2.0)) -1) * (lineWidth / 2);
        _lineView.frame = CGRectMake([_centerArr[_currentPage] floatValue] + inscert1, 50, spacing - inscert2, 3);
        
    }
   
 
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    _currentPage = _scrollView.contentOffset.x / pageWidth;
    NSLog(@"endend %ld",(long)_currentPage);
    _lineView.frame = CGRectMake( [_centerArr[_currentPage] floatValue] - (lineWidth/2), 50, lineWidth, 3);
    _location1 = CGRectGetMinX(_lineView.frame);
    _location2 = CGRectGetMaxX(_lineView.frame);
}

- (void)anim1 {
}

- (void)anim2 {
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
