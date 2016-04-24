//
//  AzLyrics.swift
//  ReactiveLyrics
//
//  Created by Alexandr Olferuk on 23/04/16.
//  Copyright © 2016 Alexandr Olferuk. All rights reserved.
//

struct AzLyrics: LyricsSearchable {
    var searchDomain: String {
        get {
            return "http://search.azlyrics.com/search.php"
        }
    }
    
    var searchResultsSelector: String {
        get {
            return "//td[@class='text-left visitedlyr']/a"
        }
    }
    var searchResultsExtractor: HtmlExtractor {
        get {
            return { $0["href"]! }
        }
    }
    
    var lyricsTitleSelector: String {
        get {
            return "//div[@class='col-xs-12 col-lg-8 text-center']//b"
        }
    }
    var lyricsTitleExtractor: HtmlExtractor {
        get {
            return { $0.text?.collapseWhitespace() ?? "" }
        }
    }
    var lyricsSelector: String {
        get {
            return "//div[@class='col-xs-12 col-lg-8 text-center']/div[6]"
        }
    }
    var lyricsExtractor: HtmlExtractor {
        get {
            return { $0.text?.trimmed() ?? "" }
        }
    }
}