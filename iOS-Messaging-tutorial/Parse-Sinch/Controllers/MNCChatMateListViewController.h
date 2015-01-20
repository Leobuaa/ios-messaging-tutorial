
#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "MNCDialogViewController.h"
#import <Sinch/Sinch.h>
#import "Config.h"

@interface MNCChatMateListViewController : UITableViewController <UITableViewDataSource>
@property (strong, nonatomic) MNCDialogViewController *activeDialogViewController;

@property (strong, nonatomic) NSString *myUserId;   /* add this line */
@property (strong, nonatomic) NSMutableArray *chatMatesArray;


@end