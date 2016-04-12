//
//  BNRegisterViewController.m
//  zyx
//
//  Created by gusijian on 16/4/10.
//  Copyright © 2016年 gusijian. All rights reserved.
//

#import "BNRegisterViewController.h"
#import "BNInputTableViewCell.h"
#import "Login.h"
#import "TPKeyboardAvoidingTableView.h"
#import "UIButton+Bootstrap.h"
#import "BNApiResult.h"

@interface BNRegisterViewController ()<UITableViewDataSource,UITableViewDelegate>
/** phone*/
@property(nonatomic,strong) NSString * phoneNumber;
/** password*/
@property(nonatomic,strong) NSString * password;
/** confirmedPassword*/
@property(nonatomic,strong) NSString * confirmedPassword;
/** captcha*/
@property(nonatomic,strong) NSString * captcha;

/** btn captcha*/
@property(nonatomic,strong) UIButton * btnCaptcha;
/** btn register*/
@property(nonatomic,strong) UIButton * btnRegister;

/** main table*/
@property(nonatomic,strong) TPKeyboardAvoidingTableView * mainTable;
/** table view header*/
@property(nonatomic,strong) UIView * tableHeaderView;
/** table view footer*/
@property(nonatomic,strong) UIView * tableFooterView;

@end

@implementation BNRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _mainTable=({
        TPKeyboardAvoidingTableView* tv=[[TPKeyboardAvoidingTableView alloc]initWithFrame:kScreen_Bounds2];
        tv.dataSource=self;
        tv.delegate=self;
        tv.tableHeaderView=self.tableHeaderView;
        tv.tableFooterView=self.tableFooterView;
        tv.separatorStyle=UITableViewCellSeparatorStyleNone;
        
        [tv registerClass:[BNInputTableViewCell class] forCellReuseIdentifier:@"bnInputCell"];
        tv;
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark table components
-(UIView *)tableHeaderView{
    if(!_tableHeaderView){
        _tableHeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 100)];
        
    }
    return _tableHeaderView;
}
-(UIView *)tableFooterView{
    if (!_tableFooterView) {
        //
        _tableFooterView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 200)];
        [_tableFooterView addSubview:self.btnRegister];
        [self.btnRegister mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(_tableFooterView);
            make.left.mas_equalTo(_tableFooterView).mas_offset(40);
            make.right.mas_equalTo(_tableFooterView).mas_offset(-40);
            make.top.mas_equalTo(_tableFooterView).mas_offset(10);
        }];
        
    }
    return _tableFooterView;
    
}
-(UIButton *)btnRegister{
    if(!_btnRegister){
        _btnRegister=[[UIButton alloc]init];
        [_btnRegister bootstrapStyle];
        [_btnRegister addTarget:self action:@selector(registerClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnRegister;
}
#pragma table view delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell;
    if(indexPath.row==0)
    {
        BNInputTableViewCell* tmpCell=[tableView dequeueReusableCellWithIdentifier:@"bnInputCell"];
        [tmpCell.textField setPlaceholder:@"请输入手机号"];
        tmpCell.textValueChangedBlock=^(NSString* value){
            self.phoneNumber=value;
        };
        cell=tmpCell;
    }else if(indexPath.row==1)
    {
        BNInputTableViewCell* tmpCell=[tableView dequeueReusableCellWithIdentifier:@"bnInputCell"];
        [tmpCell.textField setPlaceholder:@"请输入密码"];
        tmpCell.textField.secureTextEntry=YES;
        tmpCell.textValueChangedBlock=^(NSString* value){
            self.password=value;
        };
        cell=tmpCell;
    }
    else if (indexPath.row==2){
        BNInputTableViewCell* tmpCell=[tableView dequeueReusableCellWithIdentifier:@"bnInputCell"];
        [tmpCell.textField setPlaceholder:@"请再次输入密码"];
        tmpCell.textField.secureTextEntry=YES;
        tmpCell.textValueChangedBlock=^(NSString* value){
            self.confirmedPassword=value;
        };
        cell=tmpCell;
    }
    return  cell;
}

#pragma mark btn events
-(void)registerClick{
}
@end


