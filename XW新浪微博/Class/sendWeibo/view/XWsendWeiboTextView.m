//
//  XWsendWeiboTextView.m
//  XW新浪微博
//
//  Created by bbq on 15/7/20.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#define labelFont [UIFont systemFontOfSize:14]

#import "XWsendWeiboTextView.h"

@interface XWsendWeiboTextView()
@property(nonatomic,strong) UILabel* placeholderLabel;

@end

@implementation XWsendWeiboTextView


-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        UILabel * placeholderLabel=[[UILabel alloc]init];
        self.placeholderLabel=placeholderLabel;
        //设置可换行
        placeholderLabel.numberOfLines=0;
        [placeholderLabel setTextColor:[UIColor lightGrayColor]];
        
        [self addSubview:placeholderLabel];
        [placeholderLabel setFont:labelFont];
        //添加通知，在监听到self的UITextFieldTextDidChangeNotification通知后调用方法
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange) name:UITextFieldTextDidChangeNotification object:self];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

//移除通知
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 *  使placeholderLabel隐藏
 */
-(void)textDidChange{
    
    self.placeholderLabel.hidden=self.text.length!=0;
}

/**
 *  重写palceholderText的set方法设置placehodlerLabel内文字
 *
 *  @param placeholderText 要设置的文字
 */
-(void)setPlaceholderText:(NSString *)placeholderText{
    _placeholderText=[placeholderText copy];
    self.placeholderLabel.text=_placeholderText;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat labelX=5;
     CGFloat labelY=5;
     CGFloat labelW=self.frame.size.width;
    CGSize size=CGSizeMake(self.frame.size.width, MAXFLOAT);
    
     CGFloat labelH=[self sizeWithText:self.placeholderText MaxSize:size font:labelFont].height;
    self.placeholderLabel.frame=CGRectMake(labelX, labelY, labelW, labelH);
    
}

-(CGSize)sizeWithText:(NSString*)text MaxSize:(CGSize)maxSize font:(UIFont*)font{
    NSDictionary* fontDict=@{NSFontAttributeName:font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:fontDict context:nil].size;

}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



@end
