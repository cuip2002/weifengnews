//
//  RefreshViewController.h
//  WeiFengPriject
//
//  Created by ibokan on 13-4-30.
//  Copyright (c) 2013年 ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageViewDelegate.h"
#import "Message.h"
#import "MessageManager.h"
#import "EGORefreshTableHeaderView.h"
#import "EGORefreshTableFooterView.h"
#import "ImageManagerDelegate.h"
#import "ImageScrollView.h"
#import "BackgroundView.h"
#import "DetailViewController.h"
#import "PassNetViewController.h"
#import "Reachability.h"
#import "LoadingView.h"


@interface RefreshViewController : UIViewController<EGORefreshTableHeaderDelegate,EGORefreshTableFooterDelegate,UITableViewDataSource,UITableViewDelegate,MessageViewDelegate,ImageManagerDelegate,UIScrollViewDelegate>
{
    BOOL reloading;
    int m,n,x,scre_x;
    Reachability * hostReach;//网络异常
    LoadingView * loadingView;
}
@property (retain, nonatomic) UITableView * tableView;//表格视图
@property (retain, nonatomic) MessageManager * manager;//请求数据管理器
@property (retain, nonatomic) ImageScrollView * scroll;
@property (retain, nonatomic) UIPageControl * pageControl;
@property (retain, nonatomic) EGORefreshTableHeaderView * refreshHeaderView;
@property (retain, nonatomic) EGORefreshTableFooterView * refreshFooderView;
@property (retain, nonatomic) NSMutableArray * allMessageArray,* showMessageArr,* imageArr,* imageViewArr;

@end
