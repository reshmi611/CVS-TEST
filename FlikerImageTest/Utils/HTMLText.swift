//
//  HTML.swift
//  FlikerImageTest
//
//

import Foundation
import SwiftUI
import WebKit

struct HtmlText: UIViewRepresentable {
    let htmlContent: String
    @Binding var size: CGSize
    
    private let webView = WKWebView()
    var sizeObserver: NSKeyValueObservation?
    
    func makeUIView(context: Context) -> WKWebView {
        webView.scrollView.isScrollEnabled = false //<-- Here
        webView.navigationDelegate = context.coordinator
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(htmlContent, baseURL: nil)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        let parent: HtmlText
        var sizeObserver: NSKeyValueObservation?
        
        init(parent: HtmlText) {
            self.parent = parent
            sizeObserver = parent.webView.scrollView.observe(\.contentSize, options: [.new], changeHandler: { (object, change) in
                parent.size = change.newValue ?? .zero
            })
        }
    }
}
extension View {
    func hidden(_ shouldHide: Bool) -> some View {
        opacity(shouldHide ? 0 : 1)
    }
}
