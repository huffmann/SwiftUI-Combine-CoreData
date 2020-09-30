//
//  ItemView.swift
//  Starter
//
//  Created by Xumak on 23/09/20.
//

import SwiftUI

struct ItemView: View {
    var title: String = ""
    var createdAt: Date
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                Text("\(createdAt, formatter: itemFormatter)")
                    .font(.caption)
            }
        }
    }
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView(createdAt: Date())
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()
