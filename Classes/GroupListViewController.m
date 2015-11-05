//
//  GroupListViewController.m
//  iPhoneXMPP
//
//  Created by RAHUL on 11/3/15.
//  Copyright © 2015 XMPPFramework. All rights reserved.
//

#import "GroupListViewController.h"
#import "iPhoneXMPPAppDelegate.h"
#import "ChatViewController.h"
#import "DDLog.h"
#import "Rest.h"

// Log levels: off, error, warn, info, verbose
#if DEBUG
static const int ddLogLevel = LOG_LEVEL_VERBOSE;
#else
static const int ddLogLevel = LOG_LEVEL_INFO;
#endif


@implementation GroupListViewController

#pragma mark Accessors

- (iPhoneXMPPAppDelegate *)appDelegate
{
    return (iPhoneXMPPAppDelegate *)[[UIApplication sharedApplication] delegate];
}

#pragma mark -VIew lifecycle

-(void)viewDidLoad
{
    [[Rest sharedInstance]setUser:@"test1" Password:@"123"];
   // [[Rest sharedInstance]getRosterItemsforUser:@"test4"];
   // [[Rest sharedInstance]getGroupsItemsforUser:@"test4"];
  //  [[Rest sharedInstance]getChatRooms];
   // [[Rest sharedInstance]addUser:@"test3" ToGroup:@"chalo"];
    //[[Rest sharedInstance]getChatRoomWithName:@"chalo"];
  //  [[Rest sharedInstance]createGroupWithName:@"Jalsa" Description:@"FunGroup"];
    //[[Rest sharedInstance]addUser:@"test1" ToGroup:@"Jalsa"];
    //[[Rest sharedInstance]addUser:@"test4" ToGroup:@"Jalsa"];
    
  //  [[Rest sharedInstance]addUser:@"test1" ToGroup:@"Jalsa"];
    

    NSLog(@"%lu",[[[self fetchedGroupsResultsController]fetchedObjects]count]);
 }


#pragma mark -------------------NSFetchedResultsController----------------------

-(NSFetchedResultsController *)fetchedGroupsResultsController
{
    
    if (fetchedGroupsResultsController == nil) {
        NSManagedObjectContext *moc  =[[self appDelegate] managedObjectContext_roster];
        
        NSEntityDescription *groupEntity =[NSEntityDescription entityForName:@"XMPPGroupCoreDataStorageObject" inManagedObjectContext:moc];
        
        NSSortDescriptor *sortByName = [[NSSortDescriptor alloc]
                                        initWithKey:@"name" ascending:YES];
        NSArray *sortDescriptors = @[sortByName];
        
        
        NSFetchRequest *groupsFetchRequest = [[NSFetchRequest alloc] init];
        [groupsFetchRequest setEntity:groupEntity];
        [groupsFetchRequest setFetchBatchSize:10];
        [groupsFetchRequest setSortDescriptors:sortDescriptors];
        
        fetchedGroupsResultsController =[[NSFetchedResultsController alloc]
                                         initWithFetchRequest:groupsFetchRequest
                                         managedObjectContext:moc                                                                             sectionNameKeyPath:nil                                                                                      cacheName:nil];
        [fetchedGroupsResultsController setDelegate:self];
        
        NSError *error = nil;
        if (![fetchedGroupsResultsController performFetch:&error])
        {
            DDLogError(@"Error performing fetch: %@", error);
        }
        
        
    }
    return fetchedGroupsResultsController;
}



- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [[self tableView] reloadData];
}



#pragma mark ------------------UITableView-------------------------------------



- (NSString *)tableView:(UITableView *)sender titleForHeaderInSection:(NSInteger)sectionIndex
{
        return @"Groups";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    NSLog(@"%lu",[[[self fetchedGroupsResultsController]fetchedObjects]count]);

     return [[[self fetchedGroupsResultsController]fetchedObjects]count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
    }
    
    

    
    if (indexPath.row<(int)[[[self fetchedGroupsResultsController]fetchedObjects]count]) {
        
        XMPPGroupCoreDataStorageObject *group = [[self fetchedGroupsResultsController] objectAtIndexPath:indexPath];
        
        cell.textLabel.text = group.name;
        
        
      
        
        
    }

    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    XMPPGroupCoreDataStorageObject *group = [[self fetchedGroupsResultsController] objectAtIndexPath:indexPath];
    
    ChatViewController *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"ChatViewController"] ;
    vc.group=group;
    vc.isGroupchat=YES;
    [self.navigationController pushViewController:vc animated:YES] ;
}


@end