//
//  DetailViewController.h
//  WeiFengPriject
//
//  Created by ibokan on 13-5-1.
//  Copyright (c) 2013年 ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailManagerDelegate.h"
#import "Message.h"
#import "NewsDetailView.h"
#import "ImageManagerDelegate.h"
#import "DiscussManagerDelegate.h"
#import "DiscussCell.h"
#import "Comment.h"
#import "DetailManager.h"
#import "ImageManager.h"
#import "DiscussManager.h"

@interface DetailViewController : UIViewController<DetailManagerDelegate,ImageManagerDelegate,DiscussManagerDelegate,UITableViewDelegate,UITableViewDataSource>

@property (copy, nonatomic)NSString * context,* comeString;
@property (retain, nonatomic)Message * mess;
@property (copy, nonatomic) NSString * title;
@property (copy, nonatomic) NSString * discussID;//新闻的ID
@property (retain, nonatomic) NewsDetailView * newsDetailView;
@property (retain, nonatomic) NSMutableArray * discummArray;
@property (retain, nonatomic) UITableView * tableView;
@property (retain, nonatomic) NSMutableArray * showDisArr;
@property (retain, nonatomic) UIButton * showButton;
@property (retain, nonatomic) UILabel * disTitle;
@property (retain, nonatomic) NSMutableArray * messageArray;
@property (retain, nonatomic) DetailManager * manager;
@property (retain, nonatomic) ImageManager * imageManager;
@property (retain, nonatomic) DiscussManager * disCussManager;

@end
