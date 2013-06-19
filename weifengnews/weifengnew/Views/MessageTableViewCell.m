//
//  MessageTableViewCell.m
//  WeiFengNews
//
//  Created by ibokan on 13-4-25.
//  Copyright (c) 2013年 ibokan. All rights reserved.
//

#define NOTSELECT_TEXT_COLOR     [UIColor colorWithRed:52.0/255.0 green:58.0/255.0 blue:73.0/255.0 alpha:1.0]
#define NOTSELECT_DATELAB_COLOR  [UIColor colorWithRed:121.0/255.0 green:123.0/255.0 blue:141.0/255.0 alpha:1.0]

#import "MessageTableViewCell.h"

@implementation MessageTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //设置行的背景
        UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 65)];
        bgView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cell_bg.png"]];
        [self addSubview:bgView];
        
        
        // Initialization code
        //每行显示的新闻内容
        UILabel * title = [[UILabel alloc] initWithFrame:CGRectMake(28, 13, 250, 15)];
        self.titleLab = title;
        title.backgroundColor = [UIColor clearColor];
        title.font = [UIFont systemFontOfSize:14];
        [title setTextColor:NOTSELECT_TEXT_COLOR];
        [bgView addSubview:title];
        [title release];
        
        //新闻的类型
        UILabel * type = [[UILabel alloc] initWithFrame:CGRectMake(28, 41, 150, 11)];
        self.browseAndTypeLab = type;
        type.backgroundColor = [UIColor clearColor];
        type.font = [UIFont systemFontOfSize:11];
        [type setTextColor:NOTSELECT_DATELAB_COLOR];
        [bgView addSubview:type];
        [type release];
        
        //新闻的发布时间
        UILabel * date = [[UILabel alloc] initWithFrame:CGRectMake(221, 41, 100, 11)];
        self.dateLab = date;
        date.backgroundColor = [UIColor clearColor];
        date.font = [UIFont systemFontOfSize:11];
        [date setTextColor:NOTSELECT_DATELAB_COLOR];
        [bgView addSubview:date];
        [date release];
        
        //按钮
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(285, 30, 13, 15)];
        imageView.image = [UIImage imageNamed:@"cell_accessory.png"];
        [bgView addSubview:imageView];
        [imageView release];
        [bgView release];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
