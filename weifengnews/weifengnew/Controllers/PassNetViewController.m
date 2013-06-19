//
//  PassNetViewController.m
//  WeiFengPriject
//
//  Created by ibokan on 13-5-1.
//  Copyright (c) 2013年 ibokan. All rights reserved.
//

#import "PassNetViewController.h"
#import "TitleView.h"
#import "MessageManager.h"
#define VIEW_COLOR   [UIColor colorWithRed:209.0/255.0 green:215.0/255.0 blue:223.0/255.0 alpha:1.0]
#define TEXT_COLOR   [UIColor colorWithRed:164.0/255.0 green:164.0/255.0 blue:164.0/255.0 alpha:1.0]

@interface PassNetViewController ()

@end

@implementation PassNetViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    TitleView * bgView = [[TitleView alloc] initWithFrame:CGRectMake(0, 0, 320*VIEW_FRAME_WIDTH, 44*VIEW_FRAME_HEIGHT)];
    [self.view addSubview:bgView];
    self.view.backgroundColor = VIEW_COLOR;
    
    UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(120, 180, 80, 80)];
    image.image = [UIImage imageNamed:@"no_network.png"];
    image.userInteractionEnabled = YES;
    [self.view addSubview:image];
    
    UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(100, 260, 120, 16)];
    lab.text = @"网络连接失败";
    lab.backgroundColor = [UIColor clearColor];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.font = [UIFont boldSystemFontOfSize:16];
    [lab setTextColor:TEXT_COLOR];
    [self.view addSubview:lab];
    
    UILabel * dongLab = [[UILabel alloc] initWithFrame:CGRectMake(60, 269, 200, 16)];
    dongLab.text = @"请点击屏幕，刷新重试";
    dongLab.backgroundColor = [UIColor clearColor];
    dongLab.textAlignment = NSTextAlignmentCenter;
    [dongLab setTextColor:TEXT_COLOR];
    dongLab.font = [UIFont boldSystemFontOfSize:16];
    [self.view addSubview:dongLab];
    
    UITapGestureRecognizer * tapGusture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    tapGusture.numberOfTapsRequired = 1;
    //           tapGusture.numberOfTouchesRequired = 2;
    [self.view addGestureRecognizer:tapGusture];
    [tapGusture release];
    [image release];
    [dongLab release];
    [lab release];
    [bgView release];
	// Do any additional setup after loading the view.
}

#pragma mark--- 
- (void)tapAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
