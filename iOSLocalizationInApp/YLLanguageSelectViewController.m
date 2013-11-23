//
//  YLLanguageSelectViewController.m
//  changeLanguage
//
//  Created by Yong Li on 11/21/13.
//  Copyright (c) 2013 YongLi. All rights reserved.
//

#import "YLLanguageSelectViewController.h"
#import "YLLanguageManager.h"

#define CELL_IDENTITY @"Cell"

@interface YLLanguageSelectViewController ()

@end

@implementation YLLanguageSelectViewController
{
    NSMutableArray* _languages;
    NSUInteger _seledIndex;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CELL_IDENTITY];
    
    _languages = [NSMutableArray arrayWithArray:[[YLLanguageManager sharedManager] allSupportedLanguages]];
    [_languages enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString* str = obj;
        if([str isEqualToString:[[YLLanguageManager sharedManager] getCurrentLanguage]]) {
            _seledIndex = idx;
            *stop = YES;
        }
    }];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneSelect:)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelSelect:)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return _languages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTITY forIndexPath:indexPath];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_IDENTITY];
    }
    // Configure the cell...
    cell.textLabel.text = [_languages objectAtIndex:indexPath.row];
    if (_seledIndex == indexPath.row) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    int oldIdx = _seledIndex;
    _seledIndex = indexPath.row;
    [[YLLanguageManager sharedManager] setLanguage:[_languages objectAtIndex:_seledIndex]];
    [tableView beginUpdates];
    [tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:oldIdx inSection:0], [NSIndexPath indexPathForRow:_seledIndex inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    [tableView endUpdates];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

- (void)cancelSelect:(id)sender
{
    if([_delegate respondsToSelector:@selector(cancelSelectLangugae:)])
    {
        [_delegate cancelSelectLangugae:self];
    }
}


- (void)doneSelect:(id)sender
{
    if([_delegate respondsToSelector:@selector(finishedSelectLanguage:)])
    {
        [_delegate finishedSelectLanguage:self];
    }
}

@end
