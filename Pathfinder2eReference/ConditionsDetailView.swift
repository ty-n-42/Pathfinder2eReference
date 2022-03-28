//
//  ConditionsDetailView.swift
//  Pathfinder2eReference
//
//  Created by bluepill on 19/3/2022.
//

import SwiftUI

struct ConditionsDetailView: View {
    let condition: Condition
    
    var body: some View {
        VStack {
            Name(name: condition.name.isEmpty ? "!! DATA ERROR !!" : condition.name.capitalized, imageName: "person")
                .frame(maxWidth: .infinity, alignment: .leading)
            Affects(affects: condition.affects)
                .frame(maxWidth: .infinity, alignment: .leading)

            ScrollView([.vertical], showsIndicators: true) {
                TitleAndText(title: "Description", text: condition.description)
            }
        }
        .padding()
        .frame(minWidth: 350.0, idealWidth: 400.0)
    }
}

struct ConditionsDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ConditionsDetailView(condition: Condition(name: "Name", description: "Descriprion", affects: [Affect.player]))
    }
}
