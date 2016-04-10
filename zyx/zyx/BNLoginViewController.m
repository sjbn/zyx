//
//  BNLoginViewController.m
//  zyx
//
//  Created by gusijian on 16/4/9.
//  Copyright © 2016年 gusijian. All rights reserved.
//

#import "BNLoginViewController.h"
#import "BNInputTableViewCell.h"
#import "Login.h"
#import "TPKeyboardAvoidingTableView.h"
#import "UIButton+Bootstrap.h"
#import "BNApiResult.h"

@interface BNLoginViewController ()<UITableViewDataSource,UITableViewDelegate>

/** login model*/
@property(nonatomic,strong) Login * bnlogin;
/** table view*/
@property(nonatomic,strong) UITableView * mainTableView;
/** phonenumber btn view*/
@property(nonatomic,strong) UIButton * btnPhoneNumber;
/** password view*/
@property(nonatomic,strong) UIButton * btnPassword;
/** captcha btn view*/
@property(nonatomic,strong) UIButton * btnCaptcha;
/** login button*/
@property(nonatomic,strong) UIButton * btnLogin;
/** get password*/
@property(nonatomic,strong) UIButton * btnForgetPassword;
/** go to register*/
@property(nonatomic,strong) UIButton * btnGoToRegister;

/** background view*/
@property(nonatomic,strong) UIImageView * bgBlurredView;
/** table header view*/
@property(nonatomic,strong) UIView * tableHeaderView;
/** table footer view*/
@property(nonatomic,strong) UIView * tableFooterView;

@end

@implementation BNLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _bnlogin=[[Login alloc]init];
    _mainTableView=({
        UITableView *tableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [tableView registerClass:[BNInputTableViewCell class] forCellReuseIdentifier:@"logincell"];
        [tableView registerClass:[BNInputTableViewCell class] forCellReuseIdentifier:@"loginInputCell"];
        [tableView registerClass:[BNInputTableViewCell class] forCellReuseIdentifier:@"loginCaptchaCell"];
        
        tableView.backgroundView = self.bgBlurredView;
        tableView.tableHeaderView=self.tableHeaderView;
        tableView.tableFooterView=self.tableFooterView;
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:tableView];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        tableView;
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark table components
- (UIImageView *)bgBlurredView{
    if (!_bgBlurredView) {
        //背景图片
        UIImageView *bgView = [[UIImageView alloc] initWithFrame:kScreen_Bounds];
        bgView.contentMode = UIViewContentModeScaleAspectFill;
        UIImage *bgImage = [UIImage imageNamed:@"coding_emoji_31"];//[[StartImagesManager shareManager] curImage].image;
        
        CGSize bgImageSize = bgImage.size, bgViewSize = bgView.frame.size;
//        if (bgImageSize.width > bgViewSize.width && bgImageSize.height > bgViewSize.height) {
//            bgImage = [bgImage scaleToSize:bgViewSize usingMode:NYXResizeModeAspectFill];
//        }
//        bgImage = [bgImage applyLightEffectAtFrame:CGRectMake(0, 0, bgImage.size.width, bgImage.size.height)];
        bgView.image = bgImage;
        //黑色遮罩
        UIColor *blackColor = [UIColor blackColor];
//        [bgView addGradientLayerWithColors:@[(id)[blackColor colorWithAlphaComponent:0.3].CGColor,
//                                             (id)[blackColor colorWithAlphaComponent:0.3].CGColor]
//                                 locations:nil
//                                startPoint:CGPointMake(0.5, 0.0) endPoint:CGPointMake(0.5, 1.0)];
        _bgBlurredView = bgView;
    }
    return _bgBlurredView;
}
- (UIView *)tableHeaderView{
    if(!_tableHeaderView)
    {//header view
        _tableHeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 200)];
        _mainTableView.tableHeaderView=_tableHeaderView;
        UIImageView * logoImage=[[UIImageView alloc]init];
        [_tableHeaderView addSubview:logoImage];
        [logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(_tableHeaderView);
            make.height.mas_equalTo(100);
            make.width.mas_equalTo(100);
        }];
        //todo change the icon
        logoImage.image=[UIImage imageNamed:@"AppIcon120x120"];
        logoImage.layer.masksToBounds=YES;
        logoImage.layer.cornerRadius=50;
        
        UIButton* btnGoBack=[[UIButton alloc]init];
        [btnGoBack setTitle:@"返回" forState:UIControlStateNormal];
        [btnGoBack.titleLabel setFont:[UIFont systemFontOfSize:17]];
        [_tableHeaderView addSubview:btnGoBack];
        [btnGoBack mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_tableHeaderView).mas_offset(20);
            make.top.mas_equalTo(_tableHeaderView).mas_offset(20);
        }];
        [btnGoBack addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    }
    return _tableHeaderView;
}
-(UIView*) tableFooterView{
    if(!_tableFooterView)
    {
        _tableFooterView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 300)];
        _mainTableView.tableFooterView=_tableFooterView;
        _btnLogin=[[UIButton alloc]init];
        [_btnLogin setTitle:@"登陆" forState:UIControlStateNormal];
        [_btnLogin successStyle];
        [_tableFooterView addSubview:_btnLogin];
        [_btnLogin mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_tableFooterView).offset(20);
            //make.width.mas_equalTo(tableFootView);
            make.left.mas_equalTo(_tableFooterView).offset(40);
            make.right.mas_equalTo(_tableFooterView).offset(-40);
            make.centerX.mas_equalTo(_tableFooterView);
            //todo login event
        }];
        [_btnLogin addTarget:self action:@selector(onLogin) forControlEvents:UIControlEventTouchUpInside];
        
        _btnForgetPassword=[[UIButton alloc]init];
        [_btnForgetPassword setTitle:@"忘记密码？" forState:UIControlStateNormal];
        [_btnForgetPassword.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_btnForgetPassword setTitleColor:[UIColor colorWithWhite:1.0 alpha:0.5] forState:UIControlStateNormal];
        [_btnForgetPassword setTitleColor:[UIColor colorWithWhite:0.5 alpha:0.5] forState:UIControlStateHighlighted];
        [_tableFooterView addSubview:_btnForgetPassword];
        [_btnForgetPassword mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(_tableFooterView);
            make.top.mas_equalTo(_btnLogin.mas_bottom).mas_offset(20);
        }];
        
        _btnGoToRegister=[[UIButton alloc]init];
        [_btnGoToRegister setTitle:@"去注册" forState:UIControlStateNormal];
        [_btnGoToRegister.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_btnGoToRegister setTitleColor:[UIColor colorWithWhite:1.0 alpha:0.5] forState:UIControlStateNormal];
        [_btnGoToRegister setTitleColor:[UIColor colorWithWhite:0.5 alpha:0.5] forState:UIControlStateHighlighted];
        [_tableFooterView addSubview:_btnGoToRegister];
        [_btnGoToRegister mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(_tableFooterView);
            make.bottom.mas_equalTo(_tableFooterView).mas_offset(-20);
        }];
    }
    return _tableFooterView;
}


