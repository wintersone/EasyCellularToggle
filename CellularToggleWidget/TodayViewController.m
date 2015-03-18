//
//  TodayViewController.m
//  CellularToggleWidget
//
//  Created by Huang Huan on 3/18/15.
//  Copyright (c) 2015 POI. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
extern BOOL CTCellularDataPlanGetIsEnabled();
extern void CTCellularDataPlanSetIsEnabled(BOOL enabled);

@interface TodayViewController () <NCWidgetProviding>
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UISwitch *cellularSwitch;

@end

@implementation TodayViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
  self.preferredContentSize = CGSizeMake(0, 60);
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
  // Perform any setup necessary in order to update the view.
  
  // If an error is encountered, use NCUpdateResultFailed
  // If there's no update required, use NCUpdateResultNoData
  // If there's an update, use NCUpdateResultNewData
  completionHandler(NCUpdateResultNewData);
  [self configLabelText];

}

- (void)configLabelText {
  if(CTCellularDataPlanGetIsEnabled()){
    [self.cellularSwitch setOn:true];
    self.label.text = @"Cellular Open";
  } else {
    [self.cellularSwitch setOn:false];
    self.label.text = @"Cellular Closed";

  }
}

- (IBAction) cellularDidChange:(UISwitch *)cellularSwitch {
  NSLog(@"did switch it");
  
  if ([cellularSwitch isOn]) {
    [self.cellularSwitch setOn:true];
    self.label.text = @"Cellular Open";
    CTCellularDataPlanSetIsEnabled(true);

  } else {
    [self.cellularSwitch setOn:false];
    self.label.text = @"Cellular Closed";
    CTCellularDataPlanSetIsEnabled(false);

  }
}


@end
