//
//  FLDownloader.h
//  FileSafe
//
//  Created by Lombardo on 17/11/13.
//
//

#import <Foundation/Foundation.h>
#import "FLDownloadTask.h"
@class FLDownloadTask;

@interface FLDownloader : NSObject <NSURLSessionDelegate, NSURLSessionDownloadDelegate>

/**
 This is the default and only initializer. Call this method once on these two methods of appDelegate:
 - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
    to restart outstanding downloads for an app that has been previously killed by the user
 - (void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier completionHandler:(void (^)())completionHandler
    to complete a download operation (moving the file to the correct location) when a download has been finished in background
 */
+(id)sharedDownloader;

/**
 A list of the tasks. You can mutate the returned Dictioanry, since it's a copy.
 */
@property (copy, nonatomic, readonly) NSMutableDictionary *tasks;

/**
 Create and return a download task for a given URL. If the download already task exists, simply returns it.
 Once returned, the FLDownloadTask object must be started with 'start'. If you want, you can add a completion block, a progress block, and set other properties
*/
-(FLDownloadTask *)downloadTaskForURL:(NSURL *)url;
-(FLDownloadTask *)downloadTaskForURL:(NSURL *)url withResumeData:(NSData *)data;
-(FLDownloadTask *)downloadTaskForURLRequest:(NSURLRequest *)request;

/**
 Create and return an upload task for a given URL. If the upload already task exists, simply returns it. The upload is managed through http PUT method.
 Once returned, the FLDownloadTask object must be started with 'start'. If you want, you can add a completion block, a progress block, and set other properties
 */
-(FLDownloadTask *)uploadTaskForURL:(NSURL *)url fromFile:(NSURL *)filePath;

/**
 Create and return an upload task for a given URL. If the upload already task exists, simply returns it.
 With this method you can customize the underlying NSURLRequest
 */
-(FLDownloadTask *)uploadTaskForURLRequest:(NSURLRequest *)urlRequest fromFile:(NSURL *)filePath;

/**
 Remove the download task (stopping and cancelling it)
 */
-(BOOL)cancelDownloadTaskForURL:(NSURL *)url;

/**
 A default location for all downloads
 */
@property (copy, nonatomic) NSString *defaultFilePath;



@end
