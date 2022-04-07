//
//  LocationListView.swift
//  SwiftfulMap
//
//  Created by wizz on 2/16/22.
//

import SwiftUI

struct LocationListView: View {
    
    @EnvironmentObject private var viewModel: LocationsViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.locations){ location in
                Button{
                    viewModel.showNextLocation(location: location)
                }label: {
                    listRowView(location: location)
                }
                .padding(.vertical, 4)
                .listRowBackground(Color.clear)
            }
        }
        .listStyle(PlainListStyle())
    }
}

struct LocationListView_Previews: PreviewProvider {
    static var previews: some View {
        LocationListView()
            .environmentObject(LocationsViewModel())
    }
}

extension LocationListView {
    
    private func listRowView(location: Location) -> some View{
        HStack {
            HStack{
                if let imageName = location.imageNames.first {
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 45, height: 45)
                }
                VStack(alignment: .leading){
                    Text(location.name)
                        .font(.headline)
                    Text(location.cityName)
                        .font(.subheadline)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
    
}
