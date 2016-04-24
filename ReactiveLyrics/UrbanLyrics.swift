//
//  UrbanLyrics.swift
//  ReactiveLyrics
//
//  Created by Alexandr Olferuk on 23/04/16.
//  Copyright © 2016 Alexandr Olferuk. All rights reserved.
//

struct UrbanLyrics: LyricsSearchable {
    var searchDomain: String {
        get {
            return "http://search.urbanlyrics.com/search.php"
        }
    }
    
    var searchResultsSelector: String {
        get {
            return "//tr/td/b/a"
        }
    }
    var searchResultsExtractor: HtmlExtractor {
        get {
            return { $0["href"]! }
        }
    }
    
    var lyricsTitleSelector: String {
        get {
            return "//div[@class='ArtistTitle']|//div[@class='SongTitle']"
        }
    }
    var lyricsTitleExtractor: HtmlExtractor {
        get {
            return { $0.text?.collapseWhitespace() ?? "" }
        }
    }
    var lyricsSelector: String {
        get {
            return "//tr/td[4]//tr[3]/td"
        }
    }
    var lyricsExtractor: HtmlExtractor {
        get {
            return { $0.text?.trimmed() ?? "" }
        }
    }
}