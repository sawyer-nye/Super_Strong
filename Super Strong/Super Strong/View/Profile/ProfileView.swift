//
//  ProfileView.swift
//  Super Strong
//
//  Created by Sawyer Nye on 11/10/20.
//

import SwiftUI
import Combine

struct ProfileView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @ObservedObject var user: UserMO
    
    @FetchRequest(entity: ProgramMO.entity(), sortDescriptors: [])
    private var programs: FetchedResults<ProgramMO>
    
    @State var showPrograms: Bool = false
    
    var body: some View {
        Form {
            Section(header: Text("Current Program")) {
                if let program = user.currentProgram {
                    HStack {
                        Spacer()
                        Text("\(program.programName)")
                        Spacer()
                    }
                    MaxSteppers(program: program)
                }
                HStack {
                    Spacer()
                    Button(action: { showPrograms.toggle() }) {
                        HStack {
                            Spacer()
                            Text(showPrograms ? "Collapse" : "Change Program")
                            Spacer()
                        }
                    }
                    Spacer()
                }
                if showPrograms {
                    ForEach(Array(programs)) { program in
                        NavigationLink(destination: ProgramView(user: user, program: program)) {
                            HStack {
                                Text("\(program.programName)")
                                Spacer()
                            }
                        }
                    }
                }
                
            }
            Section(header: Text("1RM Calculator")) {
                OneRepMax()
            }
        }
        .navigationBarHidden(true)
        .onDisappear { showPrograms = false }
    }
}
