//
//  HtmlParser.swift
//  ReactiveLyrics
//
//  Created by Alexandr Olferuk on 22/04/16.
//  Copyright © 2016 Alexandr Olferuk. All rights reserved.
//

import Alamofire
import RxSwift
import RxCocoa
import Kanna

protocol HtmlParser {
    func selectFromHtml(html: String) -> (selector: String, extractor: XMLElement -> String?) -> Observable<String>
    func buildHtml(html: String) throws -> (selector: String, extractor: XMLElement -> String) -> [String]
}

extension HtmlParser {
    func selectFromHtml(html: String) -> (selector: String, extractor: XMLElement -> String?) -> Observable<String> {
        return { selector, extractor in
            return Observable.create { observer in
                if let doc = Kanna.HTML(html: html, encoding: NSUTF8StringEncoding) {
                    for item in doc.xpath(selector) {
                        if let next = extractor(item) {
                            observer.onNext(next)
                        }
                    }
                    observer.onCompleted()
                }
                else {
                    observer.onError(RxError.Unknown)
                }
                return AnonymousDisposable { }
            }
        }
    }
    
    func buildHtml(html: String) throws -> (selector: String, extractor: XMLElement -> String) -> [String] {
        let doc = Kanna.HTML(html: html, encoding: NSUTF8StringEncoding)
        if (doc == nil) {
            throw RxError.NoElements
        }
        return { selector, extractor in
            var result: [String] = []
            for item in doc!.xpath(selector) {
                result.append(extractor(item))
            }
            return result
        }
    }

}