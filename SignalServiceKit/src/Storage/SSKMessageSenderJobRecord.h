//
//  Copyright (c) 2022 Open Whisper Systems. All rights reserved.
//

#import <SignalServiceKit/SSKJobRecord.h>

NS_ASSUME_NONNULL_BEGIN

@class SDSAnyReadTransaction;
@class TSOutgoingMessage;

@interface SSKMessageSenderJobRecord : SSKJobRecord

@property (nonatomic, readonly, nullable) NSString *messageId;
@property (nonatomic, readonly, nullable) NSString *threadId;
@property (nonatomic, readonly) BOOL isMediaMessage;
@property (nonatomic, readonly, nullable) TSOutgoingMessage *invisibleMessage;
@property (nonatomic, readonly) BOOL removeMessageAfterSending;
@property (nonatomic, readonly) BOOL isHighPriority;

- (nullable instancetype)initWithCoder:(NSCoder *)coder NS_DESIGNATED_INITIALIZER;

- (nullable instancetype)initWithMessage:(TSOutgoingMessage *)message
               removeMessageAfterSending:(BOOL)removeMessageAfterSending
                          isHighPriority:(BOOL)isHighPriority
                                   label:(NSString *)label
                             transaction:(SDSAnyReadTransaction *)transaction
                                   error:(NSError **)outError NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithLabel:(nullable NSString *)label NS_UNAVAILABLE;

- (instancetype)initWithGrdbId:(int64_t)grdbId
                      uniqueId:(NSString *)uniqueId
    exclusiveProcessIdentifier:(nullable NSString *)exclusiveProcessIdentifier
                  failureCount:(NSUInteger)failureCount
                         label:(NSString *)label
                        sortId:(unsigned long long)sortId
                        status:(SSKJobRecordStatus)status NS_UNAVAILABLE;

// --- CODE GENERATION MARKER

// This snippet is generated by /Scripts/sds_codegen/sds_generate.py. Do not manually edit it, instead run `sds_codegen.sh`.

// clang-format off

- (instancetype)initWithGrdbId:(int64_t)grdbId
                      uniqueId:(NSString *)uniqueId
      exclusiveProcessIdentifier:(nullable NSString *)exclusiveProcessIdentifier
                    failureCount:(NSUInteger)failureCount
                           label:(NSString *)label
                          sortId:(unsigned long long)sortId
                          status:(SSKJobRecordStatus)status
                invisibleMessage:(nullable TSOutgoingMessage *)invisibleMessage
                  isHighPriority:(BOOL)isHighPriority
                  isMediaMessage:(BOOL)isMediaMessage
                       messageId:(nullable NSString *)messageId
       removeMessageAfterSending:(BOOL)removeMessageAfterSending
                        threadId:(nullable NSString *)threadId
NS_DESIGNATED_INITIALIZER NS_SWIFT_NAME(init(grdbId:uniqueId:exclusiveProcessIdentifier:failureCount:label:sortId:status:invisibleMessage:isHighPriority:isMediaMessage:messageId:removeMessageAfterSending:threadId:));

// clang-format on

// --- CODE GENERATION MARKER

@end

NS_ASSUME_NONNULL_END
