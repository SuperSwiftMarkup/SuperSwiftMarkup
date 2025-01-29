//
//  BasicMarkdownPreviewApp.swift
//  BasicMarkdownPreview
//
//  Created by Colbyn Wadman on 1/28/25.
//

import SwiftUI
import ssm_rich_text_engine
import ssm_system_utilities

@main
struct BasicMarkdownPreviewApp: App {
    var body: some Scene {
        WindowGroup {
//            RichTextScrollViewRepresentable()
            Text("TODO")
        }
    }
}

//fileprivate struct RichTextViewRepresentable: NSViewRepresentable {
//    func makeNSView(context: Context) -> Self.NSViewType {
////        let view = NSView(frame: CGRect(origin: .zero, size: .init(width: 500, height: 500)))
////        view.wantsLayer = true
////        view.layer?.backgroundColor = NSColor.red.cgColor
//        let view = SSRichTextView(frame: .init(origin: .zero, size: .init(width: 500, height: 500)))
//        
//        return view
//    }
//    
//    func updateNSView(_ nsView: Self.NSViewType, context: Context) {
//        print("nsView.bounds", nsView.bounds.debugDescription)
//        print("nsView.frame", nsView.frame.debugDescription)
////        nsView.layer?.setNeedsLayout()
////        nsView.needsLayout = true
////        nsView.setNeedsDisplay(nsView.bounds)
//    }
//    
//    typealias NSViewType = SSRichTextView
//}

//fileprivate struct RichTextScrollViewRepresentable: NSViewRepresentable {
//    func makeNSView(context: Context) -> Self.NSViewType {
//        return SSRichTextScrollView.new()
//    }
//    
//    func updateNSView(_ nsView: Self.NSViewType, context: Context) {}
//    
//    typealias NSViewType = SSRichTextScrollView
//    
//    
//}

