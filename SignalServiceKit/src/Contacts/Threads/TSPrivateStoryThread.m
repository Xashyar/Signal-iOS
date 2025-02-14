//
//  Copyright (c) 2022 Open Whisper Systems. All rights reserved.
//

#import "TSPrivateStoryThread.h"
#import <SignalServiceKit/SignalServiceKit-Swift.h>

@interface TSThread ()

@property (nonatomic) TSThreadStoryViewMode storyViewMode;

@end

@interface TSPrivateStoryThread ()

@property (nonatomic) BOOL allowsReplies;
@property (nonatomic) NSString *name;
@property (nonatomic) NSArray<SignalServiceAddress *> *addresses;

@end

@implementation TSPrivateStoryThread

+ (TSFTSIndexMode)FTSIndexMode
{
    return TSFTSIndexModeNever;
}

- (instancetype)initWithUniqueId:(NSString *)uniqueId
                            name:(NSString *)name
                   allowsReplies:(BOOL)allowsReplies
                       addresses:(NSArray<SignalServiceAddress *> *)addresses
                        viewMode:(TSThreadStoryViewMode)viewMode
{
    self = [super initWithUniqueId:uniqueId];
    if (self) {
        self.name = name;
        self.allowsReplies = allowsReplies;
        self.addresses = addresses;
        self.storyViewMode = viewMode;
    }
    return self;
}

- (instancetype)initWithName:(NSString *)name
               allowsReplies:(BOOL)allowsReplies
                   addresses:(NSArray<SignalServiceAddress *> *)addresses
                    viewMode:(TSThreadStoryViewMode)viewMode
{
    self = [super init];
    if (self) {
        self.name = name;
        self.allowsReplies = allowsReplies;
        self.addresses = addresses;
        self.storyViewMode = viewMode;
    }
    return self;
}

// --- CODE GENERATION MARKER

// This snippet is generated by /Scripts/sds_codegen/sds_generate.py. Do not manually edit it, instead run
// `sds_codegen.sh`.

// clang-format off

- (instancetype)initWithGrdbId:(int64_t)grdbId
                      uniqueId:(NSString *)uniqueId
   conversationColorNameObsolete:(NSString *)conversationColorNameObsolete
                    creationDate:(nullable NSDate *)creationDate
              isArchivedObsolete:(BOOL)isArchivedObsolete
          isMarkedUnreadObsolete:(BOOL)isMarkedUnreadObsolete
            lastInteractionRowId:(int64_t)lastInteractionRowId
      lastReceivedStoryTimestamp:(nullable NSNumber *)lastReceivedStoryTimestamp
          lastSentStoryTimestamp:(nullable NSNumber *)lastSentStoryTimestamp
        lastViewedStoryTimestamp:(nullable NSNumber *)lastViewedStoryTimestamp
       lastVisibleSortIdObsolete:(uint64_t)lastVisibleSortIdObsolete
lastVisibleSortIdOnScreenPercentageObsolete:(double)lastVisibleSortIdOnScreenPercentageObsolete
         mentionNotificationMode:(TSThreadMentionNotificationMode)mentionNotificationMode
                    messageDraft:(nullable NSString *)messageDraft
          messageDraftBodyRanges:(nullable MessageBodyRanges *)messageDraftBodyRanges
          mutedUntilDateObsolete:(nullable NSDate *)mutedUntilDateObsolete
     mutedUntilTimestampObsolete:(uint64_t)mutedUntilTimestampObsolete
           shouldThreadBeVisible:(BOOL)shouldThreadBeVisible
                   storyViewMode:(TSThreadStoryViewMode)storyViewMode
                       addresses:(NSArray<SignalServiceAddress *> *)addresses
                   allowsReplies:(BOOL)allowsReplies
                            name:(NSString *)name
{
    self = [super initWithGrdbId:grdbId
                        uniqueId:uniqueId
     conversationColorNameObsolete:conversationColorNameObsolete
                      creationDate:creationDate
                isArchivedObsolete:isArchivedObsolete
            isMarkedUnreadObsolete:isMarkedUnreadObsolete
              lastInteractionRowId:lastInteractionRowId
        lastReceivedStoryTimestamp:lastReceivedStoryTimestamp
            lastSentStoryTimestamp:lastSentStoryTimestamp
          lastViewedStoryTimestamp:lastViewedStoryTimestamp
         lastVisibleSortIdObsolete:lastVisibleSortIdObsolete
lastVisibleSortIdOnScreenPercentageObsolete:lastVisibleSortIdOnScreenPercentageObsolete
           mentionNotificationMode:mentionNotificationMode
                      messageDraft:messageDraft
            messageDraftBodyRanges:messageDraftBodyRanges
            mutedUntilDateObsolete:mutedUntilDateObsolete
       mutedUntilTimestampObsolete:mutedUntilTimestampObsolete
             shouldThreadBeVisible:shouldThreadBeVisible
                     storyViewMode:storyViewMode];

    if (!self) {
        return self;
    }

    _addresses = addresses;
    _allowsReplies = allowsReplies;
    _name = name;

    return self;
}

// clang-format on

// --- CODE GENERATION MARKER

- (BOOL)isMyStory
{
    return [self.uniqueId isEqualToString:[self class].myStoryUniqueId];
}

- (NSString *)name
{
    if (self.isMyStory) {
        return OWSLocalizedString(
            @"MY_STORY_NAME", @"Name for the 'My Story' default story that sends to all the user's contacts.");
    }

    return _name;
}

- (void)updateWithStoryViewMode:(TSThreadStoryViewMode)storyViewMode
                      addresses:(NSArray<SignalServiceAddress *> *)addresses
           updateStorageService:(BOOL)updateStorageService
                    transaction:(SDSAnyWriteTransaction *)transaction
{
    if ([self isMyStory]) {
        [StoryManager setHasSetMyStoriesPrivacyWithTransaction:transaction shouldUpdateStorageService:YES];
    }
    [self anyUpdatePrivateStoryThreadWithTransaction:transaction
                                               block:^(TSPrivateStoryThread *thread) {
                                                   thread.storyViewMode = storyViewMode;
                                                   thread.addresses = addresses;
                                               }];

    if (updateStorageService) {
        [SSKEnvironment.storageServiceManager
            recordPendingUpdatesWithUpdatedStoryDistributionListIds:@[ self.distributionListIdentifier ]];
    }
}

- (void)updateWithAllowsReplies:(BOOL)allowsReplies
           updateStorageService:(BOOL)updateStorageService
                    transaction:(SDSAnyWriteTransaction *)transaction
{
    [self anyUpdatePrivateStoryThreadWithTransaction:transaction
                                               block:^(TSPrivateStoryThread *thread) {
                                                   thread.allowsReplies = allowsReplies;
                                               }];

    if (updateStorageService) {
        [SSKEnvironment.storageServiceManager
            recordPendingUpdatesWithUpdatedStoryDistributionListIds:@[ self.distributionListIdentifier ]];
    }
}

- (void)updateWithName:(NSString *)name
    updateStorageService:(BOOL)updateStorageService
             transaction:(SDSAnyWriteTransaction *)transaction
{
    [self anyUpdatePrivateStoryThreadWithTransaction:transaction
                                               block:^(TSPrivateStoryThread *thread) { thread.name = name; }];

    if (updateStorageService) {
        [SSKEnvironment.storageServiceManager
            recordPendingUpdatesWithUpdatedStoryDistributionListIds:@[ self.distributionListIdentifier ]];
    }
}

@end
