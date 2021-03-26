//
//  DocumentTestApp.swift
//  DocumentTest
//
//  Created by Ryan Ferrell on 3/26/21.
//

import SwiftUI

@main
struct DocumentTestApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: DocumentTestDocument()) { file in
            ContentView(document: file.$document)
        }
    }
}
