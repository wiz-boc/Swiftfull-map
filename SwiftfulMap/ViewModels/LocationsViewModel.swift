//
//  LocationsViewModel.swift
//  SwiftfulMap
//
//  Created by wizz on 2/13/22.
//

import Foundation
import MapKit
import SwiftUI


class LocationsViewModel: ObservableObject {
    
    //All loaded locations
    @Published var locations: [Location]
    
    //Current location on map
    @Published var mapLocation: Location {
        didSet {
            updateMapRegion(location: mapLocation)
        }
    }
    
    //Current region on map
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    let mapSan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    //Show list of locations
    @Published var showLocationsList: Bool = false
    @Published var sheetLocation: Location? = nil
    
    init(){
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation = locations.first!
        self.updateMapRegion(location: locations.first!)
    }
    
    private func updateMapRegion(location: Location){
        withAnimation {
            mapRegion = MKCoordinateRegion(center: location.coordinates, span: mapSan)
        }
    }
    func toggleLocationsList(){
        withAnimation(.easeInOut) {
            showLocationsList.toggle()
        }
    }
    
    func showNextLocation(location: Location){
        withAnimation(.easeInOut) {
            mapLocation = location
            showLocationsList = false
        }
    }
    
    func nextButtonPressed(){
        //Get the current index
        
        guard let currentIndex = locations.firstIndex(where: { $0 == mapLocation }) else {
            print("Could not find current location")
            return
        }
        //Check if the currentIndex is value
        let nextIndex = (currentIndex + 1) % locations.count
        let nextLocation = locations[nextIndex]
        showNextLocation(location: nextLocation)
    }
}
