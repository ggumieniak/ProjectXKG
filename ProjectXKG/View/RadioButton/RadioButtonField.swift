//
//  RadioButtonField
//  ProjectXKG
//
//  Created by Grzegorz Gumieniak on 15/09/2020.
//  Copyright © 2020 Grzegorz Gumieniak. All rights reserved.
//

import SwiftUI

struct RadioButtonField: View {

    @Environment(\.colorScheme) var colorScheme
    
    let id: String
    let label: String
    let size: CGFloat
    let textSize: CGFloat
    let isMarked: Bool
    let callback: (String) -> ()
    
    init(id: String, label: String, size: CGFloat, textSize: CGFloat, isMarked: Bool, callback: @escaping (String) -> ()) {
        self.id = id
        self.label = label
        self.size = size
        self.textSize = textSize
        self.isMarked = isMarked
        self.callback = callback
    }
    
    
    var body: some View {
        Button(action: {
            self.callback(self.id)
        }) {
            HStack(alignment: .center, spacing: 10) {
                Image(systemName: self.isMarked ? "largecircle.fill.circle" : "circle")
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: self.size, height: self.size)
                Text(label)
                    .font(Font.system(size: self.textSize))
                Spacer()
            }.foregroundColor(colorScheme == .light ? Color.black : Color.white) // napis
        }
    }
}