#pragma mark table view deletgate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BNInputTableViewCell * cell;
    if(indexPath.row==0)
    {
        cell=[tableView dequeueReusableCellWithIdentifier:@"loginInputCell"];
        
        [cell.textField setPlaceholder:@"请输入手机号"];
        cell.textField.keyboardType=UIKeyboardTypePhonePad;
        
        __weak typeof(self) weakSelf = self;
        cell.textValueChangedBlock=^(NSString* strValue){
            weakSelf.bnlogin.phoneNumber=strValue;
        };
        
    }
    else if(indexPath.row==1)
    {
        cell=[tableView dequeueReusableCellWithIdentifier:@"loginInputCell"];
        [cell.textField setPlaceholder:@"请输入密码"];
        cell.textField.secureTextEntry=YES;
        cell.textField.keyboardType=UIKeyboardTypeDefault;
        
        __weak typeof(self) weakSelf = self;
        cell.textValueChangedBlock=^(NSString* strValue){
            weakSelf.bnlogin.password=strValue;
        };
    }
    cell.backgroundColor=[UIColor clearColor];
    
    return  cell;
}

#pragma mark btn events
-(void) goBack
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
-(void) onLogin
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.removeFromSuperViewOnHide = YES;
    [self.bnlogin loginWithBlock:^(BNApiResult * apiResult) {
        if (apiResult.IsSuccess) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self goBack];
            
        }
        else
        {
            hud.mode = MBProgressHUDModeText;
            hud.labelText = apiResult.Error;
            [hud hide:YES afterDelay:3];
        }
    }];
}
@end
