//
//  LiftDbView.swift
//  Super Strong
//
//  Created by Sawyer Nye on 11/16/20.
//

import SwiftUI

enum DbMode {
    case selectLift, standard
}

struct LiftDbView: View {
    let dbMode: DbMode

    @State var searchText: String = ""
    @Binding var selectedLift: LiftMO?
    
    init(dbMode: DbMode, selectedLift: Binding<LiftMO?>?) {
        self.dbMode = dbMode
        self._selectedLift = selectedLift ?? Binding.constant(nil)
    }
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \LiftMO.liftName, ascending: true)])
    private var lifts: FetchedResults<LiftMO>
    
    var filteredLifts: [LiftMO] {
        Array(lifts).filter {
            $0.liftName.lowercased().hasPrefix(searchText.lowercased()) ||
                $0.primaryMuscleGroup.lowercased().hasPrefix(searchText.lowercased())
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                SearchBar(searchText: $searchText)
                ScrollView {
                    LazyVStack {
                        Spacer()
                        ForEach(filteredLifts) { lift in
                            LiftDbRow(lift: lift, parentWidth: geometry.size.width, dbMode: dbMode, selectedLift: $selectedLift)
                            Divider()
                        }
                        Spacer()
                    }
                }
                Spacer()
            }
        }
    }
}

struct LiftDbViewPrievew: PreviewProvider {
    static var previews: some View {
        return LiftDbView(dbMode: .standard, selectedLift: nil).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
