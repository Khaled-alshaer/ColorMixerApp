// Name: Khaled Alshaer
// CWID: 885881623
// Email: Khaled.Alshaer@csu.fullerton.edu

import SwiftUI

struct ContentView: View {
    @AppStorage("redColorValue") var red: Double = 0.314
    @AppStorage("greenColorValue") var green: Double = 0.746
    @AppStorage("blueColorValue") var blue: Double = 1.000
    
    @AppStorage("isRedOn") var isRedOn: Bool = true
    @AppStorage("isGreenOn") var isGreenOn: Bool = true
    @AppStorage("isBlueOn") var isBlueOn: Bool = true

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("Color Mixer")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()

                Rectangle()
                    .fill(Color(red: isRedOn ? red : 0, green: isGreenOn ? green : 0, blue: isBlueOn ? blue : 0))
                    .frame(height: geometry.size.height * 0.3) // 30% of the available height
                    .cornerRadius(20)
                    .shadow(radius: 10)
                    .padding(.horizontal)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.black, lineWidth: 2)
                    )

                VStack {
                    ColorSlider(color: .red, value: $red, isOn: $isRedOn)
                    ColorSlider(color: .green, value: $green, isOn: $isGreenOn)
                    ColorSlider(color: .blue, value: $blue, isOn: $isBlueOn)
                }
                .padding()

                Spacer()

                Button("RESET") {
                    resetValues()
                }
                .buttonStyle(ResetButtonStyle())
                .padding(.horizontal)
                .padding(.bottom)
            }
        }
    }

    private func resetValues() {
        red = 0.314
        green = 0.746
        blue = 1.000
        isRedOn = true
        isGreenOn = true
        isBlueOn = true
    }
}

struct ColorSlider: View {
    var color: Color
    @Binding var value: Double
    @Binding var isOn: Bool

    var body: some View {
        HStack {
            Text(color.description.capitalized)
            Toggle(isOn: $isOn) {
                EmptyView()
            }
            .labelsHidden()
            .toggleStyle(SwitchToggleStyle(tint: color))
            Slider(value: $value, in: 0...1)
                .accentColor(color)
            Text(String(format: "%.3f", value))
        }
    }
}

struct ResetButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.orange)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(radius: 5)
    }
}
