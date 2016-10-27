//
//  IntentViewController.m
//  Forget_SiriUI
//
//  Created by 111 on 16/10/26.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import "IntentViewController.h"
#import <Intents/Intents.h>
// As an example, this extension's Info.plist has been configured to handle interactions for INSendMessageIntent.
// You will want to replace this or add other intents as appropriate.
// The intents whose interactions you wish to handle must be declared in the extension's Info.plist.

// You can test this example integration by saying things to Siri like:
// "Send a message using <myApp>"

@interface IntentViewController ()
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation IntentViewController

- (BOOL)displaysMessage{
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _logoImage.layer.masksToBounds = YES;
    _logoImage.layer.cornerRadius = 8.0f;
    _questionLabel.text = nil;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - INUIHostedViewControlling

// Prepare your view controller for the interaction to handle.
- (void)configureWithInteraction:(INInteraction *)interaction context:(INUIHostedViewContext)context completion:(void (^)(CGSize))completion {
    NSLog(@"INUIHostedViewContextSiriSnippet:%d",INUIHostedViewContextSiriSnippet);
    _questionLabel.text = @"hahahha";
    if ([interaction.intent isKindOfClass:[INSendMessageIntent class]]) {
        INSendMessageIntent *smIntent = (INSendMessageIntent *)interaction.intent;
        [smIntent.recipients enumerateObjectsUsingBlock:^(INPerson * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSLog(@"the recipient idx:%d  display name:%@,NSPersonNameComponents:%@",idx,obj.displayName,obj.nameComponents.familyName);
        }];
        _questionLabel.text = [NSString stringWithFormat:@"send to:%@",smIntent.recipients.firstObject.displayName];
        _contentLabel.text =  smIntent.content;
    }
    if (completion) {
        completion([self desiredSize]);
    }
}

- (CGSize)desiredSize {
    return CGSizeMake(320, 150);
    return [self extensionContext].hostedViewMaximumAllowedSize;
}

@end
