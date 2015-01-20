
#import <UIKit/UIKit.h>
#import <Sinch/Sinch.h>
#import "AppDelegate.h"
#import "MNCChatMessage.h"
#import "MNCChatMessageCell.h"


@interface MNCDialogViewController : UIViewController <UITableViewDataSource, UITextFieldDelegate>
@property (strong, nonatomic) NSString *chatMateId;     /* add this line */
@property (strong, nonatomic) NSMutableArray* messageArray;
@property (strong, nonatomic) NSString *myUserId;
@property (strong, nonatomic) UITextField *activeTextField;

- (IBAction)sendMessage:(id)sender;

@end
