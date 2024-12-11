// Name: Khaled Alshaer
// CWID: 885881623
// Email: Khaled.Alshaer@csu.fullerton.edu

import SwiftUI

struct ContentView: View {
    @AppStorage("redColorValue") var red: Double = 1.0
    @AppStorage("greenColorValue") var green: Double = 0.675
    @AppStorage("blueColorValue") var blue: Double = 0.94
    
    @AppStorage("isRedOn") var isRedOn: Bool = false
    @AppStorage("isGreenOn") var isGreenOn: Bool = true
    @AppStorage("isBlueOn") var isBlueOn: Bool = true

    var body: some View {
        GeometryReader { geometry in
            let isLandscape = geometry.size.width > geometry.size.height
            let frameWidth = isLandscape ? geometry.size.width * 0.45 : geometry.size.width
            let controlWidth = isLandscape ? geometry.size.width * 0.45 : geometry.size.width * 0.9
            Group {
                if isLandscape {
                    HStack(spacing: 20) {
                        colorView
                            .frame(width: frameWidth, height: geometry.size.height * 0.85)
                        VStack {
                            Text("Color Mixer")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .padding(.bottom, 5)
                            controls
                                .frame(width: controlWidth)
                            resetButton
                                .frame(width: controlWidth)
                                .padding(.top, 10)  // Adjust this value if needed
                        }
                    }
                } else {
                    VStack {
                        Text("Color Mixer")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.bottom, 5)
                        colorView
                        controls
                            .frame(width: controlWidth)
                        resetButton
                            .padding(.top, 10)
                    }
                }
            }
            .padding(isLandscape ? .horizontal : .all, 10)
            .animation(.default, value: isLandscape)
        }
    }
    
    var colorView: some View {
        Rectangle()
            .fill(Color(red: isRedOn ? red : 0, green: isGreenOn ? green : 0, blue: isBlueOn ? blue : 0))
            .cornerRadius(20)
            .shadow(radius: 10)
    }
    
    var controls: some View {
        VStack {
            ColorControlView(color: .red, value: $red, isOn: $isRedOn)
            ColorControlView(color: .green, value: $green, isOn: $isGreenOn)
            ColorControlView(color: .blue, value: $blue, isOn: $isBlueOn)
        }
    }
    
    var resetButton: some View {
        Button("RESET") {
            resetValues()
        }
        .padding()
        .background(Color.orange)
        .foregroundColor(.white)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black, lineWidth: 2)
        )
    }
    
    private func resetValues() {
        red = 1.0
        green = 0.675
        blue = 0.94
        isRedOn = false
        isGreenOn = true
        isBlueOn = true
    }
}

struct ColorControlView: View {
    var color: Color
    @Binding var value: Double
    @Binding var isOn: Bool

    var body: some View {
        VStack {
            HStack {
                Toggle(isOn: $isOn) {
                    Text(color.description.capitalized)
                        .frame(width: 100, alignment: .leading)
                }
                .toggleStyle(SwitchToggleStyle(tint: color))
                
                TextField("", value: $value, formatter: NumberFormatter.variableDecimalFormatter)
                    .frame(width: 60, alignment: .trailing)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                    .disabled(!isOn)
            }
            Slider(value: $value, in: 0...1, step: 0.001)
                .disabled(!isOn)
                .accentColor(color)
        }
    }
}

extension NumberFormatter {
    static var variableDecimalFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = 3
        return formatter
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
