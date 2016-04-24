//
//  LyricsSearchable.swift
//  ReactiveLyrics
//
//  Created by Alexandr Olferuk on 23/04/16.
//  Copyright © 2016 Alexandr Olferuk. All rights reserved.
//

import RxSwift
import Kanna

typealias HtmlExtractor = (XMLElement) -> String

protocol LyricsSearchable: HtmlRequest, HtmlParser {
    var searchDomain: String { get }

    var searchResultsSelector: String { get }
    var searchResultsExtractor: HtmlExtractor { get }

    var lyricsTitleSelector: String { get }
    var lyricsTitleExtractor: HtmlExtractor { get }
    var lyricsSelector: String { get }
    var lyricsExtractor: HtmlExtractor { get }

    func searchRequest(query: String) -> Observable<String>
    func searchResultsParse(html: String) -> Observable<String>
    func parse(html: String) -> Observable<(String, String)>
    func isSongValid(song: (String, String), query: String) -> Bool
    func joinSong(song: (String, String)) -> String

    func search(query: String) -> Observable<String>
    func getUri(query: String) -> Observable<String>
}

extension LyricsSearchable {
    func searchRequest(query: String) -> Observable<String> {
        return self.request(self.searchDomain, params: ["q": query])
    }

    func searchResultsParse(html: String) -> Observable<String> {
        return self.selectFromHtml(html)(selector: self.searchResultsSelector, extractor: self.searchResultsExtractor) // take(1)
    }

    func parse(html: String) -> Observable<(String, String)> {
        let doc = try! self.buildHtml(html)
        let title = doc(selector: self.lyricsTitleSelector, extractor: self.lyricsTitleExtractor)
        let body = doc(selector: self.lyricsSelector, extractor: self.lyricsExtractor)
        return Observable.just((title.joinWithSeparator("\n"), body.joinWithSeparator("\n")))
    }

    func isSongValid(song: (String, String), query: String) -> Bool {
        let title = song.0
        let toSet: String -> Set<String> = { Set($0.split("\\W+").map { $0.lowercaseString }) }
        let titleSet = toSet(title)
        let querySet = toSet(query)
        return querySet.isSubsetOf(titleSet)
    }

    func joinSong(song: (String, String)) -> String {
        return song.0 + "\n\n" + song.1
    }

// MARK: Facade functions

    func search(query: String) -> Observable<String> {
        return self.searchRequest(query)
            .flatMap(self.searchResultsParse)
            .flatMap(self.request)
            .flatMap(self.parse)
            .filter { self.isSongValid($0, query: query) }
            .map(joinSong)
    }

    func getUri(query: String) -> Observable<String> {
        return self.searchRequest(query)
            .flatMap(self.searchResultsParse)
    }
}