//
//  XWTableViewCell.m
//  XW新浪微博
//
//  Created by bbq on 15/7/29.
//  Copyright (c) 2015年 bbq. All rights reserved.
//自定义的cell，内包含statusDetailView和toolbarView

#import "XWTableViewCell.h"
#import "XWStatusDetailView.h"
#import "XWToolBarView.h"
#import "XWFooterView.h"

@interface XWTableViewCell()
@property(nonatomic,weak) XWStatusDetailView* detailView;
@property(nonatomic,weak) XWToolBarView* toolBar;
@end

@implementation XWTableViewCell

+(XWTableViewCell *)CellWithTableView:(UITableView *)tabView{
    static NSString* ID=@"statues";
    XWTableViewCell* cell=[tabView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell=[[XWTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //1.添加detaiilView
        XWStatusDetailView* detailView=[[XWStatusDetailView alloc]init];
        self.detailView=detailView;
        [self.contentView addSubview:detailView];
        //2. 添加toolBar
        XWToolBarView* toolBarView=[[XWToolBarView alloc]init];
     
        self.toolBar=toolBarView;
        
        [self.contentView addSubview:toolBarView];

    }
    return self;
}

//set方法中干活...
-(void)setStatusFrame:(XWStatusFrame *)statusFrame{
    _statusFrame=statusFrame;
    //detailView微博数据frame往下传
    self.detailView.detailFrame=statusFrame.detailFrame;
    //toolBarframe
    self.toolBar.frame=statusFrame.toolBarFrame;
    //给toolBar传入数据
    self.toolBar.status=self.statusFrame.status;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
