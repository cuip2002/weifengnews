//
//  DiscussCell.h
//  WeiFengPriject
//
//  Created by ibokan on 13-5-2.
//  Copyright (c) 2013年 ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiscussCell : UITableViewCell

@property (retain, nonatomic)UIImageView * nameImage;
@property (retain, nonatomic) UILabel * nameLab;
@property (retain, nonatomic) UILabel * dateLab;
@property (retain, nonatomic) UILabel * contextLab;
@property (retain, nonatomic) UIImageView * otherImage;
@property (retain, nonatomic) UILabel * selectLab;
@property (retain, nonatomic) UILabel * notSelectLab;

@end
