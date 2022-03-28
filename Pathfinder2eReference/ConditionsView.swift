//
//  Conditions.swift
//  Pathfinder2eReference
//
//  Created by bluepill on 15/3/2022.
//

import SwiftUI

struct ConditionsView: View {
    @State private var conditions: Conditions? = nil
    @State private var selectedCondition: String? = nil
    
    @AppStorage("lastSelectedCondition") private var lastSelectedCondition: String = ""

    var body: some View {
        ScrollViewReader { scroller in
        
            List(selection: $selectedCondition) {
                ForEach(conditions?.conditions ?? Array<Condition>(), id:\.name) { condition in
                    NavigationLink(destination: ConditionsDetailView(condition: condition), tag: condition.name, selection: $selectedCondition) {
                        HStack {
                            Label(condition.name.isEmpty ? "!! DATA ERROR !!" : condition.name.capitalized, systemImage: "doc.text")
                            Spacer()
                            Image(systemName: "person")
                                .foregroundColor(Color.gray)
                        }
                    }
                    .id(condition.name)
                    .frame(height: 20.0)
                }
            }
            .listStyle(SidebarListStyle())
            .navigationTitle(selectedCondition == nil ? Category.conditions.rawValue.capitalized : "\(selectedCondition!.capitalized) condition")
            .onAppear() {
                conditions = Conditions.load(jsonResource: "Conditions")
                selectedCondition = lastSelectedCondition.isEmpty ? ( conditions?.conditions.first?.name ?? nil ) : lastSelectedCondition
                scroller.scrollTo(selectedCondition)
            }
            .onChange(of: selectedCondition) { newValue in
                lastSelectedCondition = newValue ?? ""
                scroller.scrollTo(newValue)
            }
            
        }
    }
}

struct ConditionsView_Previews: PreviewProvider {
    static var previews: some View {
        ConditionsView()
    }
}
