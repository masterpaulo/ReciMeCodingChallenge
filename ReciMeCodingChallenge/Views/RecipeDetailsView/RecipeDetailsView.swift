//
//  RecipeDetailsView.swift
//  ReciMeCodingChallenge
//
//  Created by John Paulo on 1/15/23.
//

import SwiftUI

struct RecipeDetailsView: View {
    
    @StateObject var viewModel: RecipeDetailsViewModel
    
    var body: some View {
        if viewModel.loadingState == .loading {
            ProgressView()
                .frame(width: 120, height: 120, alignment: .center)
                .font(.system(size: 100))
        } else {
            ScrollView {
                VStack(spacing: 12) {
                    titleHeaderView
                    
                    authorHeaderSubView
                    
                    summaryView
                    
                    itemImageView
                    
                    descriptionView
                    
                    ingredientsView
                    
                    methodsView
                    
                    taglistView
                }
                .padding(.top, 20)
                .padding(.horizontal, 12)
            }
            .frame(maxHeight: .infinity)
        }
    }
    
    // MARK: - Title View
    
    @ViewBuilder
    var titleHeaderView: some View {
        HStack {
            Text(viewModel.title)
                .font(.system(size: 24, weight: .bold))
            Spacer()
        }
    }
    
    // MARK: - Author View
    
    @ViewBuilder
    var authorHeaderSubView: some View {
        HStack {
            Image("")
                .frame(width: 30, height: 30)
                .background(Color.gray)
                .cornerRadius(20)
            Text(viewModel.author)
                .font(.system(size: 12, weight: .light))
            Spacer()
        }
    }
    
    // MARK: - Description View
    
    @ViewBuilder
    var summaryView: some View {
        HStack {
            
            VStack(alignment: .leading) {
                Text("Prep Time")
                    .font(.system(size: 12))
                Text(viewModel.prepTime)
            }
            Spacer()
            VStack(alignment: .leading) {
                Text("Cook Time")
                    .font(.system(size: 12))
                Text(viewModel.cookTime)
            }
            Spacer()
            VStack(alignment: .leading) {
                Text("Difficulty")
                    .font(.system(size: 12))
                Text(viewModel.difficulty)
            }
            Spacer()
        }
    }
    
    // MARK: - Image View
    
    @ViewBuilder
    var itemImageView: some View {
        Image("")
            .frame(height: 400)
            .frame(maxWidth: .infinity)
            .background(Color.gray)
            .cornerRadius(4)
        
    }
    
    // MARK: - Description View
    
    @ViewBuilder
    var descriptionView: some View {
        VStack {
            HStack {
                Text("About")
                    .font(.system(size: 18))
                Spacer()
            }
            HStack {
                Text(viewModel.description)
                    .font(.system(size: 12))
                Spacer()
            }
        }
    }
    
    // MARK: - Ingredients View
    
    @ViewBuilder
    var ingredientsView: some View {
        VStack(spacing: 8) {
            HStack {
                Text("Ingredients")
                    .font(.system(size: 24, weight: .medium))
                Spacer()
            }
            HStack {
                Button {
                    viewModel.decrementServeCount()
                } label: {
                    Image(systemName: "minus.circle")
                        .foregroundColor(.primary)
                }
                
                Text("\(viewModel.serveCount) serves")
                
                Button {
                    viewModel.incrementServeCount()
                } label: {
                    
                    Image(systemName: "plus.circle")
                        .foregroundColor(.primary)
                }
                
                Spacer()
                
            }
            
            ForEach(0..<2) { i in
                
                // TODO: Create function view builder to pass parameters
                HStack {
                    Text("Heading")
                        .font(.system(size: 18, weight: .medium))
                    Spacer()
                }
                
                
                // TODO: Create function view builder to pass parameters
                HStack(spacing: 8) {
                    Image("")
                        .frame(width: 30, height: 30)
                        .background(Color.gray)
                        .cornerRadius(15)
                    VStack {
                        HStack(spacing: 5) {
                            Text("4 slices")
                                .font(.system(size: 14, weight: .bold))
                            
                            Text("apple")
                                .font(.system(size: 14))
                            Spacer()
                        }
                        
                        HStack {
                            Text("prep notes")
                                .font(.system(size: 12))
                            Spacer()
                        }
                    }
                    Spacer()
                }
                .padding(.horizontal, 8)
                
            }
        }
    }
    
    // MARK: - Methods View
    
    @ViewBuilder
    var methodsView: some View {
        VStack(spacing: 8) {
            HStack {
                Text("Method")
                    .font(.system(size: 24, weight: .medium))
                Spacer()
            }
            
            // TODO: Create function view builder to pass parameters
            HStack {
                Text("Heading")
                    .font(.system(size: 18, weight: .medium))
                Spacer()
            }
            
            ForEach(0..<3) { i in
                
                // TODO: Create function view builder to pass parameters
                HStack {
                    Text("Step \(i + 1)")
                        .font(.system(size: 16, weight: .medium))
                    Spacer()
                }
                
                HStack {
                    Text("This is an exmple step. Please see attached for reference.")
                        .font(.system(size: 14))
                    Spacer()
                }
                
            }
        }
    }
    
    // MARK: - Tags View
    
    @ViewBuilder
    var taglistView: some View {
        VStack {
            HStack {
                Text("Tags")
                    .font(.system(size: 18))
                Spacer()
            }
        }
    }
}

struct RecipeDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let user = User(uid: "1234", username: "John")
        let recipe = Recipe(id: "", title: "Sample Title", creator: user, tags: ["Amazing", "Great"])
        RecipeDetailsView(viewModel: RecipeDetailsViewModel(recipe: recipe))
    }
}
