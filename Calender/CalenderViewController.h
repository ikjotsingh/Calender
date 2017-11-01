//
//  CalenderViewController.h
//  Calender
//
//  Created by Ikjot singh on 10/27/17.
//  Copyright © 2017 Ikjot singh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalenderViewController : UIViewController
@property (nonatomic,assign)NSInteger selectedYear;
@property (nonatomic,assign)NSInteger selectedQuater;
@property (nonatomic,strong)NSMutableArray *selectedMonth;

@end
