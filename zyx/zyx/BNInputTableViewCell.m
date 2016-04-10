//
//  BNInputTableViewCell.m
//  zyx
//
//  Created by gusijian on 16/4/9.
//  Copyright © 2016年 gusijian. All rights reserved.
//

#import "BNInputTableViewCell.h"

@interface BNInputTableViewCell()
/** <#comments#>*/
@property(nonatomic,strong) UIView * lineView;
@end

@implementation BNInputTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        if(!_textField)
        {
            _textField=[UITextField new];
            [self.contentView addSubview:_textField];
            [_textField setFont:[UIFont systemFontOfSize:17]];
            
            [_textField addTarget:self action:@selector(editDidBegin:) forControlEvents:UIControlEventEditingDidBegin];
            [_textField addTarget:self action:@selector(textValueChanged:) forControlEvents:UIControlEventEditingChanged];
            [_textField addTarget:self action:@selector(editDidEnd:) forControlEvents:UIControlEventEditingDidEnd];
            [self.contentView addSubview:_textField];
            
            [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(20);
                make.left.mas_equalTo(self.contentView).mas_offset(30);
                make.right.mas_equalTo(self.contentView).mas_offset(-30);
                make.centerY.mas_equalTo(self.contentView);
                
            }];
            
            self.textField.clearButtonMode =  UITextFieldViewModeWhileEditing;
            self.textField.textColor = [UIColor colorWithHexString:@"0x222222"];
        }
        
        if (!_lineView) {
            _lineView = [UIView new];
            _lineView.backgroundColor = [UIColor colorWithHexString:@"0xffffff" andAlpha:0.5];
            [self.contentView addSubview:_lineView];
            [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(0.5);
                make.left.equalTo(self.contentView).offset(kLoginPaddingLeftWidth);
                make.right.equalTo(self.contentView).offset(-kLoginPaddingLeftWidth);
                make.bottom.equalTo(self.contentView);
            }];
        }
    }
    return self;
}

#pragma mark text feilds event
- (void)textValueChanged:(id)sender {
    if (self.textValueChangedBlock) {
        self.textValueChangedBlock(self.textField.text);
    }
}
- (void)editDidBegin:(id)sender {
//    self.lineView.backgroundColor = [UIColor colorWithHexString:@"0xffffff"];
//    self.clearBtn.hidden = _isForLoginVC? self.textField.text.length <= 0: YES;
    
    if (self.editDidBeginBlock) {
        self.editDidBeginBlock(self.textField.text);
    }
}

- (void)editDidEnd:(id)sender {
//    self.lineView.backgroundColor = [UIColor colorWithHexString:@"0xffffff" andAlpha:0.5];
//    self.clearBtn.hidden = YES;
    
    if (self.editDidEndBlock) {
        self.editDidEndBlock(self.textField.text);
    }
}
@end
