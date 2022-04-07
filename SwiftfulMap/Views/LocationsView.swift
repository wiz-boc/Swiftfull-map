//
//  LocationsView.swift
//  SwiftfulMap
//
//  Created by wizz on 2/13/22.
//

import SwiftUI
import MapKit

struct LocationsView: View {
    
    @EnvironmentObject private var viewModel: LocationsViewModel
    let maxWidthForIpad: CGFloat = 700
    var body: some View {
        ZStack{
            
            mapLayer
                .ignoresSafeArea()
            
            VStack(spacing: 0){
                header
                .padding()
                .frame(maxWidth: maxWidthForIpad)
                Spacer()
                locationsPreviewStack
                
            }
        }
        .sheet(item: $viewModel.sheetLocation, onDismiss: nil) { location in
            LocationDetailView(location: location)
        }
    }
}

struct LocationsView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsView()
            .environmentObject(LocationsViewModel())
    }
}

extension LocationsView {
    private var header: some View {
        VStack{
            VStack {
                
                Button {
                    viewModel.toggleLocationsList()
                } label: {
                    Text(viewModel.mapLocation.name + ", " + viewModel.mapLocation.cityName)
                        .font(.title2)
                        .fontWeight(.black)
                        .foregroundColor(.primary)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .animation(.none, value: viewModel.mapLocation)
                        .overlay(alignment: .leading) {
                            Image(systemName: "arrow.down")
                                .font(.headline)
                                .foregroundColor(.primary)
                                .padding()
                                .rotationEffect(Angle(degrees: viewModel.showLocationsList ? 180 : 0))
                        }
                }

                if viewModel.showLocationsList {
                    LocationListView()
                }
            }
            .background(.thinMaterial)
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 15)
        }
    }
    
    private var mapLayer: some View{
        Map(coordinateRegion: $viewModel.mapRegion,
            annotationItems: viewModel.locations,
            annotationContent: { location in
            //MapMarker(coordinate: location.coordinates, tint: .green)
            MapAnnotation(coordinate: location.coordinates) {
                LocationMapAnnotationView()
                    .scaleEffect(viewModel.mapLocation == location ? 1 : 0.7)
                    .shadow(radius: 10)
                    .onTapGesture {
                        viewModel.showNextLocation(location: location)
                    }
            }
        })
    }
    
    private var locationsPreviewStack: some View {
        ZStack{
            ForEach(viewModel.locations){ location in
                
                if viewModel.mapLocation == location {
                LocationPreviewView(location: location)
                    .shadow(color: .black.opacity(0.3), radius: 20)
                    .padding()
                    .frame(maxWidth: maxWidthForIpad)
                    .frame(maxWidth: .infinity)
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                }
            }
        }
    }
}
