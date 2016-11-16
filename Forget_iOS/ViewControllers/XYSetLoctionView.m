//
//  XYSetLoctionView.m
//  Forget_iOS
//
//  Created by 叶同学 on 2016/11/3.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import "XYSetLoctionView.h"


@interface XYSetLoctionView ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *myTableViewH;


@end

@implementation XYSetLoctionView

- (IBAction)clickEvent:(UIButton *)sender {
    switch (sender.tag) {
        case 1:{
            //常见地点
        
        
        
        }
            break;
        case 2:{
            //个人地点
            
            
        }
            break;
        case 3:{
            //搜索
            if (self.sendBlock) {
                self.sendBlock(sender);
            }
            
        }
            break;
        case 4:{
            //关闭
            
            
        }
            break;
            
        default:
            break;
    }
    
    
    
}



-(void)awakeFromNib{
    [super awakeFromNib];
    
    self.myTableView.delegate=self;
    self.myTableView.dataSource=self;
    self.myTableView.backgroundColor=[UIColor clearColor];
    self.myTableViewH.constant=44*3;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* identifer=@"identifer";
    UITableViewCell* cell= [self.myTableView dequeueReusableCellWithIdentifier:identifer];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifer];
        cell.backgroundColor=[UIColor clearColor];
        [cell.imageView setImage:[UIImage imageNamed:@"location_icon"]];
        [cell.textLabel setTextColor:BLACK_FONT_COLOR];
        [cell.detailTextLabel setTextColor:LIGHT_FONT_COLOR];
        
        UIView* backbg=[[UIView alloc]initWithFrame:cell.frame];
        backbg.backgroundColor=[XYTool stringToColor:@"#B2DFDB"];
        cell.selectedBackgroundView=backbg;
    }
    cell.textLabel.text=@"宏达国际广场";
    cell.detailTextLabel.text=@"青羊区下年大家汪家拐宏达国际广场1911室";
    
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
