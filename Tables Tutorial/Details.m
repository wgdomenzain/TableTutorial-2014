//
//  Details.m
//  Tables Tutorial
//
//  Created by Walter on 04/10/14.
//  Copyright (c) 2014 Smartplace. All rights reserved.
//

#import "Details.h"
#import "Declarations.h"

@interface Details ()

@end

@implementation Details

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"Hola");
    self.lblName.text           = strSelectedName;
    NSLog(@"self.lblName.text %@", self.lblName.text);
    self.imgCharacter.image     = [UIImage imageNamed:strSelectedImg];
    NSLog(@"strSelectedImgt %@", strSelectedImg);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
