//
//  NewsDetailView.h
//  WeiFeng
//
//  Created by ibokan on 13-4-28.
//  Copyright (c) 2013年 ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewsDetailViewController;

@interface NewsDetailView : UIView<UIScrollViewDelegate>

@property (retain,nonatomic)UIScrollView * scrollView;

@property (retain,nonatomic)UIView * contentView;//内容视图
@property (retain,nonatomic)UIView *commentView;//评论视图

@property (retain, nonatomic) UILabel * theme;//标题

@property (retain, nonatomic) UILabel * source;//来源

@property (retain, nonatomic) UILabel * subTitle;//子标题

@property (retain, nonatomic) UIImageView * imageView;

@property (retain, nonatomic) UILabel * content;//新闻的内容

@property (retain,nonatomic)UILabel * moreLable;//更多精彩
@property (retain,nonatomic)UIButton * webSite;//网址





@property (retain,nonatomic)NewsDetailViewController * newsDetail;
@end
