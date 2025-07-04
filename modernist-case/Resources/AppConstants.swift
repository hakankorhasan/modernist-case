//
//  AppConstants.swift
//  modernist-case
//
//  Created by Hakan on 1.07.2025.
//

import CoreFoundation

enum AppConstants {
    
    enum Font {
        static let largeTitle: CGFloat = 34
        static let title: CGFloat = 28
        static let headline: CGFloat = 20
        static let body: CGFloat = 16
        static let caption: CGFloat = 12
    }
    
    enum Padding {
        static let small: CGFloat = 8
        static let medium: CGFloat = 16
        static let large: CGFloat = 24
        static let extraLarge: CGFloat = 32
    }
    
    enum CornerRadius {
        static let small: CGFloat = 4
        static let medium: CGFloat = 8
        static let large: CGFloat = 12
        static let extraLarge: CGFloat = 20
        static let huge: CGFloat = 32
    }
    
    enum Size {
        static let iconSmall: CGFloat = 16
        static let iconMedium: CGFloat = 24
        static let iconLarge: CGFloat = 32
        
        static let buttonHeight48: CGFloat = 48
        static let buttonHeight64: CGFloat = 48
        static let textFieldHeight: CGFloat = 44
        
        static let imageSmall: CGFloat = 40
        static let imageMedium: CGFloat = 60
        static let imageLarge: CGFloat = 100
    }
}
