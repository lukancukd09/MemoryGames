
import SwiftUI

struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize?
    
    static func reduce(value: inout CGSize?, nextValue: () -> CGSize?) {
        guard let nextValue = nextValue() else { return }
        value = nextValue
    }
}

struct ReadSizeModifier: ViewModifier {
    
    private var sizeView: some View {
        GeometryReader { geometry in
            Color.clear
                .preference(key: SizePreferenceKey.self, value: geometry.size)
        }
    }
    
    func body(content: Content) -> some View {
        content
            .background(sizeView)
    }
}

extension View {
    func readSize(_ complition: @escaping (CGSize?) -> Void) -> some View {
        self
            .modifier(ReadSizeModifier())
            .onPreferenceChange(SizePreferenceKey.self, perform: complition)
    }
    
    func readHeight(_ complition: @escaping (CGFloat?) -> Void) -> some View {
        self
            .modifier(ReadSizeModifier())
            .onPreferenceChange(SizePreferenceKey.self) { complition($0?.height)}
    }
}
