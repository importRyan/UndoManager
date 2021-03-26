//
//  ContentView.swift
//  DocumentTest
//
//  Created by Ryan Ferrell on 3/26/21.
//

import SwiftUI

struct ContentView: View {
    @Binding var document: DocumentTestDocument

    var body: some View {
        TextEditor(text: $document.text)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(document: .constant(DocumentTestDocument()))
    }
}
