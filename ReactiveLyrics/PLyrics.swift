//
//  PLyrics.swift
//  ReactiveLyrics
//
//  Created by Alexandr Olferuk on 23/04/16.
//  Copyright © 2016 Alexandr Olferuk. All rights reserved.
//

import SwiftString

struct PLyrics: LyricsSearchable {
    var searchDomain: String {
        get {
            return "http://search.plyrics.com/search.php"
        }
    }
    
    var searchResultsSelector: String {
        get {
            return "//div[@class='body']//a"
        }
    }
    var searchResultsExtractor: HtmlExtractor {
        get {
            return { $0["href"]! }
        }
    }
    
    var lyricsTitleSelector: String {
        get {
            return "//div[@class='content_lyr']/h1|//div[@class='content_lyr']//b"
        }
    }
    var lyricsTitleExtractor: HtmlExtractor {
        get {
            return { $0.text?.collapseWhitespace() ?? "" }
        }
    }
    var lyricsSelector: String {
        get {
            return "//div[@class='content_lyr']"
        }
    }
    var lyricsExtractor: HtmlExtractor {
        get {
            return { self.getExactLyrics($0.text ?? "") }
        }
    }
    
    
    func getExactLyrics(content: String) -> String {
        if content == "" {
            return ""
        }
        let parts = content.split("Ringtone to your Cell\\s+")
        if parts.count < 2 {
            return ""
        }
        let almostLyrics = parts[1]
        let anotherParts = almostLyrics.split("\\s+Send \"")
        return anotherParts[0].trimmed()
    }
}