//
//  BNMe_RootViewController.m
//  zyx
//
//  Created by gusijian on 16/4/2.
//  Copyright © 2016年 gusijian. All rights reserved.
//

#import "BNMe_RootViewController.h"
#import "BNNetAPIManager.h"
#import "BNLoginViewController.h"

@interface BNMe_RootViewController ()<UITableViewDataSource,UITableViewDelegate>
/** table view*/
@property(nonatomic,strong) UITableView * mainTableView;
/** table header*/
@property(nonatomic,strong) UIView * tableHeaderView;
/** user icon*/
@property(nonatomic,strong) UIButton * userIconView;
/** table footer*/
@property(nonatomic,strong) UIView * tableFooterView;
/** table backgroundview*/
@property(nonatomic,strong) UIImageView * tableBackgroudView;
@end

@implementation BNMe_RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    _mainTableView=({
        UITableView * tv=[[UITableView alloc]initWithFrame:kScreen_Bounds2 style:UITableViewStyleGrouped];
        tv.delegate=self;
        tv.dataSource=self;
        tv.tableHeaderView=self.tableHeaderView;
        tv.separatorStyle=UITableViewCellSeparatorStyleNone;
        //tv.backgroundView=self.tableBackgroudView;
        tv.bounces=NO;
        [self.view addSubview:tv];
        tv;
    });
    //
    UIButton * btnLogin=[[UIButton alloc]init];
    [btnLogin setTitle:@"show login" forState:UIControlStateNormal];
    [self.view addSubview:btnLogin];
    [btnLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view).width.mas_equalTo(100).height.mas_equalTo(20);
    }];
    [btnLogin addTarget:self action:@selector(onShowLogin) forControlEvents:UIControlEventTouchUpInside];
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark table view compoment
-(UIView *)tableHeaderView{
    if(!_tableHeaderView){
        _tableHeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 200)];
        _tableHeaderView.backgroundColor=[UIColor redColor];
        [_tableHeaderView addSubview:self.userIconView];
        [self.userIconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(100);
            make.center.mas_equalTo(_tableHeaderView);
        }];
        UIButton * btnSetting=[[UIButton alloc]init];
        [btnSetting setImage:[UIImage imageNamed:@"settingBtn_Nav"] forState:UIControlStateNormal];
        [_tableHeaderView addSubview:btnSetting];
        [btnSetting mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(40);
            make.height.mas_equalTo(40);
            make.top.mas_equalTo(_tableHeaderView).mas_offset(20);
            make.right.mas_equalTo(_tableHeaderView).mas_offset(0);
        }];
    }
    return _tableHeaderView;
}
-(UIButton *)userIconView{
    if(!_userIconView){
        _userIconView=[[UIButton alloc]init];
        //UIImageView * image=[[UIImageView alloc]init];
        //todo check if login
        NSString* imageName=@"AppIcon120x120";
        if([Login isLogin]){
            imageName=@"coding_emoji_06";
        }
        _userIconView.layer.masksToBounds=YES;
        _userIconView.layer.cornerRadius=50;
        [_userIconView setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [_userIconView addTarget:self action:@selector(onUserIconClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _userIconView;
}
-(UIView *)tableFooterView{
    if(!_tableFooterView){
        _tableFooterView=[[UIView alloc]init];
    }
    return _tableFooterView;
}
-(UIImageView *)tableBackgroudView{
if(!_tableBackgroudView)
{
    _tableBackgroudView=[[UIImageView alloc]initWithFrame:kScreen_Bounds];
    _tableBackgroudView.image=[UIImage imageNamed:@"coding_emoji_31"];
}
    return _tableBackgroudView;
}
#pragma mark table view delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell= [[UITableViewCell alloc]init];
    [cell.textLabel setText:[NSString stringWithFormat:@"%d  %d",indexPath.section,indexPath.row]];
    
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    return  cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 22;}

#pragma mark btn events
-(void) onShowLogin{
    BNLoginViewController *loginView=[[BNLoginViewController alloc]init];
    loginView.view.backgroundColor=[UIColor redColor];
    [self presentViewController:loginView animated:YES completion:^{
        //
    }];
//    [self.navigationController pushViewController:loginView animated:YES];
}
-(void)onUserIconClick{
    if(![Login isLogin]){
        [self presentViewController:[[BNLoginViewController alloc]init] animated:YES completion:^{
           // <#code#>
        }];
    }
}


@end
