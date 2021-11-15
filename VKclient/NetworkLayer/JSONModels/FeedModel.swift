//
//  FeedModel.swift
//  VKclient
//
//  Created by Dmitrii KRY on 14.11.2021.
//

import Foundation

// MARK: - Welcome
struct FeedModel: Codable {
    let response: Response
}

// MARK: - Response
struct Response: Codable {
    let items: [Item]
    let profiles: [Profile]?
    let groups: [Group]?
    let nextFrom: String?

    enum CodingKeys: String, CodingKey {
        case items, profiles, groups
        case nextFrom = "next_from"
    }
}

// MARK: - Group
struct Group: Codable {
    let id: Int
    let name, screenName: String
    let isClosed: Int
    let type: String
    let isAdmin, isMember, isAdvertiser: Int
    let photo50, photo100, photo200: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case screenName = "screen_name"
        case isClosed = "is_closed"
        case type
        case isAdmin = "is_admin"
        case isMember = "is_member"
        case isAdvertiser = "is_advertiser"
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case photo200 = "photo_200"
    }
}

// MARK: - Item
struct Item: Codable {
    let sourceID, date: Int
    let canDoubtCategory, canSetCategory: Bool
    let postType: PostTypeEnum
    let text: String
    let markedAsAds: Int
    let attachments: [Attachment]
    let postSource: PostSource
    let comments: Comments
    let likes: Likes
    let reposts: Reposts
    let views: Views
    let isFavorite: Bool
    let donut: Donut
    let shortTextRate: Double
    let postID: Int
    let type: PostTypeEnum
    let topicID, signerID, carouselOffset: Int?

    enum CodingKeys: String, CodingKey {
        case sourceID = "source_id"
        case date
        case canDoubtCategory = "can_doubt_category"
        case canSetCategory = "can_set_category"
        case postType = "post_type"
        case text
        case markedAsAds = "marked_as_ads"
        case attachments
        case postSource = "post_source"
        case comments, likes, reposts, views
        case isFavorite = "is_favorite"
        case donut
        case shortTextRate = "short_text_rate"
        case postID = "post_id"
        case type
        case topicID = "topic_id"
        case signerID = "signer_id"
        case carouselOffset = "carousel_offset"
    }
}

// MARK: - Attachment
struct Attachment: Codable {
    let type: String
    let poll: Poll?
    let link: Link?
    let video: Video?
    let photo: Photo?
}

// MARK: - Link
struct Link: Codable {
    let url: String
    let title, caption, linkDescription: String
    let photo: Photo
    let isFavorite: Bool

    enum CodingKeys: String, CodingKey {
        case url, title, caption
        case linkDescription = "description"
        case photo
        case isFavorite = "is_favorite"
    }
}

// MARK: - Photo
struct Photo: Codable {
    let albumID, date, id, ownerID: Int
    let hasTags: Bool
    let sizes: [Size]
    let text: String
    let userID: Int
    let accessKey: String?
    let postID: Int?

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case date, id
        case ownerID = "owner_id"
        case hasTags = "has_tags"
        case sizes, text
        case userID = "user_id"
        case accessKey = "access_key"
        case postID = "post_id"
    }
}

// MARK: - Size
struct Size: Codable {
    let height: Int
    let url: String
    let type: String?
    let width: Int
    let withPadding: Int?

    enum CodingKeys: String, CodingKey {
        case height, url, type, width
        case withPadding = "with_padding"
    }
}

// MARK: - Poll
struct Poll: Codable {
    let multiple: Bool
    let endDate: Int
    let closed, isBoard, canEdit, canVote: Bool
    let canReport, canShare: Bool
    let created, id, ownerID: Int
    let question: String
    let votes: Int
    let disableUnvote, anonymous: Bool
    let answerIDS: [Int]
    let embedHash: String
    let answers: [Answer]
    let authorID: Int
    let background: Background

