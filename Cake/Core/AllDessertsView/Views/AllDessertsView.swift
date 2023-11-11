//
//  ContentView.swift
//  Cake
//
//  Created by Aaron Wilson on 11/6/23.
//

import SwiftUI

// I wouldn't call the folder "AllDesertsView", Just `AllDserts`, because technically there's more stuff than "views" in this, and that name is then closer to being groups by feature rather than by view

struct AllDessertsView: View {
    
    // don't need the type, because of type inference
    
    @StateObject var viewModel = AllDessertsViewModel()
    @State private var loadingBuffer = true // this could go in teh viewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(viewModel.sortedDesserts, id: \.idMeal) { dessert in
                        // creating Image here to be passed into dependent views
                        let image = QuickImage(url: URL(string: dessert.strMealThumb))
                        NavigationLink {
                            DessertDetailsView(dataService: viewModel.dataService, mealId: dessert.idMeal, image: image)
                        } label: {
                            DessertRowView(dessert: dessert, image: image)
                                .overlay {
                                    if loadingBuffer {
                                        Rectangle()
                                            .fill(.ultraThinMaterial)
                                    }
                                }
                        }
                        .disabled(loadingBuffer)
                    }
                }
                .padding(.horizontal, 4)
            }
            .alert("Error", isPresented: $viewModel.showAlert, actions: {
                Button {
                    viewModel.showAlert = false
                } label: {
                    Text("Dismiss")
                }

            }, message: {
                Text(viewModel.errorMessage ?? "")
            })
            .navigationTitle("All Desserts")
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                    loadingBuffer = false
                }
            }
        }
    }
}

#Preview {
    AllDessertsView()
}
