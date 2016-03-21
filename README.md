# GithubClient
A Cool Github Client - Looks best on an iPhone 6

I have elected to write all of my code in Objective-C because OctoKit is in Obj-C and I didn't want to waste time configuring the inter-operability between Obj-C and Swift. I do want to note however that I am proficient in both languages.

## JAClientManager
- Instead of constantly creating new clients for each request I elected to follow the singleton pattern and always use the same client. This architectural decision will make my life much easier if I choose to use an authenticated client in the future.

## JARepoTableViewCell
- I decided to encapsulate all view outlets and have the setting of a repo property trigger view updating.

- For avatar image downloading, I capture the current value of the updateAvatarCount property before dispatching the image download operation. Once the image download finishes I check that a more recent download operation hasn't been kicked off before updating the avatarImageView of the cell.  This is necessary since I am reusing cells. Thanks to AFNetworking's awesome support of etags I don't have to worry about caching images myself.

## JARepoTableViewController

- Since I'm not using coredata I wasn't able to use an NSFetchResultsController so I elected to build and maintain my own datasource using an NSMutableArray. Kicking off a new search clears the current datasource where it is then repopulated through the subscribeNext block from my OctoKit request.

- Instead of calling reloadData every time a new object gets added to the datasource, I use a tableView animation block and insert the new row at a specific path so if the row isn't in view the tableView doesn't have to do anything.

- With more time I would add a loading indicator to the search bar to indicate to the user that a search is in progress.

## JAWebViewController

- I am setting the url property before the view loads so I can't load the request on the webView in setURL seeing as how the outlet is still nil at this time.  