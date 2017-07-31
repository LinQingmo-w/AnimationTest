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

@interface ViewController ()<UIScrollViewDelegate>

@property (nonatomic, retain) UIView *lineView;
@property (nonatomic, retain) UIScrollView *scrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(50, 50, lineWidth, 3)];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    
    
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 100, 375 , 400)];
    _scrollView.contentSize = CGSizeMake(375 * 4, 400);
    _scrollView.pagingEnabled = YES;
    
    for (int i = 0; i < 4; i ++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(i * 375, 0, 375, 400)];
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
    
    if (_scrollView.contentOffset.x == 375 * 3) {
        
            _scrollView.contentOffset = CGPointMake(0, 0);
        _lineView.frame = CGRectMake(50, 50, 40, 3);
        
    } else {
        [UIView animateWithDuration:2 animations:^{
        _scrollView.contentOffset = CGPointMake(_scrollView.contentOffset.x + 375, 0);
        }];
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int remainder = (int)scrollView.contentOffset.x % 375;
    
 
    
//    if (remainder <= 375/2 && remainder > 3) {
//        NSLog(@"动画1");
//
//    
//    } else {
//        NSLog(@"动画2");
//        
//    }
   
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    NSLog(@"didEnd");
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
