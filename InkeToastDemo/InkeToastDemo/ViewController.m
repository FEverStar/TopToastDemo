//
//  ViewController.m
//  InkeToastDemo
//
//  Created by L on 16/6/15.
//  Copyright © 2016年 L. All rights reserved.
//

#import "ViewController.h"
#import "TopToast.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"0");
    NSLog(@"1");
    NSLog(@"2");
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)acion:(id)sender {
        
    [TopToast showToptoastWithText:@"TopToast" duration:2 height:64 backGroundColor:[UIColor blueColor] alpha:1.0];

}

@end
