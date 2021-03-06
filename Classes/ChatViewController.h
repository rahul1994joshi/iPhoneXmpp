//
//  ChatViewController.h
//  iPhoneXMPP
//
//  Created by RAHUL on 10/17/15.
//  Copyright © 2015 XMPPFramework. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "XMPP.h"
#import "TURNSocket.h"
#import "RootViewController.h"
#import "MessageCell.h"
#import "XMPPOutgoingFileTransfer.h"
#import "XMPPIncomingFileTransfer.h"
#import "iPhoneXMPPAppDelegate.h"
#import "NSString+Utils.h"
#import "XMPPMessageArchivingCoreDataStorage.h"
#import "XMPPMessageArchiving.h"
#import "ImageViewCell.h"
#import "HPGrowingTextView.h"
#import "XMPPMessage+XEP_0033.h"
#import "XMPPMessage+XEP_0333.h"
#import "XMPPMessage+XEP_0085.h"
#import "musicTableViewCell.h"



@interface ChatViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,NSFetchedResultsControllerDelegate,XMPPOutgoingFileTransferDelegate,XMPPIncomingFileTransferDelegate,HPGrowingTextViewDelegate,XMPPRoomDelegate>
{
    NSFetchedResultsController *fetchedResultsController;
    NSMutableArray *turnSockets;
    NSMutableArray *sentMessages;
    NSMutableArray* _messagelist;
    HPGrowingTextView * chatFeild;
    XMPPRoom *xmppRoom;
}

@property (weak, nonatomic) IBOutlet UITextField *chatWindow;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (strong,nonatomic) NSString * resource;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UIImageView *imgUser;
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property (weak, nonatomic) XMPPUserCoreDataStorageObject *user;
@property (weak, nonatomic) XMPPGroupCoreDataStorageObject *group;
@property (atomic) BOOL isGroupchat;
@property (weak ,nonatomic) NSString *groupName;
@property (weak, nonatomic) IBOutlet UILabel *lblLastSeen;
@property (weak, nonatomic) IBOutlet UILabel *lblStatus;


- (IBAction)btnChooseImageClick:(id)sender;

@end
