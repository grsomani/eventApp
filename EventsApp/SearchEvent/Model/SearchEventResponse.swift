//
//  SearchEventResponse.swift
//  EventsApp
//
//  Created by Ganesh Somani on 15/11/21.
//

import Foundation

// MARK: - Welcome
struct SearchEventResponse: Codable {
    let events: [Event]?
}

// MARK: - Event
struct Event: Codable {
    let type: String?
    let id: Int?
    let datetimeUTC: String?
    let venue: Venue?
    let datetimeTbd: Bool?
    let performers: [Performer]?
    let isOpen: Bool?
    let datetimeLocal: String?
    let timeTbd: Bool?
    let shortTitle, visibleUntilUTC: String?
    let url: String?
    let score: Double?
    let announceDate, createdAt: String?
    let dateTbd: Bool?
    let title: String?
    let popularity: Double?
    let eventDescription, status: String?
    let conditional: Bool?
    let enddatetimeUTC: String?

    enum CodingKeys: String, CodingKey {
        case type, id
        case datetimeUTC = "datetime_utc"
        case venue
        case datetimeTbd = "datetime_tbd"
        case performers
        case isOpen = "is_open"
        case datetimeLocal = "datetime_local"
        case timeTbd = "time_tbd"
        case shortTitle = "short_title"
        case visibleUntilUTC = "visible_until_utc"
        case url, score
        case announceDate = "announce_date"
        case createdAt = "created_at"
        case dateTbd = "date_tbd"
        case title, popularity
        case eventDescription = "description"
        case status
        case conditional
        case enddatetimeUTC = "enddatetime_utc"
    }
}

// MARK: - Performer
struct Performer: Codable {
    let type, name: String?
    let image: String?
    let id: Int?
    let images: Images?
    let hasUpcomingEvents, primary: Bool?
    let stats: PerformerStats?
    let imageAttribution, url: String?
    let score: Double?
    let slug: String?
    let homeVenueID: Int?
    let shortName: String?
    let numUpcomingEvents: Int?
    let imageLicense: String?
    let popularity: Int?
    let homeTeam: Bool?
    let location: Location?
    let awayTeam: Bool?

    enum CodingKeys: String, CodingKey {
        case type, name, image, id, images
        case hasUpcomingEvents = "has_upcoming_events"
        case primary, stats
        case imageAttribution = "image_attribution"
        case url, score, slug
        case homeVenueID = "home_venue_id"
        case shortName = "short_name"
        case numUpcomingEvents = "num_upcoming_events"
        case imageLicense = "image_license"
        case popularity
        case homeTeam = "home_team"
        case location
        case awayTeam = "away_team"
    }
}

// MARK: - Images
struct Images: Codable {
    let huge: String?
}

// MARK: - Location
struct Location: Codable {
    let lat, lon: Double?
}

// MARK: - PerformerStats
struct PerformerStats: Codable {
    let eventCount: Int?

    enum CodingKeys: String, CodingKey {
        case eventCount = "event_count"
    }
}

// MARK: - DocumentSource
struct DocumentSource: Codable {
    let sourceType, generationType: String?

    enum CodingKeys: String, CodingKey {
        case sourceType = "source_type"
        case generationType = "generation_type"
    }
}

// MARK: - Venue
struct Venue: Codable {
    let state, nameV2, postalCode, name: String?
    let timezone: String?
    let url: String?
    let score: Double?
    let location: Location?
    let address, country: String?
    let hasUpcomingEvents: Bool?
    let numUpcomingEvents: Int?
    let city, slug, extendedAddress: String?
    let id, popularity: Int?
    let metroCode, capacity: Int?
    let displayLocation: String?

    enum CodingKeys: String, CodingKey {
        case state
        case nameV2 = "name_v2"
        case postalCode = "postal_code"
        case name, timezone, url, score, location, address, country
        case hasUpcomingEvents = "has_upcoming_events"
        case numUpcomingEvents = "num_upcoming_events"
        case city, slug
        case extendedAddress = "extended_address"
        case id, popularity
        case metroCode = "metro_code"
        case capacity
        case displayLocation = "display_location"
    }
}
