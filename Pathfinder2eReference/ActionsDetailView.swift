//
//  ActionsDetailView.swift
//  Pathfinder2eReference
//
//  Created by bluepill on 20/3/2022.
//

import SwiftUI

// ***** These views below are reused in other DetailView structs *****
struct Name: View {
    let name: String
    let imageName: String
    
    var body: some View {
        Label {
            Text(name.capitalized)
                .font(.title)
                .foregroundStyle(.foreground)
        } icon: {
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .foregroundStyle(.gray)
        }
        .frame(maxHeight: 26.0)
    }
}

struct Affects: View {
    let affects: Set<Affect>
    
    var body: some View {
        HStack {
            Text("affects:")
                .modifier(NormalText())
                .frame(minHeight: 20.0)
            ForEach(affects.sorted(by: { $0.rawValue <= $1.rawValue }), id: \.rawValue) { affect in
                Text(affect.rawValue)
                    .modifier(ColoredListText(color: royalBlue))
                    .lineLimit(1)
            }
        }
    }
}

struct TitleAndText: View {
    let title: String
    let text: String
    
    var body: some View {
        Text(title)
            .modifier(HeadingText(padded: true))
            .frame(maxWidth: .infinity, alignment: .leading)
        Text(text.isEmpty ? "None." : text)
            .modifier(NormalText())
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct DurationAndType: View {
    let duration: Int
    let type: Behaviour
    
    var body: some View {
        HStack {
            switch duration {
            case 0:
                Image(systemName: "0.circle")
                    .foregroundStyle(.gray)
            case 1:
                Image(systemName: "1.circle")
                    .foregroundStyle(.gray)
            case 2:
                Image(systemName: "2.circle")
                    .foregroundStyle(.gray)
            case 3:
                Image(systemName: "3.circle")
                    .foregroundStyle(.gray)
            default:
                Image(systemName: "questionmark.circle")
                    .foregroundStyle(.gray)
            }
            
            Text(type.rawValue.capitalized)
                .modifier(HeadingText(padded: false))
        }
    }
}

struct Traits: View {
    let traits: Set<Trait>
    
    var body: some View {
        HStack {
            Text("traits:")
                .modifier(NormalText())
                .frame(minHeight: 20.0)
            ForEach(traits.sorted(by: { $0.rawValue <= $1.rawValue }), id: \.rawValue) { trait in
                Text(trait.rawValue)
                    .modifier(ColoredListText(color: tomato))
                    .lineLimit(1)
            }
        }
    }
}

// ***** The views below are NOT reused in other structs *****
struct ActionsDetailView: View {
    let action: Action
    
    var body: some View {
        VStack {
            Name(name: action.name.isEmpty ? "!! DATA ERROR !!" : action.name.capitalized, imageName: "bolt.shield")
                .frame(maxWidth: .infinity, alignment: .leading)
            Affects(affects: action.affects)
                .frame(maxWidth: .infinity, alignment: .leading)

            DurationAndType(duration: action.duration, type: action.type)
                .padding(.top)
                .frame(maxWidth: .infinity, alignment: .leading)
            Traits(traits: action.traits)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            // mode

            ScrollView([.vertical], showsIndicators: true) {
                TitleAndText(title: "Trigger", text: action.trigger)

                TitleAndText(title: "Requirement", text: action.requirement)

                TitleAndText(title: "Description", text: action.description)

                TitleAndText(title: "Critical Success", text: action.criticalSuccess)

                TitleAndText(title: "Success", text: action.success)

                TitleAndText(title: "Failure", text: action.failure)

                TitleAndText(title: "Critical Failure", text: action.criticalFailure)
            }
        }
        .padding()
        .frame(minWidth: 350.0, idealWidth: 400.0)
    }

    struct Trigger: View {
        let action: Action
        
        var body: some View {
            Text("Trigger")
                .modifier(HeadingText(padded: true))
            Text(action.trigger.isEmpty ? "None." : action.trigger)
                .modifier(NormalText())
        }
    }

    struct Requirement: View {
        let action: Action
        
        var body: some View {
            Text("Requirement")
                .modifier(HeadingText(padded: true))
            Text(action.requirement.isEmpty ? "None." : action.requirement)
                .modifier(NormalText())
        }
    }

    struct Description: View {
        let action: Action
        
        var body: some View {
            Text("Description")
                .modifier(HeadingText(padded: true))
            Text(action.description.isEmpty ? "None." : action.description)
                .modifier(NormalText())
        }
    }

}

struct ActionsDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ActionsDetailView(action: Action(name: "Name", type: Behaviour.action, duration: -1, mode: .encounter, traits: [Trait.attack], trigger: "Trigger.", requirement: "Requirement.", description: "Description.", criticalSuccess: "Critical success.", success: "Success.", failure: "Failure.", criticalFailure: "Critical failure.", affects: [Affect.player]))
    }
}
