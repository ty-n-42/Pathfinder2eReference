//
//  Conditions.swift
//  Pathfinder2eReference
//
//  Created by bluepill on 15/3/2022.
//

import SwiftUI
/*
 To read the json data:
 let path = Bundle.main.path(forResource: "filename", ofType: "json")
 let jsonData = try? NSData(contentsOfFile: path!, options: NSData.ReadingOptions.mappedIfSafe)
 */

/*
 Some conditions have a numerical value, called a condition value, indicated by a numeral following the condition. This value conveys the severity of a condition, and such conditions often give you a bonus or penalty equal to their value. These values can often be reduced by skills, spells, or simply waiting. If a condition value is ever reduced to 0, the condition ends.
 
 Some conditions override others. This is always specified in the entry for the overriding condition. When this happens, all effects of the overridden condition are suppressed until the overriding condition ends. The overridden condition’s duration continues to elapse, and it might run out while suppressed.
 */

enum Affect:String, Codable {
    case player
    case others
    case item
}

struct Condition: Codable {
    var name: String // name for the condition
    var description: String // explanation of the condition
    var affects: Set<Affect> // what the condition affects
}

struct Conditions: Codable {
    var description: String // explanation of what conditions are
    var conditions: [Condition] // collection of conditions
}

struct ConditionsView: View {
    @State private var conditions: Conditions? = nil
    @State private var selectedCondition: String? = nil

    var body: some View {
        List(conditions?.conditions ?? Array<Condition>(), id:\.name) { condition in
            NavigationLink(destination: ConditionsDetailView(condition: condition), tag: condition.name, selection: $selectedCondition) {
                Label(condition.name, systemImage: "doc.text")
            }
        }
        .listStyle(SidebarListStyle())
        .navigationTitle(selectedCondition == nil ? Category.conditions.rawValue.capitalized : "\(selectedCondition!) condition")
        .onAppear() {
            loadJson("Conditions") { jsonData in
                do {
                    conditions = try JSONDecoder().decode(Conditions.self, from: jsonData)
                } catch DecodingError.dataCorrupted {
                    fatalError("unable to decode Conditions data: JSON format is invalid")
                } catch {
                    fatalError("unable to decode Conditions data: data fields are invalid")
                }
                // note: conditions should never be nil by this point
            }
        }
    }
    
    private func loadJson(_ resourceName: String, onLoad: (Data) -> Void) {
        // find the file resource
        guard let fileURL = Bundle.main.url(forResource: resourceName, withExtension: "json")  else {
            fatalError("unable to retrieve \(resourceName).json location")
        }
        guard let data = try? Data(contentsOf: fileURL) else {
            fatalError("unable to load \(resourceName).json contents")
        }
        onLoad(data)
    }


//    @State private var selectedCategory: String? = nil
//
//    @State private var selectedCondition: String? = nil
//    @State private var navLinkActivated: Bool = false
//
//    var body: some View {
//        NavigationView {
//            List(["Actions", "Conditions", "Skills", "All"], id:\.self) { category in
//                NavigationLink(destination: CollectionView(category: category), tag: category, selection: $selectedCategory) {
//                    HStack {
//                        Image(systemName: "folder")
//                        Text(category)
//                    }
//                }
//            }
//            .listStyle(SidebarListStyle())
//            .frame(minWidth: 200.0)
//
//            CollectionView(category: nil)
//
//            VStack {
//                ScrollView {
//                    Text(conditions.description).font(.body.italic())
//                        .padding()
//                }
//                Spacer()
//            }
//
//            Text("This is another column")
//        }
//        .navigationViewStyle(.columns)
//        .toolbar {
//            ToolbarItem(placement: .navigation) {
//                Button(action: toggleSidebar) {
//                    Image(systemName: "sidebar.leading")
//                }
//            }
//        }
////        .frame(minWidth: 500.0, idealWidth: 400.0, maxWidth: .infinity, minHeight: 300.0, idealHeight: .infinity, maxHeight: .infinity)
//        .onAppear() {
//            loadJson("Conditions") { jsonData in
//                do {
//                    conditions = try JSONDecoder().decode(Conditions.self, from: jsonData)
//                } catch DecodingError.dataCorrupted {
//                    fatalError("unable to decode Conditions data: JSON format is invalid")
//                } catch {
//                    fatalError("unable to decode Conditions data: data fields are invalid")
//                }
//            }
//        }
//    }
//
//    private func toggleSidebar() {
//        #if os(iOS)
//        #else
//        NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
//        #endif
//    }
//
//    struct CollectionView: View {
//        let category: String?
//        @Binding private var conditions
//
//        var body: some View {
//            List(conditions.conditions, id:\.name) { condition in
//                NavigationLink(condition.name, tag: condition.name, selection: $selectedCondition) {
//                    DetailView(condition: condition)
//                }
//            }
////            .navigationTitle("Conditions")
//            .listStyle(SidebarListStyle())
//            .frame(minWidth: 100.0, idealWidth: 150, maxWidth: .infinity, minHeight: 200.0, idealHeight: 300, maxHeight: .infinity, alignment: .leading)
//        }
//    }
//
//    struct DetailView: View {
//        let condition: Condition
//
//        var body: some View {
//            VStack(alignment: .center) {
//                ScrollView {
//                    Text(.init(condition.description))
//                        .padding()
//                }
//                Spacer()
//            }
//        }
//    }
//
//    private func loadJson(_ resourceName: String, onLoad: (Data) -> Void) {
//        // find the file resource
//        guard let fileURL = Bundle.main.url(forResource: resourceName, withExtension: "json")  else {
//            fatalError("unable to retrieve \(resourceName).json location")
//        }
//        guard let data = try? Data(contentsOf: fileURL) else {
//            fatalError("unable to load \(resourceName).json contents")
//        }
//        onLoad(data)
//    }

}

struct ConditionsView_Previews: PreviewProvider {
    static var previews: some View {
        ConditionsView()
    }
}
