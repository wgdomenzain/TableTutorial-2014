//
//  Welcome.h
//  Tables Tutorial
//
//  Created by Walter on 04/10/14.
//  Copyright (c) 2014 Smartplace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBJson.h"
#import <MobileCoreServices/MobileCoreServices.h>


@interface Welcome : UIViewController

@property (strong, nonatomic) IBOutlet UITableView *tblMain;

//Actions
- (IBAction)btnRefreshPressed:(id)sender;



@end