    enum CodingKeys: String, CodingKey {
        case multiple
        case endDate = "end_date"
        case closed
        case isBoard = "is_board"
        case canEdit = "can_edit"
        case canVote = "can_vote"
        case canReport = "can_report"
        case canShare = "can_share"
        case created, id
        case ownerID = "owner_id"
        case question, votes
        case disableUnvote = "disable_unvote"
        case anonymous
        case answerIDS = "answer_ids"
        case embedHash = "embed_hash"
        case answers
        case authorID = "author_id"
        case background
    }
}

// MARK: - Answer
struct Answer: Codable {
    let id: Int
    let rate: Double
    let text: String
    let votes: Int
}

// MARK: - Background
struct Background: Codable {
    let angle: Int
    let color: String
    let id: Int
    let name: String
    let points: [Point]
    let type: String
}

// MARK: - Point
struct Point: Codable {
    let color: String
    let position: Int
}

// MARK: - Video
struct Video: Codable {
    let accessKey: String
    let canComment, canLike, canRepost, canSubscribe: Int
    let canAddToFaves, canAdd, comments, date: Int
    let videoDescription: String
    let duration: Int
    let image: [Size]
    let firstFrame: [Size]?
    let width, height: Int?
    let id, ownerID: Int
    let title: String
    let isFavorite: Bool
    let trackCode: String
    let videoRepeat: Int?
    let type: String
    let views: Int
    let userID, localViews: Int?
    let platform: String?

    enum CodingKeys: String, CodingKey {
        case accessKey = "access_key"
        case canComment = "can_comment"
        case canLike = "can_like"
        case canRepost = "can_repost"
        case canSubscribe = "can_subscribe"
        case canAddToFaves = "can_add_to_faves"
        case canAdd = "can_add"
        case comments, date
        case videoDescription = "description"
        case duration, image
        case firstFrame = "first_frame"
        case width, height, id
        case ownerID = "owner_id"
        case title
        case isFavorite = "is_favorite"
        case trackCode = "track_code"
        case videoRepeat = "repeat"
        case type, views
        case userID = "user_id"
        case localViews = "local_views"
        case platform
    }
}

// MARK: - Comments
struct Comments: Codable {
    let canPost, count: Int
    let groupsCanPost: Bool?

    enum CodingKeys: String, CodingKey {
        case canPost = "can_post"
        case count
        case groupsCanPost = "groups_can_post"
    }
}

// MARK: - Donut
struct Donut: Codable {
    let isDonut: Bool

    enum CodingKeys: String, CodingKey {
        case isDonut = "is_donut"
    }
}

// MARK: - Likes
struct Likes: Codable {
    let canLike, count, userLikes, canPublish: Int

    enum CodingKeys: String, CodingKey {
        case canLike = "can_like"
        case count
        case userLikes = "user_likes"
        case canPublish = "can_publish"
    }
}

// MARK: - PostSource
struct PostSource: Codable {
    let type: PostSourceType
}

enum PostSourceType: String, Codable {
    case vk = "vk"
}

enum PostTypeEnum: String, Codable {
    case post = "post"
}

// MARK: - Reposts
struct Reposts: Codable {
    let count, userReposted: Int

    enum CodingKeys: String, CodingKey {
        case count
        case userReposted = "user_reposted"
    }
}

// MARK: - Views
struct Views: Codable {
    let count: Int
}

// MARK: - Profile
struct Profile: Codable {
    let firstName: String
    let id: Int
    let lastName: String
    let canAccessClosed, isClosed: Bool?
    let sex: Int
    let screenName: String?
    let photo50, photo100: String
    let onlineInfo: OnlineInfo
    let online: Int
    let deactivated: String?

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case id
        case lastName = "last_name"
        case canAccessClosed = "can_access_closed"
        case isClosed = "is_closed"
        case sex
        case screenName = "screen_name"
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case onlineInfo = "online_info"
        case online, deactivated
    }
}

// MARK: - OnlineInfo
struct OnlineInfo: Codable {
    let visible, isOnline, isMobile: Bool
    let lastSeen, appID: Int?

    enum CodingKeys: String, CodingKey {
        case visible
        case isOnline = "is_online"
        case isMobile = "is_mobile"
        case lastSeen = "last_seen"
        case appID = "app_id"
    }
}
