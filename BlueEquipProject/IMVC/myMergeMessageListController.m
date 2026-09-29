//
//  myMergeMessageListController.m
//  BlueEquipProject
//
//  Created by Edwin on 2023/12/28.
//

#import "myMergeMessageListController.h"
#import "TUIMergeMessageListController.h"

@interface myMergeMessageListController ()
@property (nonatomic, strong) TUIMergeMessageListController *TUIMergeMessageListC;
@end

@implementation myMergeMessageListController

- (void)extracted {
    [self.TUIMergeMessageListC addUUUIUIU];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.titleName.text = eLocalizedString(@"expertTitl_detail");
    
    self.TUIMergeMessageListC = [[TUIMergeMessageListController alloc] init];
    self.TUIMergeMessageListC.view.frame = CGRectMake(0, NAVHEIGHT, _window_width, _window_height-NAVHEIGHT);
    [self addChildViewController:self.TUIMergeMessageListC];
    [self.view addSubview:self.TUIMergeMessageListC.view];
    self.TUIMergeMessageListC.delegate = self.delegate;
    self.TUIMergeMessageListC.mergerElem = self.mergerElem;
    __weak typeof(self) weakSelf = self;
    self.TUIMergeMessageListC.willCloseCallback = ^(){
        if (weakSelf.willCloseCallback) {
            weakSelf.willCloseCallback();
        }
    };
    [self extracted];
}


@end
