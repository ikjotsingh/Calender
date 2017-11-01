//
//  CalenderViewController.m
//  Calender
//
//  Created by Ikjot singh on 10/27/17.
//  Copyright © 2017 Ikjot singh. All rights reserved.
//

#import "CalenderViewController.h"

@interface CalenderViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *yearsButtons;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *quatersButtons;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *monthsButtons;


@property(strong,nonatomic)NSArray *monthsArray;

@end

@implementation CalenderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self refreshButtons];
    
    NSString *yearString = [[self currentYearString] firstObject];
    NSNumber *yearNumber= [[self currentYearString]objectAtIndex:1];
   
    
    [[self.yearsButtons objectAtIndex:1] setTitle:yearString forState:UIControlStateNormal];
    [[self.yearsButtons objectAtIndex:0] setTitle:[NSString stringWithFormat:@"%d",[yearNumber intValue]-1]forState:UIControlStateNormal];
    [[self.yearsButtons objectAtIndex:2] setTitle:[NSString stringWithFormat:@"%d",[yearNumber intValue]+1]forState:UIControlStateNormal];
    
    
    
    //NSLog(@"%@",[NSString stringWithFormat:@"%d",[yearNumber intValue]-1]);
    //NSLog(@"%@",[NSString stringWithFormat:@"%d",[yearNumber intValue]+1]);
   

    // Do any additional setup after loading the view.
    [self autoselectDate:yearNumber];
  
   
    
}

-(NSArray*)currentYearString{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    NSString *yearString = [formatter stringFromDate:[NSDate date]];
    NSLog(@"%@",yearString);
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    NSNumber *yearNumber = [f numberFromString:yearString];
    NSArray* returnArray = [NSArray arrayWithObjects:yearString,yearNumber,nil];
    return returnArray;
}

-(void)autoselectDate:(NSNumber*)yearNumber
{
    if (self.selectedYear && self.selectedMonth && self.selectedQuater){
        
        [[self.yearsButtons objectAtIndex:[yearNumber integerValue]-self.selectedYear+1] sendActionsForControlEvents:UIControlEventTouchUpInside];
        [[self.quatersButtons objectAtIndex:self.selectedQuater] sendActionsForControlEvents:UIControlEventTouchUpInside];
        [self updateMonths:self.selectedQuater];
            //[self.yearsButtons objectAtIndex:(self.selectedMonth%3)];
    }else{
        [[self.yearsButtons objectAtIndex:1] sendActionsForControlEvents:UIControlEventTouchUpInside];
        [[self.quatersButtons objectAtIndex:0] sendActionsForControlEvents:UIControlEventTouchUpInside];
        [self updateMonths:1];
    }
}

-(void)updateMonths:(NSInteger)selectedQuater
{
    self.monthsArray = [@[@"January", @"Feburary",@"March",@"April",@"May",@"June",@"July",@"August",@"September",@"October",@"November",@"December"]mutableCopy];
    for(int i=0;i<[self.monthsButtons count];i++){
        UIButton* monthsButton = [self.monthsButtons objectAtIndex:i];
        [monthsButton setTitle:[self.monthsArray objectAtIndex:(selectedQuater-1)*3+i] forState:UIControlStateNormal];
    }
}


- (IBAction)selectedQuater:(UIButton *)sender {
    if(!sender.selected){
        self.selectedQuater  = sender.tag;
        NSLog(@"selected quater is %ld",self.selectedQuater);
        
        for (UIButton* button in self.quatersButtons){
            [button setBackgroundColor:[UIColor whiteColor]];
            button.selected = NO;
        }
        [sender setBackgroundColor:[UIColor grayColor]];
        sender.selected = YES;
        //refresh months
        for (UIButton* button in self.monthsButtons){
            [button setBackgroundColor:[UIColor whiteColor]];
            button.selected = NO;
        }
        self.selectedMonth = nil;
        [self updateMonths:self.selectedQuater];
    }
}
//- (IBAction)selectedQuater2:(id)sender {
//     self.selectedQuater  = 2;
//    for (UIButton* button in self.quatersButtons){
//        [button setBackgroundColor:[UIColor whiteColor]];
//    }
//     [sender setBackgroundColor:[UIColor grayColor]];
//    [self updateMonths:self.selectedQuater];
//}
//- (IBAction)selectedQuater3:(id)sender {
//     self.selectedQuater  = 3;
//    for (UIButton* button in self.quatersButtons){
//        [button setBackgroundColor:[UIColor whiteColor]];
//    }
//     [sender setBackgroundColor:[UIColor grayColor]];
//    [self updateMonths:self.selectedQuater];
//}
//- (IBAction)selectedQuater4:(id)sender {
//     self.selectedQuater  = 4;
//    for (UIButton* button in self.quatersButtons){
//        [button setBackgroundColor:[UIColor whiteColor]];
//    }
//     [sender setBackgroundColor:[UIColor grayColor]];
//    [self updateMonths:self.selectedQuater];
//}
-(void)refreshQuaterAndMonths{
    for (UIButton* button in self.quatersButtons){
        [button setBackgroundColor:[UIColor whiteColor]];
        button.selected = NO;
    }
    [[self.quatersButtons objectAtIndex:0] sendActionsForControlEvents:UIControlEventTouchUpInside];
    [self updateMonths:1];
}

- (IBAction)selectedYear:(UIButton *)sender {
    if(!sender.selected){
        self.selectedYear = [(NSNumber *)[[self currentYearString]objectAtIndex:1] integerValue]+sender.tag-2;
        NSLog(@"selected year is %ld",self.selectedYear);
        for (UIButton* button in self.yearsButtons){
            [button setBackgroundColor:[UIColor whiteColor]];
            button.selected = NO;
        }
        [sender setBackgroundColor:[UIColor grayColor]];
        sender.selected = YES;
        [self refreshQuaterAndMonths];
        
    }
}



//-(void)refreshButtons
//{
//    NSArray *buttonArray = [[NSArray alloc] initWithObjects:self.yearButton1,self.yearButton2,self.yearButton3,self.Q1,self.Q2,self.Q3,self.Q4,self.month1,self.month2,self.month3,nil];
//    //    NSArray *buttons = @[@"yearButton1",@"yearButton2",@"yearButton3",@"Q1",@"Q2",@"Q3",@"Q4",@"month1",@"month2",@"month3"]
//
//    for (UIButton* button in buttonArray){
//        [button setBackgroundColor:[UIColor whiteColor]];
//    }
//}
- (IBAction)selectedMonth:(UIButton *)sender {
    NSInteger selecMonth =(self.selectedQuater-1)*3+sender.tag;
    NSNumber *monthsSelected = [[NSNumber alloc] initWithInteger:selecMonth];
    if(!self.selectedMonth)self.selectedMonth = [[NSMutableArray alloc]init];
    [self.selectedMonth addObject:monthsSelected];
    NSLog(@"selected Month is %@",self.selectedMonth);

    if(!sender.selected){
    sender.selected = YES;
     [sender setBackgroundColor:[UIColor grayColor]];
    }else{
        sender.selected = NO;
        [sender setBackgroundColor:[UIColor whiteColor]];
        
    }

}




@end
