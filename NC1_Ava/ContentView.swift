import SwiftUI


struct ContentView: View {
    @State private var selectedTab = 0
    @State private var a = ""
    @State private var b = ""
    @State private var c = ""
    @State private var akar1 = ""
    @State private var akar2 = ""
    @State private var equation = ""
    @State private var root1: Double? = nil
    @State private var root2: Double? = nil
    @State private var hasil: String = ""

       let tabs = ["Root", "Equation"]
    func calculateRoots() {
        guard let a = Double(self.a),
              let b = Double(self.b),
              let c = Double(self.c)
        else {
            return
        }
        let (root1, root2) = quadraticFormula(a: a, b: b, c: c)
        self.root1 = root1
        self.root2 = root2
    }
    
    func quadraticFormula(a: Double, b: Double, c: Double) -> (Double?, Double?) {
        let discriminant = b * b - 4 * a * c
        if discriminant < 0 {
            return (nil, nil)
        } else {
            let root1 = (-b + sqrt(discriminant)) / (2 * a)
            let root2 = (-b - sqrt(discriminant)) / (2 * a)
            return (root1, root2)
        }
    }
    
    func solveQuadraticEquation() -> String{
        guard let akar1 = Double(self.akar2),
              let akar2 = Double(self.akar2)
                
        else {
            let akar1 = String(akar1)
            let akar2 = String(akar2)
            let equation = "isi dulu"
            return (equation)
        }
        let a = 1.0
        let b = -1 * (akar1 + akar2)
        let c = akar1 * akar2
        //        return "\(a)x^2 + (\(b))x + (\(c)) = 0"}
        
        
        if b > 0.0 && c > 0.0{
            return "\(a)x^2 + \(b)x + \(c) = 0"
        }
        else if b < 0.0 && c > 0.0{
            let b = b * -1
            return "\(a)x^2 - \(b)x + \(c) = 0"
        }
        else if b > 0.0 && c < 0.0 {
            let c = c * -1
            return "\(a)x^2 + \(b)x - \(c) = 0"
        }
        else if b < 0.0 && c < 0.0 {
            let b = b * -1
            let c = c * -1
            return "\(a)x^2 - \(b)x - \(c) = 0"
        }
        else {
            let c = c * -1
            return "\(a)x^2 - \(c) = 0"
        }
    }

    var body: some View {
        NavigationStack{
            VStack {
                
                Picker(selection: $selectedTab, label: Text("Tabs")) {
                    ForEach(0..<tabs.count) { index in
                        Text(tabs[index])
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                switch selectedTab {
                case 0:
                    Form{
                        Section(header: Text("Masukkan ABC")){
                            Text("Bentuk persamaan Ax^2 + Bx + C")
                            VStack(alignment: .center) {
                                TextField("Enter a", text: $a)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                TextField("Enter b", text: $b)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                TextField("Enter c", text: $c)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                            }
                            
                        }
                        Section {
                            Button {
                              calculateRoots()
                            } label: {
                                Text("Find Roots")
                                    .frame(maxWidth: .infinity)
                                    .font(.title2)
                                
                            }
                            
                        }
                        Section{
                            HStack{
                                    Text(" Root 1 : \(root1 ?? 0, specifier: "%.2f") ")
                                    Spacer()
                                    Text(" Root 2 : \(root2 ?? 0, specifier: "%.2f")")
                                
                                 }
                        }
                        
                        
                    }
                    .scrollContentBackground(.hidden)

                case 1:
                    Form{
                        Section(header: Text("Find The Equation")){
                            
                            Text("Enter The Roots")
                            VStack(alignment: .center) {
                                TextField("Enter X1", text: $akar1)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                TextField("Enter X2", text: $akar2)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                            }
                            
                        }
                        Section {
                            Button {
                                hasil = solveQuadraticEquation()
                            } label: {
                                Text("Make an Equation")
                                    .frame(maxWidth: .infinity)
                                    .font(.title2)
                                
                            }
                            
                        }
                        Section{
                            if hasil == ""{
                                Text("There's No Equation")
                                    .frame(maxWidth: .infinity)
                                    .font(.title2)
                            }else{
                                Text(hasil)
                                    .frame(maxWidth: .infinity)
                                    .font(.title2)
                            }
                            
                        }
                    }
                    .scrollContentBackground(.hidden)
                    
                default:
                    Text("Something went wrong.")
                }
                
                Spacer()
            }
            
            .navigationTitle("QuadRoots")
            .padding()
            .background(.quaternary)
        }
        
        
      
    }
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
