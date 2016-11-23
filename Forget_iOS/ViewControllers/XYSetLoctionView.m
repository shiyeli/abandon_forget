//
//  XYSetLoctionView.m
//  Forget_iOS
//
//  Created by 叶同学 on 2016/11/3.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import "XYSetLoctionView.h"
#import "XYAnimationView.h"

@interface XYSetLoctionView ()<UITableViewDelegate,UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UISwitch *mySwith;

@property (weak, nonatomic) IBOutlet UIStackView *holdStackView;


@property (weak, nonatomic) IBOutlet UITableView *myTableView;


@property (weak, nonatomic) IBOutlet UIButton *arriveAddressBtn;
@property (weak, nonatomic) IBOutlet UIButton *leaveAddressBtn;

@property(strong,nonatomic) XYAnimationView* animationView;

@end

@implementation XYSetLoctionView

-(XYAnimationView*)animationView{
    if (!_animationView) {
        _animationView=[[XYAnimationView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
        _animationView.backgroundColor=THIEM_COLOR_LIGHTER;
    }
    return _animationView;
}

- (IBAction)switchChange:(UISwitch *)sender {
    [self.holdStackView setHidden:!sender.isOn];
    
}

-(void)addAnimationViewisCommonAddress:(BOOL)isCommonAddress{
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.animationView];
    self.animationView.isCommomAddress=isCommonAddress;
    CATransition* anim=[CATransition animation];
    anim.type=@"kCATransitionFade";
    anim.duration=0.3;
    //anim.subtype=kCATransitionFromLeft;
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:anim forKey:nil];
    
}

-(void)buttonAnimationToCenter:(UIButton*)btn{
//    
//    CGRect btnF=btn.frame;
//    [UIView animateWithDuration:1 animations:^{
//        btn.layer.transform=CATransform3DMakeTranslation(btnF.origin.x, Main_Screen_Height*0.5, 0);
//    }];
    
}


- (IBAction)clickEvent:(UIButton *)sender {
    switch (sender.tag) {
        case 1:{
            //常见地点
            [self addAnimationViewisCommonAddress:YES];
            [self buttonAnimationToCenter:sender];
        }
            break;
        case 2:{
            //个人地点
            [self addAnimationViewisCommonAddress:NO];
            [self buttonAnimationToCenter:sender];
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
            //到达地点
            self.leaveAddressBtn.selected=NO;
            self.arriveAddressBtn.selected=YES;
            
        }
            break;
        case 5:{
            //离开地点
            self.leaveAddressBtn.selected=YES;
            self.arriveAddressBtn.selected=NO;
            
        }
            break;
            
        default:
            break;
    }
    
    
    
}



-(void)awakeFromNib{
    [super awakeFromNib];
    
    [self.mySwith setTintColor:THIEM_COLOR];
    [self.mySwith setOnTintColor:THIEM_COLOR];
    
    self.myTableView.delegate=self;
    self.myTableView.dataSource=self;
    self.myTableView.backgroundColor=[UIColor clearColor];
    self.myTableView.scrollEnabled=NO;
    
    [self.arriveAddressBtn setTitleColor:BLACK_FONT_COLOR forState:UIControlStateNormal];
    [self.arriveAddressBtn setTitleColor:THIEM_COLOR forState:UIControlStateSelected];
    [self.leaveAddressBtn setTitleColor:BLACK_FONT_COLOR forState:UIControlStateNormal];
    [self.leaveAddressBtn setTitleColor:THIEM_COLOR forState:UIControlStateSelected];
    self.arriveAddressBtn.selected=YES;
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
