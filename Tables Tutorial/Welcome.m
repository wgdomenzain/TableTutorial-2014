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


UIApplication       *mApp;

NSString        *userID = @"1";
NSDictionary    *jsonResponse;

NSMutableArray  *maNames;
NSMutableArray  *maSurname;

@interface Welcome ()

@end

@implementation Welcome

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    mApp    = [UIApplication sharedApplication];
    [self postService];
    //maNames     =  [NSMutableArray arrayWithObjects: @"Leela", @"Fry", @"Professor", @"Zoidberg", @"Bender", nil];
    
    maImages    =  [NSMutableArray arrayWithObjects: @"Leela.png", @"Fry.png", @"Professor.png", @"Zoidberg.png", @"Bender.png", @"Professor.png", @"Zoidberg.png", @"Bender.png", @"Professor.png", @"Zoidberg.png", @"Bender.png", @"Professor.png", @"Zoidberg.png", @"Bender.png", @"Professor.png", @"Zoidberg.png", @"Bender.png", @"Professor.png", @"Zoidberg.png", @"Bender.png", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnRefreshPressed:(id)sender
{
    mApp.networkActivityIndicatorVisible    = YES;
    
    NSOperationQueue *queue = [NSOperationQueue new];
    
    NSInvocationOperation *opT1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task1) object:nil];
    [queue addOperation:opT1];
    
    NSInvocationOperation *opT2 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task2) object:nil];
    
    //Add dependency on task 1
    [opT2 addDependency:opT1];
    
    //Task 2 starts until task 1 is completed
    [queue addOperation:opT2];
}

- (void) task1
{
    [self loadService];
}

- (void) task2
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tblMain reloadData];
        mApp.networkActivityIndicatorVisible    = NO;
    });
}
/*******************************************************************************
 Web Service
 *******************************************************************************/
//-------------------------------------------------------------------------------
- (void) postService
{
    NSLog(@"postService");
    NSOperationQueue *queue = [NSOperationQueue new];
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(loadService) object:nil];
    [queue addOperation:operation];
}
//-------------------------------------------------------------------------------
- (void) loadService
{
    @try
    {
        NSString *post = [[NSString alloc] initWithFormat:@"id=%@", userID];
        NSLog(@"postService: %@",post);
        NSURL *url = [NSURL URLWithString:@"http://ec2-54-148-58-107.us-west-2.compute.amazonaws.com/welcome/getFullName"];
        NSLog(@"URL postService = %@", url);
        NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
        NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:url];
        [request setHTTPMethod:@"POST"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:postData];
        [NSURLRequest requestWithURL:url];
        NSError *error = [[NSError alloc] init];
        NSHTTPURLResponse *response = nil;
        NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//-------------------------------------------------------------------------------
        if ([response statusCode] >=200 && [response statusCode] <300)
        {
            jsonResponse = [NSJSONSerialization JSONObjectWithData:urlData options:kNilOptions error:&error];
        }
        else
        {
            if (error)
            {
                NSLog(@"Error");
                
            }
            else
            {
                NSLog(@"Conect Fail");
            }
        }
//-------------------------------------------------------------------------------
    }
    @catch (NSException * e)
    {
        NSLog(@"Exception");
    }
//-------------------------------------------------------------------------------
    NSLog(@"jsonResponse %@", jsonResponse);
    
    maNames         = [jsonResponse valueForKey:@"name"];
    maSurname       = [jsonResponse valueForKey:@"surname"];
    
    NSLog(@"maNames %@", maNames);
    NSLog(@"maSurname %@", maSurname);
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
    return maNames.count;
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
