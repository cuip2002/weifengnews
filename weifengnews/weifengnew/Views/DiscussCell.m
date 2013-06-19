//
//  DiscussCell.m
//  WeiFengPriject
//
//  Created by ibokan on 13-5-2.
//  Copyright (c) 2013年 ibokan. All rights reserved.
//

#import "DiscussCell.h"
#define T_COLOR [UIColor colorWithRed:51.0f/255.0f green:51.0f/255.0f blue:51.0f/255.0f alpha:1.0]
@implementation DiscussCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        //用户图片
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(11, 10, 42, 42)];
        self.nameImage = imageView;
        imageView.image = [UIImage imageNamed:@"yonghu.png"];
        [self addSubview:imageView];
        [imageView release];
        //用户名
        UILabel * nameLab = [[UILabel alloc] initWithFrame:CGRectMake(60, 15, 60, 12)];
        nameLab.font = [UIFont italicSystemFontOfSize:12];
        self.nameLab = nameLab;
        nameLab.textColor = T_COLOR;
        nameLab.backgroundColor = [UIColor clearColor];
        [self addSubview:nameLab];
        [nameLab release];
        //用户名来自
        UILabel * nameFind = [[UILabel alloc]initWithFrame:CGRectMake(120, 15, 100, 12)];
        nameFind.font = [UIFont systemFontOfSize:12];
        nameFind.textColor = [UIColor colorWithRed:189.0f/255.0f green:189.0f/255.0f blue:189.0f/255.0f alpha:1.0];
        nameFind.text = @"(来自 牛排)";
        [self addSubview:nameFind];
        [nameFind release];
        
        //发表点评的时间
        UILabel * datelab = [[UILabel alloc] initWithFrame:CGRectMake(200, 10, 100, 15)];
        self.dateLab = datelab;
        datelab.backgroundColor = [UIColor clearColor];
        datelab.font = [UIFont italicSystemFontOfSize:12];
        [datelab setTextColor:[UIColor colorWithRed:189.0/255.0 green:189.0/255.0 blue:189.0/255.0 alpha:1.0]];
        [self addSubview:datelab];
        [datelab release];
        
        //点评的内容
        UILabel * contextLab = [[UILabel alloc] initWithFrame:CGRectMake(60, 42.5, 210, 21)];
        self.contextLab = contextLab;
        //清lable的背景色
        contextLab.backgroundColor = [UIColor clearColor];
        //设置lable的行数
        contextLab.numberOfLines = 0;
        //设置自动换行
        contextLab.lineBreakMode = NSLineBreakByCharWrapping;
        [contextLab setTextColor:[UIColor colorWithRed:119.0/255.0 green:119.0/255.0 blue:119.0/255.0 alpha:1.0]];
        [self addSubview:contextLab];
        [contextLab release];
        
        //提示框
        UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(60, 76, 100, 38)];
        self.otherImage = image;
        image.image = [UIImage imageNamed:@"sa.png"];
        [self addSubview:image];
        [image release];
        
        //顶显示
        UILabel * seLab = [[UILabel alloc] initWithFrame:CGRectMake(11, 15, 35, 11)];
        self.selectLab = seLab;
        seLab.textColor = T_COLOR;
        seLab.backgroundColor = [UIColor clearColor];
        seLab.font = [UIFont systemFontOfSize:11.0];
        [image addSubview:seLab];
        [seLab release];
        
        //中间的分隔点
        UILabel * lab1 = [[UILabel alloc] initWithFrame:CGRectMake(45, 15, 11, 11)];
        lab1.text = @"·";
        lab1.backgroundColor = [UIColor clearColor];
        [image addSubview:lab1];
        [lab1 release];
        
        //踩显示
        UILabel * notSelab = [[UILabel alloc] initWithFrame:CGRectMake(59, 15, 35, 11)];
        self.notSelectLab = notSelab;
        notSelab.textColor =T_COLOR;
        notSelab.backgroundColor = [UIColor clearColor];
        notSelab.font = [UIFont systemFontOfSize:11.0];
        [image addSubview:notSelab];
        [notSelab release];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
