//
//  XWDiscoverCell.m
//  XW新浪微博
//
//  Created by bbq on 15/8/15.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "XWDiscoverCell.h"
#import "XWDiscoverTableViewItem.h"
#import "XWArrowsItem.h"
@interface XWDiscoverCell()
@property(nonatomic,strong) UIImageView* selectedImageView;
@property(nonatomic,strong) UIImageView* backgroundImageView;
@end
@implementation XWDiscoverCell


+(XWDiscoverCell*)cellWithTableView:(UITableView*)tableView{
    static NSString* ID=@"discover";
    XWDiscoverCell* cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell=[[XWDiscoverCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor=[UIColor clearColor];
        UIImageView* selectedImageView=[[UIImageView alloc]init];
        self.selectedBackgroundView=selectedImageView;
        UIImageView* backgroundImageView=[[UIImageView alloc]init];
        self.backgroundImageView=backgroundImageView;
        self.selectedBackgroundView=selectedImageView;
        self.backgroundView=backgroundImageView;
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

/**
 *  在该方法中根据indexPath和totolRows设置每个cell的背景图片
 */
-(void)setupIndexPath:(NSIndexPath *)indexPath andTotolRowsOfSection:(int)totolRows{
    
    
    if (totolRows==1) {//如果一组只有一个cell
        self.backgroundImageView.image=[UIImage resizableImage:@"common_card_background"];
        self.selectedImageView.image=[UIImage resizableImage:@"common_card_background_highlighted"];
    }else if (indexPath.row==0){//如果是一组中的第一个cell
        self.backgroundImageView.image=[UIImage resizableImage:@"common_card_top_background"];
        self.selectedImageView.image=[UIImage resizableImage:@"common_card_top_background_highlighted"];
    }else if (indexPath.row==totolRows-1){//最后一个cell
        self.backgroundImageView.image=[UIImage resizableImage:@"common_card_bottom_background"];
        self.selectedImageView.image=[UIImage resizableImage:@"common_card_bottom_background_highlighted"];
    }else{//中间的cell
        self.backgroundImageView.image=[UIImage resizableImage:@"common_card_middle_background"];
        self.selectedImageView.image=[UIImage resizableImage:@"common_card_middle_background_highlighted"];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
/**
 *  设置cell中的内容
 *
 */
-(void)setItem:(XWDiscoverTableViewItem *)item{
    _item=item;
    self.textLabel.text=item.title;
    self.imageView.image=[UIImage imageNamed:item.icon];
    self.detailTextLabel.text=item.subTitle;
//    NSLog(@"%@",[item class]);
    if ([item isKindOfClass:[XWArrowsItem class]]) {

        self.accessoryView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"common_icon_membership_level6"]];
    }else{
        
        self.accessoryView=nil;
    }
}
/**
 *  调整每个cell的y值
 *
 */
-(void)setFrame:(CGRect)frame{
    frame.origin.y-=20;
    [super setFrame:frame];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.detailTextLabel.x+=7;
}

@end
