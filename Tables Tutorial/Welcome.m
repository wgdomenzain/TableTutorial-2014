//
//  Welcome.m
//  Tables Tutorial
//
//  Created by Walter on 04/10/14.
//  Copyright (c) 2014 Smartplace. All rights reserved.
//

#import "Welcome.h"
#import "cellWelcome.h"
#import "Details.h"
#import "Declarations.h"

@interface Welcome ()

@end

@implementation Welcome

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    maNames     =  [NSMutableArray arrayWithObjects: @"Leela", @"Fry", @"Professor", @"Zoidberg", @"Bender", nil];
    
    maImages    =  [NSMutableArray arrayWithObjects: @"Leela.png", @"Fry.png", @"Professor.png", @"Zoidberg.png", @"Bender.png", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**********************************************************************************************
 Table Functions
 **********************************************************************************************/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//-------------------------------------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
//-------------------------------------------------------------------------------
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}
//-------------------------------------------------------------------------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cellFamily");
    static NSString *CellIdentifier = @"cellWelcome";
    
    cellWelcome *cell = (cellWelcome *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[cellWelcome alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    cell.lblName.text       = maNames[indexPath.row];
    cell.imgPerson.image    = [UIImage imageNamed:maImages[indexPath.row]];
    
    return cell;
}

//-------------------------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    strSelectedName     = [NSString stringWithFormat:@"%@", maNames[indexPath.row]];
    strSelectedImg      = [NSString stringWithFormat:@"%@", maImages[indexPath.row]];
    
    NSLog(@"strSelectedName %@", strSelectedName);
    NSLog(@"strSelectedImg %@", strSelectedImg);
    
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"Details"];
    [self presentViewController:vc animated:YES completion:nil];
}


@end
