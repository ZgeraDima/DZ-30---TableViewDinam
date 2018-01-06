//
//  ViewController.h
//  DZ 30 - Skut_TablView_Dinam
//
//  Created by mac on 06.01.18.
//  Copyright © 2018 Dima Zgera. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

