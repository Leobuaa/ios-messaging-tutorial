//
//  MNCChatMessageCellTableViewCell.h
//  MiniChat
//
//  Created by xxx on 11/5/14.
//  Copyright (c) 2014 Sinch. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface MNCChatMessageCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *chatMateMessageLabel;

@property (strong, nonatomic) IBOutlet UILabel *myMessageLabel;

@end
